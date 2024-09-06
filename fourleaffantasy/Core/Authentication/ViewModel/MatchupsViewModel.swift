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
    var apiKey = "d4ee58cd92b1094e968c02176cd1bf60"
    
    func fetchMatchups() async {
        do {
            let url = URL(string: "https://api.the-odds-api.com/v4/sports/americanfootball_nfl/odds?apiKey=\(apiKey)&regions=eu&markets=h2h%2Cspreads%2Ctotals&dateFormat=iso&oddsFormat=american&bookmakers=pinnacle&commenceTimeFrom=\(getCurrentTime())&commenceTimeTo=\(getCurrentTimePlusSevenDays())")!
            let (data, _) = try await URLSession.shared.data(from: url)
            let decodedResponse = try JSONDecoder().decode([Matchup].self, from: data)
            let matchupRows: [MatchupRow] = decodedResponse.map { self.mapMatchupToMatchupRow(matchup: $0) }
            DispatchQueue.main.async {
                self.matchups = matchupRows
            }
        } catch {
            print("Failed to fetch matchups: \(error)")
        }
    }
    
    func mapMatchupToMatchupRow(matchup: Matchup) -> MatchupRow {
        let id = matchup.id
        let title = "\(getLastWord(of: matchup.away_team)) at \(getLastWord(of: matchup.home_team))"
        let homeLogo: String? = nflLogos[matchup.home_team]
        let awayLogo: String? = nflLogos[matchup.away_team]
        let commenceTime = formatCommenceTime(matchup.commence_time)
        var homeSpread: String = "0.0"
        var awaySpread: String = "0.0"

        // Assuming the first bookmaker and market contain the needed data
        if let secondMarket = matchup.bookmakers?.first?.markets?[1] {
            homeSpread = String(secondMarket.outcomes.first(where: { $0.name == matchup.home_team })?.point ?? 0.0)
            awaySpread = String(secondMarket.outcomes.first(where: { $0.name == matchup.away_team })?.point ?? 0.0)
        }
        let homeMoneyline = String(matchup.bookmakers?.first?.markets?.first?.outcomes.first(where: { $0.name == matchup.home_team })?.price ?? 0.0)
        let awayMoneyline = String(matchup.bookmakers?.first?.markets?.first?.outcomes.first(where: { $0.name == matchup.away_team })?.price ?? 0.0)
        let overUnder = String(matchup.bookmakers?.first?.markets?.last?.outcomes.first?.point ?? 0)

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

}
