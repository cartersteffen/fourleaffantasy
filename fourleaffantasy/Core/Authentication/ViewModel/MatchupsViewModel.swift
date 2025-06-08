//
//  MatchupsView-ViewModel.swift
//  genius gamblers
//
//  Created by Carter Steffen on 3/3/24.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift


class MatchupsViewModel: ObservableObject {
    
    init() {
        
    }
    
    @Published var matchups = [MatchupRow]()
    @Published var allMatchups = [Matchup]()
    @Published var historicalMatchups: [Matchup] = []
    @Published var selectedWeek: Int = 1
    @Published var currentWeek: Int = 1
    let totalWeeks = 18 // NFL regular season
    // NFL 2024 season start date (example: Sep 5, 2024)
    let seasonStartDate: Date = {
        guard let date = Calendar.current.date(from: DateComponents(year: 2024, month: 9, day: 5)) else {
            fatalError("Invalid date components for season start date")
        }
        return date
    }()
    let firstSeasonYear = 2021 // Change as needed

    // Calculate the current NFL week based on today's date and last week's games
    func updateCurrentWeek() {
        let now = Date()
        let calendar = Calendar.current
        let week = calendar.dateComponents([.weekOfYear], from: seasonStartDate, to: now).weekOfYear ?? 0
        let calculatedWeek = min(max(week + 1, 1), totalWeeks)
        // Check if all games from last week have passed
        let lastWeekGames = allMatchups.filter { weekForDate($0.commence_time) == calculatedWeek - 1 }
        if !lastWeekGames.isEmpty,
           lastWeekGames.allSatisfy({
                if let gameDate = dateFromISO($0.commence_time) {
                    return gameDate < now
                } else {
                    return false
                }
           }) {
            currentWeek = min(calculatedWeek, totalWeeks)
        } else {
            currentWeek = max(calculatedWeek - 1, 1)
        }
        selectedWeek = currentWeek
    }

    func weekForDate(_ isoString: String) -> Int {
        guard let date = dateFromISO(isoString) else { return 1 }
        let week = Calendar.current.dateComponents([.weekOfYear], from: seasonStartDate, to: date).weekOfYear ?? 0
        return min(max(week + 1, 1), totalWeeks)
    }

    func dateFromISO(_ isoString: String) -> Date? {
        let formatter = ISO8601DateFormatter()
        return formatter.date(from: isoString)
    }

    func fetchMatchups() async {
        do {
            let url = URL(string: "https://api.the-odds-api.com/v4/sports/americanfootball_nfl/odds?apiKey=\(apiKey)&regions=eu&markets=h2h%2Cspreads%2Ctotals&dateFormat=iso&oddsFormat=american&bookmakers=pinnacle")!
            let (data, _) = try await URLSession.shared.data(from: url)
            let decodedResponse = try JSONDecoder().decode([Matchup].self, from: data)
            DispatchQueue.main.async {
                self.allMatchups = decodedResponse
                self.updateCurrentWeek()
                self.filterMatchupsForSelectedWeek()
            }
        } catch {
            print("Failed to fetch matchups: \(error)")
        }
    }

    func filterMatchupsForSelectedWeek() {
        let weekMatchups = allMatchups.filter { self.weekForDate($0.commence_time) == selectedWeek }
        self.matchups = weekMatchups.map { self.mapMatchupToMatchupRow(matchup: $0) }
    }

    func selectWeek(_ week: Int) {
        selectedWeek = week
        filterMatchupsForSelectedWeek()
    }

    func mapMatchupToMatchupRow(matchup: Matchup) -> MatchupRow {
        let id = matchup.id
        let title = "\(getLastWord(of: matchup.away_team)) at \(getLastWord(of: matchup.home_team))"
        let homeLogo: String? = nflLogos[matchup.home_team]
        let awayLogo: String? = nflLogos[matchup.away_team]
        let commenceTime = formatCommenceTime(matchup.commence_time)
        var homeSpread: String = "-"
        var awaySpread: String = "-"
        var homeMoneyline: String = "-"
        var awayMoneyline: String = "-"
        var overUnder: String = "-"

        // Safely get the first bookmaker and its markets
        if let bookmaker = matchup.bookmakers?.first,
           let markets = bookmaker.markets, !markets.isEmpty {
            // Find spread market
            if let spreadMarket = markets.first(where: { $0.key == "spreads" }) {
                if let homeOutcome = spreadMarket.outcomes.first(where: { $0.name == matchup.home_team }) {
                    homeSpread = String(homeOutcome.point ?? 0.0)
                }
                if let awayOutcome = spreadMarket.outcomes.first(where: { $0.name == matchup.away_team }) {
                    awaySpread = String(awayOutcome.point ?? 0.0)
                }
            }
            // Find moneyline market
            if let moneylineMarket = markets.first(where: { $0.key == "h2h" }) {
                if let homeOutcome = moneylineMarket.outcomes.first(where: { $0.name == matchup.home_team }) {
                    homeMoneyline = String(format: "%g", homeOutcome.price)
                }
                if let awayOutcome = moneylineMarket.outcomes.first(where: { $0.name == matchup.away_team }) {
                    awayMoneyline = String(format: "%g", awayOutcome.price)
                }
            }
            // Find totals market
            if let totalsMarket = markets.first(where: { $0.key == "totals" }) {
                if let overOutcome = totalsMarket.outcomes.first(where: { $0.name.lowercased().contains("over") }) {
                    overUnder = String(overOutcome.point ?? 0.0)
                }
            }
        }

        return MatchupRow(
            id: id,
            title: title,
            homeLogo: homeLogo,
            awayLogo: awayLogo,
            commenceTime: commenceTime,
            homeSpread: homeSpread,
            awaySpread: awaySpread,
            homeMoneyline: homeMoneyline,
            awayMoneyline: awayMoneyline,
            overUnder: overUnder
        )
    }

    func fetchHistoricalMatchups() async {
        var all: [Matchup] = []
        let now = Date()
        let calendar = Calendar.current
        let currentYear = calendar.component(.year, from: now)
        let currentWeek = self.currentWeek
        for year in firstSeasonYear...currentYear {
            let seasonStart = calendar.date(from: DateComponents(year: year, month: 9, day: 5))! // Adjust if needed
            let weeks = (year == currentYear) ? currentWeek : totalWeeks
            for week in 1...weeks {
                let weekStart = calendar.date(byAdding: .weekOfYear, value: week - 1, to: seasonStart)!
                let weekEnd = calendar.date(byAdding: .day, value: 6, to: weekStart)!
                if let matchups = await fetchMatchupsForDateRange(from: weekStart, to: weekEnd) {
                    all.append(contentsOf: matchups)
                }
            }
        }
        DispatchQueue.main.async {
            self.historicalMatchups = all
        }
    }

    private func fetchMatchupsForDateRange(from: Date, to: Date) async -> [Matchup]? {
        let formatter = ISO8601DateFormatter()
        let fromString = formatter.string(from: from)
        let toString = formatter.string(from: to)
        let urlString = "https://api.the-odds-api.com/v4/sports/americanfootball_nfl/odds?apiKey=\(apiKey)&regions=eu&markets=h2h%2Cspreads%2Ctotals&dateFormat=iso&oddsFormat=american&bookmakers=pinnacle&commenceTimeFrom=\(fromString)&commenceTimeTo=\(toString)"
        guard let url = URL(string: urlString) else { return nil }
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let decoded = try JSONDecoder().decode([Matchup].self, from: data)
            return decoded
        } catch {
            print("Failed to fetch matchups for range: \(error)")
            return nil
        }
    }

    var apiKey = "d4ee58cd92b1094e968c02176cd1bf60" // Replace with your actual API key

}
