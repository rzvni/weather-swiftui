//
//  ContentView.swift
//  weather-swiftui
//
//  Created by roli on 05.06.20.
//  Copyright © 2020 Roland Iana. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var weatherManager = WeatherManager()
    
    var body: some View {
        ZStack {
            Color(.white)
            .edgesIgnoringSafeArea(.all)
            
            VStack{
                Spacer().frame(height: 30)
                Image(systemName: weatherManager.day.conditionName)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 150, height: 150)
                    
                HStack{
                    Text(String(Int(weatherManager.day.temperature)))
                        .font(.system(size: 80))
                        .fontWeight(.black)
                    Text("°C")
                    .font(.system(size: 100))
                    .fontWeight(.light)
                }
                
                HStack{
                    Text(weatherManager.day.condition)
                        .font(.system(size: 30))
                        .fontWeight(.heavy)
                    Text("today")
                    .font(.system(size: 25))
                    .fontWeight(.medium)
                }
                HStack{
                    Text("in")
                        .font(.system(size: 25))
                        .fontWeight(.medium)
                    Text(weatherManager.day.cityName)
                    .font(.system(size: 40))
                    .fontWeight(.black)
                }
                
                List (weatherManager.week) { day in
                    HStack {
                        Spacer().frame(width: 30)
                        
                        Text(dateToString(date:day.timestamp))
                            .fontWeight(.bold)
                        Spacer()
                        Image(systemName: day.conditionName)
                        Spacer().frame(width: 55)
                        Text(String("\(day.temperatureString)°C"))
                            .font(.system(size: 20))
                        Spacer().frame(width: 30)
                    }

                }.onAppear { UITableView.appearance().separatorStyle = .none }
                .disabled(true)
            }
            
        }.onAppear {
            self.weatherManager.fetchData()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().previewDevice("iPhone X")
        
    }
}


func dateToString(date: Date) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "EEEE"
    return  dateFormatter.string(from: date)
}
