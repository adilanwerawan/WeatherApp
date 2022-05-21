//
//  DayWeatherForecastResponse.swift
//  weatherapp
//
//  Created by MacBook on 21/05/2022.
//

import Foundation

struct TodaysWeatherForecastResponse:Codable{
    
    let coord : Coord?
    let dt : Int?
    let id : Int?
    let main : Main?
    let sys : Sy?
    let name : String?
    let weather : [Weather]?
    
    enum CodingKeys: String, CodingKey {
        
        case coord
        case dt = "dt"
        case id = "id"
        case main
        case name = "name"
        case sys
        case weather = "weather"
    }
}

struct Sy : Codable {
    
    let country : String?
    let id : Int?
    let sunrise : Int?
    let sunset : Int?
    let type : Int?
}


struct Main : Codable {
    
    let feelsLike : Float?
    let humidity : Int?
    let pressure : Int?
    let temp : Float?
    let tempMax : Float?
    let tempMin : Float?
}

struct Coord : Codable {
    
    let lat : Float?
    let lon : Float?
}

struct Weather : Codable {

    let descriptionField : String?
    let icon : String?
    let id : Int?
    let main : String?
}
