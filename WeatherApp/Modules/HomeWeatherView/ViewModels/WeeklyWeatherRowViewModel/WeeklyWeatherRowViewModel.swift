//
//  WeeklyWeatherViewModel.swift
//  WeatherApp
//
//  Created by MacBook on 21/05/2022.
//

import Foundation

struct WeeklyWeatherRowViewModel:Identifiable {
    private let weather: WeeklyWeatherForecastResponse.Item
    
    internal var id:UUID = UUID()
    
    init(weeklyWeather: WeeklyWeatherForecastResponse.Item) {
        self.weather = weeklyWeather
    }
    
    var temperature: String {
        return String(format: "%.1f", weather.main.temp)
    }
    
    var onlyDate:String{
        return weather.date.onlyDate
    }
    
    var monthNameShort:String{
        return weather.date.dateShortMonth
    }
    
    var shortWeatherName:String{
        return weather.weather[0].main.rawValue
    }
    
    var weatherDescription:String{
        return weather.weather[0].weatherDescription
    }
}

