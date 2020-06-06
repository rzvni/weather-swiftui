//
//  WeatherData.swift
//  weather-swiftui
//
//  Created by roli on 05.06.20.
//  Copyright © 2020 Roland Iana. All rights reserved.
//

import Foundation

struct WeatherData: Decodable {
    let name: String?
    let main: Main?
    let weather: [Weather]?
    let daily: [Daily]?
}

struct Main: Decodable {
    let temp: Double
}

struct Weather: Decodable {
    let description: String
    let id: Int
}

struct Daily: Decodable {
    let dt, sunrise, sunset: Int?
    let temp: Temp?
    let pressure, humidity: Int?
    let dewPoint, windSpeed: Double?
    let windDeg: Int?
    let weather: [Weather]
    let clouds: Int?
    let rain: Double?
    let uvi: Double?

}

struct Temp: Decodable {
    let day, min, max, night: Double?
    let eve, morn: Double?
}
