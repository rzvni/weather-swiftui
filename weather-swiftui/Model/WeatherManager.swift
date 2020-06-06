//
//  WeatherManager.swift
//  weather-swiftui
//
//  Created by roli on 05.06.20.
//  Copyright © 2020 Roland Iana. All rights reserved.
//

import Foundation

class WeatherManager: ObservableObject  {
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?appid=4dd27096f2d484ba840a70de939cc000&units=metric"
    let weekURL = "https://api.openweathermap.org/data/2.5/onecall?appid=4dd27096f2d484ba840a70de939cc000&units=metric"
    
    @Published var week: [DayModel] = [DayModel]()
    @Published var day: WeatherModel = WeatherModel(conditionId: 0, cityName: "", temperature: 0, condition: "")
    
    func fetchData() {
        fetchWeather(cityName: "Linz")
        fetchWeatherForWeek(latitude: 48.30, longitude: 14.2)
    }
    
    
    func fetchWeather(cityName: String) {
        let urlString = "\(weatherURL)&q=\(cityName)"
        performRequest(with: urlString, week: false)
    }
    
    func fetchWeather(latitude: Double, longitude: Double) {
        let urlString = "\(weatherURL)&lat=\(latitude)&lon=\(longitude)"
        performRequest(with: urlString, week: false)
    }
    
    func fetchWeatherForWeek(latitude: Double, longitude: Double) {
        let urlString = "\(weekURL)&lat=\(latitude)&lon=\(longitude)"
        performRequest(with: urlString, week: true)
    }
    
    func performRequest(with urlString: String, week: Bool) {
        
        //1. Create URL
        if let url = URL(string: urlString) {
            
            //2. Create URLSession
            let session = URLSession(configuration: .default)
            
            //3. Give the session a task
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    print(error)
                    return
                }
                
                if let safeDate = data {
                    if week {
                        if let weather = parseWeek(safeDate) {
                            DispatchQueue.main.async {
                                self.week = weather
                            }
                        }
                    } else {
                        if let weather = parseJSON(safeDate) {
                            DispatchQueue.main.async {
                                self.day = weather
                            }
                        }
                    }
                }
                
                //4. Start the task
                
            }
            task.resume()
        }
        
        func parseJSON(_ weatherData: Data) -> WeatherModel?{
            let decoder = JSONDecoder()
            
            
            do {
                let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
                
                let weather = WeatherModel(
                    conditionId: decodedData.weather![0].id,
                    cityName: decodedData.name!,
                    temperature: decodedData.main!.temp,
                    condition: decodedData.weather![0].description
                    
                    
                    
                )
                return weather
            } catch {
                print(error)
                return nil
            }
        }
        
        func parseWeek(_ weatherData: Data) -> [DayModel]?{
            let decoder = JSONDecoder()
            
            
            do {
                let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
                
                var forecast: [DayModel] = []
                
                for day in decodedData.daily! {
                    let forecastDay = DayModel(conditionId: day.weather[0].id, temperature: day.temp!.day!, timestamp: Date(timeIntervalSince1970: TimeInterval(day.dt!)))
                    forecast.append(forecastDay)
                }
                forecast.removeFirst()
                forecast.removeLast()
                return forecast
            } catch {
                print(error)
                return nil
            }
        }
        
    }
}
