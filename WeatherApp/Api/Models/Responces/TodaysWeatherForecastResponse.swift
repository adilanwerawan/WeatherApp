//
//  DayWeatherForecastResponse.swift
//  weatherapp
//
//  Created by MacBook on 21/05/2022.
//

import Foundation

struct TodaysWeatherForecastResponse : Codable {
    
    let base : String
    let cod : Int
    let coord : Coord
    let dt : Int
    let id : Int
    let main : Main
    let name : String
    let sys : Sy
    let timezone : Int
    let visibility : Int
    let weather : [Weather]
    
    enum CodingKeys: String, CodingKey {
        case base = "base"
        case cod = "cod"
        case coord
        case dt = "dt"
        case id = "id"
        case main
        case name = "name"
        case sys
        case timezone = "timezone"
        case visibility = "visibility"
        case weather = "weather"
    }
}

struct Sy : Codable {
    
    let country : String
    let id : Int
    let sunrise : Int
    let sunset : Int
    let type : Int
    
    enum CodingKeys: String, CodingKey {
        case country = "country"
        case id = "id"
        case sunrise = "sunrise"
        case sunset = "sunset"
        case type = "type"
    }
}

struct Main : Codable {
    
    let feelsLike : Float
    let humidity : Int
    let pressure : Int
    let temp : Float
    let tempMax : Float
    let tempMin : Float
    
    enum CodingKeys: String, CodingKey {
        case feelsLike = "feels_like"
        case humidity = "humidity"
        case pressure = "pressure"
        case temp = "temp"
        case tempMax = "temp_max"
        case tempMin = "temp_min"
    }
}

struct Coord : Codable {
    
    let lat : Float
    let lon : Float
    
    enum CodingKeys: String, CodingKey {
        case lat = "lat"
        case lon = "lon"
    }
}

struct Weather : Codable {
    
    let descriptionField : String
    let icon : String
    let id : Int
    let main : String
    
    enum CodingKeys: String, CodingKey {
        case descriptionField = "description"
        case icon = "icon"
        case id = "id"
        case main = "main"
    }
}

