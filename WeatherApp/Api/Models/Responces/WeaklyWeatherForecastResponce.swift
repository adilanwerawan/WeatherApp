//
//  WeaklyWeatherForecastResponce.swift
//  weatherapp
//
//  Created by MacBook on 21/05/2022.
//

import Foundation

struct WeeklyWeatherForecastResponse:Codable{
    let list: [Item]
    
    struct Item: Codable {
      let date: Date
      let main: MainTemp
      let weather: [Weather]
      
      enum CodingKeys: String, CodingKey {
        case date = "dt"
        case main
        case weather
      }
    }
    
    struct MainTemp: Codable {
      let temp: Double
    }
    
    struct Weather: Codable {
      let main: MainEnumValues
      let weatherDescription: String
      
      enum CodingKeys: String, CodingKey {
        case main
        case weatherDescription = "description"
      }
    }
    
    enum MainEnumValues: String, Codable {
      case clear = "Clear"
      case clouds = "Clouds"
      case rain = "Rain"
    }
}
