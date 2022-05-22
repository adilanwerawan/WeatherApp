//
//  TodaysWeatherDBModel.swift
//  WeatherApp
//
//  Created by MacBook on 21/05/2022.
//

import Foundation
import RealmSwift


// TodaysWeatherDBModel is the Database model for saving the todays weather data along with
// weekly weather data

class TodaysWeatherDBModel: Object {
    
    @Persisted var id:Int
    @Persisted var cityName: String
    @Persisted var weatherDescription: String
    @Persisted var temprature: Float
    @Persisted var unit:String
    @Persisted var tempHigh: Float
    @Persisted var tempLow: Float
    @Persisted var weeklyWeather:List<WeeklyWeatherDBModel>
    
    convenience init(id:Int, cityName:String, weatherDescription:String, temprature:Float, unit:String, tempHigh:Float, tempLow:Float, weeklyWeather:List<WeeklyWeatherDBModel>) {
        self.init()
        
        self.id = id
        self.cityName = cityName
        self.weatherDescription = weatherDescription
        self.temprature = temprature
        self.unit = unit
        self.tempHigh = tempHigh
        self.tempLow = tempLow
        self.weeklyWeather = weeklyWeather
    }
}

class WeeklyWeatherDBModel:Object{
    
    @Persisted var date:Date
    @Persisted var weatherShort:String
    @Persisted var weatherDescription:String
    @Persisted var temp:Int
    @Persisted var id:Int? = 0
    
    convenience init(date:Date, weatherShort:String, weatherDescription:String, temp:Int){
        self.init()
        self.date = date
        self.weatherShort = weatherShort
        self.weatherDescription = weatherDescription
        self.temp = temp
    }
}


