//
//  TimeUtils.swift
//  fourleaffantasy
//
//  Created by Carter Steffen on 3/17/24.
//

import Foundation

func getCurrentTime() -> String {
    let formatter = ISO8601DateFormatter()
    formatter.formatOptions = [.withInternetDateTime]
    let currentTime = formatter.string(from: Date())
    return currentTime
}

func getCurrentTimePlusSevenDays() -> String {
    var dateComponents = DateComponents()
    dateComponents.day = 7

    let calendar = Calendar.current
    if let futureDate = calendar.date(byAdding: dateComponents, to: Date()) {
        let formatter = ISO8601DateFormatter()
        formatter.formatOptions = [.withInternetDateTime]
        let futureTime = formatter.string(from: futureDate)
        return futureTime
    } else {
        return ""
    }
}

func formatCommenceTime(_ commenceTime: String) -> String {
    // Define the input date format
    let inputFormatter = ISO8601DateFormatter()
    
    // Define the output date format
    let outputFormatter = DateFormatter()
    outputFormatter.dateFormat = "EEEE, MMMM d'th' 'at' h:mm a"
    outputFormatter.locale = Locale(identifier: "en_US_POSIX")
    
    // Convert the input string to a Date object
    if let date = inputFormatter.date(from: commenceTime) {
        // Convert the Date object to the desired output format
        return outputFormatter.string(from: date)
    } else {
        // Return a default message if the input string is not a valid date
        return "Invalid date format"
    }
}
