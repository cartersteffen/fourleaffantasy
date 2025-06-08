import SwiftUI

struct MatchupsRowView: View {
    let matchup: MatchupRow
    
    var body: some View {
        VStack {
            Text(matchup.title)
                .font(.title)
                .foregroundColor(Color("TextNavy"))
                .padding(.bottom, 5)
            
            Text(matchup.commenceTime)
                .font(.subheadline)
                .foregroundColor(Color("TextNavy").opacity(0.7))
                .padding(.bottom, 10)
            
            HStack {
                if let awayLogo = matchup.awayLogo {
                    AsyncImage(url: URL(string: awayLogo)) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                    } placeholder: {
                        ProgressView()
                    }
                    .frame(width: 50, height: 50)
                }
                Spacer()
                VStack(spacing: 0) {
                    // Header
                    Text("SPREAD")
                        .font(.headline)
                        .foregroundColor(Color("TextNavy"))
                        .frame(maxWidth: .infinity, maxHeight: 30)
                        .background(Color("CardSurface"))
                    
                    // Spread Row
                    HStack(spacing: 0) {
                        Text(matchup.awaySpread)
                            .frame(maxWidth: .infinity, maxHeight: 30)
                            .foregroundColor(Color("TextNavy"))
                        Text(matchup.homeSpread)
                            .frame(maxWidth: .infinity, maxHeight: 30)
                            .foregroundColor(Color("TextNavy"))
                    }
                    
                    // Moneyline Header
                    Text("MONEYLINE")
                        .font(.headline)
                        .foregroundColor(Color("TextNavy"))
                        .frame(maxWidth: .infinity, maxHeight: 30)
                        .background(Color("CardSurface"))
                    
                    // Moneyline Row
                    HStack(spacing: 0) {
                        Text(matchup.awayMoneyline)
                            .frame(maxWidth: .infinity, maxHeight: 30)
                            .foregroundColor(Color("TextNavy"))
                        Text(matchup.homeMoneyline)
                            .frame(maxWidth: .infinity, maxHeight: 30)
                            .foregroundColor(Color("TextNavy"))
                    }
                    
                    // Over/Under Header
                    Text("OVER/UNDER")
                        .font(.headline)
                        .foregroundColor(Color("TextNavy"))
                        .frame(maxWidth: .infinity, maxHeight: 30)
                        .background(Color("CardSurface"))
                    
                    // Over/Under Row
                    HStack(spacing: 0) {
                        Text(matchup.overUnder)
                            .frame(maxWidth: .infinity, maxHeight: 30)
                            .foregroundColor(Color("TextNavy"))
                    }
                }
                Spacer()
                if let homeLogo = matchup.homeLogo {
                    
                    AsyncImage(url: URL(string: homeLogo)) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                    } placeholder: {
                        ProgressView()
                    }
                    .frame(width: 50, height: 50)
                }
            }
        }
        .padding()
        .background(Color("CardSurface"))
        .cornerRadius(16)
        .shadow(color: Color("Background").opacity(0.08), radius: 4, x: 0, y: 2)
    }
}

#Preview {
    MatchupsRowView(
        matchup: MatchupRow(
            id: "eca3b71919531e7ae0b4f3f501157e6c",
            title: "Rams at Lions",
            homeLogo: nflLogos["Detroit Lions"],
            awayLogo: nflLogos["Los Angeles Rams"],
            commenceTime: "Sunday January 19 at 7:00 PM",
            homeSpread: "+3.0",
            awaySpread: "-3.0",
            homeMoneyline: "+144",
            awayMoneyline: "-162",
            overUnder: "52.0"
        )
    )
}
