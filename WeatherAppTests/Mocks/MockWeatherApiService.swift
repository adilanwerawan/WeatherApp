//
//  MockWeatherApiService.swift
//  WeatherApp
//
//  Created by MacBook on 22/05/2022.
//

import Foundation
import Combine

final class MockWeatherApiService : WeatherApiServiceProtocol{
    
    var callsCount:Int = 0
    
    var todayWeatherResult:Result<TodaysWeatherForecastResponse, Error> = .success(Constants.todaysWeatherData)
    
    var weeklyWeatherResult:Result<WeeklyWeatherForecastResponse, Error> = .success(Constants.weeklyWeatherData)
    
    func todaysWeather() -> AnyPublisher<TodaysWeatherForecastResponse, Error> {
        callsCount += 1
        return todayWeatherResult.publisher.eraseToAnyPublisher()
    }
    
    func weeklyWeather() -> AnyPublisher<WeeklyWeatherForecastResponse, Error> {
        
        callsCount += 1
        return weeklyWeatherResult.publisher.eraseToAnyPublisher()
    }
    
}

extension MockWeatherApiService{
    enum Constants{
        static let todaysWeatherData = TodaysWeatherForecastResponse(base: "", cod: 0, coord: Coord(lat: 1000, lon: 2000), dt: 1001, id: 1, main: Main(feelsLike: 12, humidity: 12, pressure: 1, temp: 10, tempMax: 13, tempMin: 9), name: "Rawalpindi", sys: Sy(country: "Pakistan", id: 1, sunrise: 1, sunset: 1, type: 1), timezone: 5, visibility: 2, weather: [Weather(descriptionField: "Mostly Cloudy", icon: "", id: 1, main: "Cloudy")])
        static let items = [WeeklyWeatherForecastResponse.Item(date: Date(), main: WeeklyWeatherForecastResponse.MainTemp(temp: 32.0), weather: [WeeklyWeatherForecastResponse.Weather(main: .clear, weatherDescription: "clear")])]
        static let weeklyWeatherData = WeeklyWeatherForecastResponse(list: Constants.items)
    }
}
