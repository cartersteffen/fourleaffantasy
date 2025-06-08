import SwiftUI

struct HistoricalMatchupsListView: View {
    let matchups: [Matchup]
    
    var body: some View {
        ScrollView {
            LazyVStack(spacing: 16) {
                ForEach(matchups, id: \.id) { matchup in
                    HistoricalMatchupCardView(matchup: matchup)
                }
            }
            .padding()
        }
    }
}

struct HistoricalMatchupsListView_Previews: PreviewProvider {
    static var previews: some View {
        let sampleMatchups = [
            Matchup(
                id: "1",
                sport_key: "americanfootball_nfl",
                sport_title: "NFL",
                commence_time: "2023-01-01T20:00:00Z", home_team: "San Francisco 49ers",
                away_team: "Kansas City Chiefs",
                bookmakers: []
            ),
            Matchup(
                id: "2",
                sport_key: "americanfootball_nfl",
                sport_title: "NFL",
                commence_time: "2023-01-08T20:00:00Z", home_team: "Buffalo Bills",
                away_team: "Miami Dolphins",
                bookmakers: []
            )
        ]
        HistoricalMatchupsListView(matchups: sampleMatchups)
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
