//
//  Settings.swift
//  WeatherApp
//
//  Created by MacBook on 21/05/2022.
//

import Foundation

class Settings{
    enum Unit:String{
        case metric = "metric" // Celsius and wind speed in meter/sec
        case imperial = "imperial" // Fahrenheit and wind speed in miles/hour
    }
    
    // By default Celsius
    static var unit:Unit = .metric
}
