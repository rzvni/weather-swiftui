//
//  DayModel.swift
//  weather-swiftui
//
//  Created by roli on 05.06.20.
//  Copyright © 2020 Roland Iana. All rights reserved.
//

import Foundation

struct DayModel: Identifiable {
    var id: Date { timestamp }
    let conditionId: Int
    let temperature: Double
    let timestamp: Date
    
    var temperatureString: String {
        return String(Int(temperature))
    }
    
    var conditionName: String {
        switch conditionId {
        case 200...232:
            return "cloud.bolt"
        case 300...321:
            return "cloud.drizzle"
        case 500...531:
            return "cloud.rain"
        case 600...622:
            return "cloud.snow"
        case 701...781:
            return "cloud.fog"
        case 800:
            return "sun.max"
        case 801...804:
            return "cloud.bolt"
        default:
            return "cloud"
        }
    }
}
