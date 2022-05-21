//
//  WeatherApiService.swift
//  weatherapp
//
//  Created by MacBook on 21/05/2022.
//

import Foundation
import Combine

enum Duration{
    case weekly
    case todays
}

protocol  WeatherApiServiceProtocol{
    /// Getting weekly weather.
    ///  Taking latitude and longitude as parameters so we can fetch weather of different cities
    func weeklyWeather() -> AnyPublisher<WeeklyWeatherForecastResponse, Error>
    /// Getting daily weather.
    ///  Taking latitude and longitude as parameters so we can fetch weather of different cities
    func todaysWeather() -> AnyPublisher<TodaysWeatherForecastResponse, Error>
}

// MARK: WeatherApiService has been implemented
// Pupose: WeatherApiService is responsible for calling the openweathermap api
// and fethcing the required data and parsing it

final class WeatherApiService:WeatherApiServiceProtocol{
    /*
     lat=25.220144&lon=55.304328 latitude and longitude of dubai by default
     */
    var providedLat:Double = 25.220144 // latitude
    var providedLong:Double = 55.304328 // longitude
    
    func weeklyWeather() -> AnyPublisher<WeeklyWeatherForecastResponse, Error> {
        
        var sessionDataTask:URLSessionDataTask?
        
        let onSubscription:(Subscription) -> Void = {_ in sessionDataTask?.resume()}
        let onCancel:() -> Void = {sessionDataTask?.cancel()}
        
        return Future<WeeklyWeatherForecastResponse, Error>{ [weak self] promise in
            guard let weatherApiRequest = self?.weatherApiURLRequest(endPoint: .forecast) else{
                promise(.failure(ApiServiceError.urlRequest))
                return
            }
            
            sessionDataTask = URLSession.shared.dataTask(with: weatherApiRequest, completionHandler: { (data, _, error) in
                guard let data = data else {
                    if let error = error{
                        promise(.failure(error))
                    }
                    return
                }
                do{
                    let model = try JSONDecoder().decode(WeeklyWeatherForecastResponse.self, from: data)
                    promise(.success(model))
                } catch{
                    promise(.failure(ApiServiceError.decode("Decoding weekly data failed.")))
                }
            })
        }
        .handleEvents(receiveSubscription: onSubscription, receiveCancel: onCancel)
        .receive(on: DispatchQueue.main)
        .eraseToAnyPublisher()
    }
    
    func todaysWeather() -> AnyPublisher<TodaysWeatherForecastResponse, Error> {
        
        var sessionDataTask:URLSessionDataTask?
        
        let onSubscription:(Subscription) -> Void = {_ in sessionDataTask?.resume()}
        let onCancel:() -> Void = {sessionDataTask?.cancel()}
        
        return Future<TodaysWeatherForecastResponse, Error>{ [weak self] promise in
            guard let weatherApiRequest = self?.weatherApiURLRequest(endPoint: .weather) else{
                promise(.failure(ApiServiceError.urlRequest))
                return
            }
            
            sessionDataTask = URLSession.shared.dataTask(with: weatherApiRequest, completionHandler: { (data, _, error) in
                guard let data = data else {
                    if let error = error{
                        promise(.failure(error))
                    }
                    return
                }
                do{
                    let model = try JSONDecoder().decode(TodaysWeatherForecastResponse.self, from: data)
                    promise(.success(model))
                } catch{
                    promise(.failure(ApiServiceError.decode("Decoding weekly data failed.")))
                }
            })
        }
        .handleEvents(receiveSubscription: onSubscription, receiveCancel: onCancel)
        .receive(on: DispatchQueue.main)
        .eraseToAnyPublisher()
    }
}
