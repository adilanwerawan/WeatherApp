//
//  TodaysWeatherViewModel+Extension.swift
//  WeatherApp
//
//  Created by MacBook on 21/05/2022.
//

import Foundation
import Combine

extension HomeWeatherViewModel{
    /*
     First view model will call todays weather info and then it will
     fetch weekly weather info
     */
    internal func fetchTodayWeatherDetails(){
        state = .loading
        
        let completionHandler: (Subscribers.Completion<Error>) -> Void = { [weak self]
            completion in
            switch completion{
            case .failure(_):
                self?.state = .error("Failed to fetch the weather data")
            case .finished:
                break
            }
        }
        
        let valueHandler: (TodaysWeatherForecastResponse) -> Void = { [weak self] response in
            self?.todayWeatherModel = response
        }
        
        self.weatherApiService
            .todaysWeather()
            .sink(receiveCompletion: completionHandler, receiveValue: valueHandler)
            .store(in: &bindings)
    }
    
    internal func fetchWeekWeatherDetails(){
        let completionHandler: (Subscribers.Completion<Error>) -> Void = { [weak self]
            completion in
            switch completion{
            case .failure(_):
                self?.state = .error("Failed to fetch the weather data")
            case .finished:
                self?.state = .finishLoading
                break
            }
        }
        
        let valueHandler: (WeeklyWeatherForecastResponse) -> Void = { [weak self] response in
            self?.weeklyWeatherModel = response
        }
        
        self.weatherApiService
            .weeklyWeather()
            .sink(receiveCompletion: completionHandler, receiveValue: valueHandler)
            .store(in: &bindings)
    }
    
    // Preparing weekly weather row view model
    func prepareWeatherRowViewModels(weeklyWeatherReponse:WeeklyWeatherForecastResponse) {
        var rowViewModels = [WeeklyWeatherRowViewModel]()
        weeklyWeatherReponse.list.forEach{
            rowViewModels.append(WeeklyWeatherRowViewModel(weeklyWeather: $0))
        }
        self.weeklyRowViewModels = rowViewModels.removingDuplicates()
    }
    
    // Saving weather data to database
    func saveToDatabase() {
        let dbManager = DataBaseManager()
        dbManager.save(weatherToday: self.todayWeatherModel, weeklyWeather: self.weeklyWeatherModel)
    }
}
