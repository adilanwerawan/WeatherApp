//
//  TodaysWeatherViewViewModel.swift
//  WeatherApp
//
//  Created by MacBook on 21/05/2022.
//

import Foundation

struct TodaysWeatherViewModel {
    private let weather: TodaysWeatherForecastResponse
    
    init(todayWeather: TodaysWeatherForecastResponse) {
        self.weather = todayWeather
    }
    
    var temperature: String {
        return String(format: "%.1f", weather.main.temp)
    }
    
    var maxTemperature: String {
        return String(format: "%.1f", weather.main.tempMax)
    }
    
    var minTemperature: String {
        return String(format: "%.1f", weather.main.tempMin)
    }
    
    var humidity: String {
        return String(format: "%.1f", weather.main.humidity)
    }
}
