//
//  DataBaseManager.swift
//  WeatherApp
//
//  Created by MacBook on 21/05/2022.
//

import Foundation
import RealmSwift

final class DataBaseManager {
    
    private var localDatabase:Realm
    // Intializer dependency injection to intialize Realm instance
    init(database:Realm = try! Realm()){
        localDatabase = database
    }
    
    // Saving weather info into Realm database
    func save(weatherToday: TodaysWeatherForecastResponse?, weeklyWeather:WeeklyWeatherForecastResponse?) {
        
        guard let weatherToday = weatherToday, let weeklyWeather =  weeklyWeather else{
            return
        }
        
        // As we are saving only one weather data ata time
        // so thats why deleting unnecessary object
        if let savedWeather = weatherInDatabase(){
            try! localDatabase.write {
                localDatabase.delete(savedWeather)
            }
        }
        
        let weeklyWeatherArray = List<WeeklyWeatherDBModel>()
        if weeklyWeather.list.count > 0{
            weeklyWeather.list.forEach{
               let week =  WeeklyWeatherDBModel(date: $0.date, weatherShort: $0.weather[0].main.rawValue, weatherDescription: $0.weather[0].weatherDescription, temp: Int($0.main.temp))
                weeklyWeatherArray.append(week)
            }
        }
        
        let weather = TodaysWeatherDBModel(id: weatherToday.id, cityName: weatherToday.name, weatherDescription: weatherToday.weather.description, temprature: weatherToday.main.temp, unit: Settings.unit.rawValue, tempHigh: weatherToday.main.tempMax, tempLow: weatherToday.main.tempMin, weeklyWeather: weeklyWeatherArray)
        
        try! localDatabase.write{
            localDatabase.add(weather)
        }
    }
    // Retrieving weather data from realm database
    func weatherInDatabase() -> TodaysWeatherDBModel?{
        let array = localDatabase.objects(TodaysWeatherDBModel.self)
        if array.count > 0{
            return array.last
        }
        return nil
    }
}
