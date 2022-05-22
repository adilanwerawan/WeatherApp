//
//  TodaysWeatherViewViewModel.swift
//  WeatherApp
//
//  Created by MacBook on 21/05/2022.
//

import Foundation

class TodaysWeatherViewModel:ObservableObject {
    @Published internal var weather: TodaysWeatherForecastResponse? = nil
    
    init() {
    }
    
    func setWeatherData(todayWeather: TodaysWeatherForecastResponse){
        self.weather = todayWeather
    }
    
    var city: String {
        if let weather = weather{
            return weather.name
        }
        return "--"
    }
    
    var weatherDescription:String{
        if let weather = weather {
            return weather.weather[0].descriptionField
        }
        return "--"
    }
    
    var temperature: String {
        if let weather = weather{
            return String(format: "%.1f", weather.main.temp)
        }
        return "--"
    }
    
    var maxTemperature: String {
        if let weather = weather{
            return String(format: "%.1f", weather.main.tempMax)
        }
        return "--"
    }
    
    var minTemperature: String {
        if let weather = weather{
            return String(format: "%.1f", weather.main.tempMin)
        }
        return "--"
    }
    
    var humidity: String {
        if let weather = weather{
            return String(format: "%.1f", weather.main.humidity)
        }
        return "--"
    }
}
