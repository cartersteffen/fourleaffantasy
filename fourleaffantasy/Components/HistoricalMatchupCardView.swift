import SwiftUI

struct HistoricalMatchupCardView: View {
    let matchup: Matchup
    
    var body: some View {
        HStack(alignment: .center, spacing: 16) {
            VStack {
                if let awayLogo = nflLogos[matchup.away_team] {
                    AsyncImage(url: URL(string: awayLogo)) { image in
                        image.resizable().aspectRatio(contentMode: .fit)
                    } placeholder: {
                        ProgressView()
                    }
                    .frame(width: 48, height: 48)
                }
                Text(shortTeamName(matchup.away_team))
                    .font(.headline)
                    .foregroundColor(Color("TextNavy"))
            }
            VStack {
                Text("VS")
                    .font(.title2)
                    .bold()
                    .foregroundColor(Color("TextNavy"))
                Text(formattedDate(matchup.commence_time))
                    .font(.caption)
                    .foregroundColor(Color("TextNavy").opacity(0.7))
            }
            VStack {
                if let homeLogo = nflLogos[matchup.home_team] {
                    AsyncImage(url: URL(string: homeLogo)) { image in
                        image.resizable().aspectRatio(contentMode: .fit)
                    } placeholder: {
                        ProgressView()
                    }
                    .frame(width: 48, height: 48)
                }
                Text(shortTeamName(matchup.home_team))
                    .font(.headline)
                    .foregroundColor(Color("TextNavy"))
            }
        }
        .padding()
        .background(Color("CardSurface"))
        .cornerRadius(16)
        .shadow(color: Color("Background").opacity(0.08), radius: 4, x: 0, y: 2)
    }
    
    func shortTeamName(_ name: String) -> String {
        name.components(separatedBy: " ").last ?? name
    }
    
    func formattedDate(_ iso: String) -> String {
        let formatter = ISO8601DateFormatter()
        if let date = formatter.date(from: iso) {
            let display = DateFormatter()
            display.dateStyle = .medium
            display.timeStyle = .short
            return display.string(from: date)
        }
        return ""
    }
}
