//
//  Odds.swift
//  Four Leaf Fantasy
//
//  Created by Carter Steffen on 2/26/24.
//

import Foundation

struct MatchupRow : Identifiable {
    let id: String
    let title: String
    let homeLogo: String?
    let awayLogo: String?
    let commenceTime: String
    let homeSpread: String
    let awaySpread: String
    let homeMoneyline: String
    let awayMoneyline: String
    let overUnder: String
}
