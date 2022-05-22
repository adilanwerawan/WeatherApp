//
//  WeeklyWeatherViewModel.swift
//  WeatherApp
//
//  Created by MacBook on 21/05/2022.
//

import Foundation

struct WeeklyWeatherRowViewModel:Identifiable {
    private let weather: WeeklyWeatherForecastResponse.Item
    
    var id: String {
      return onlyDate + temperature + shortWeatherName
    }
    
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

extension WeeklyWeatherRowViewModel: Hashable {
  static func == (lhs: WeeklyWeatherRowViewModel, rhs: WeeklyWeatherRowViewModel) -> Bool {
    return lhs.onlyDate == rhs.onlyDate
  }

  func hash(into hasher: inout Hasher) {
    hasher.combine(self.onlyDate)
  }
}

