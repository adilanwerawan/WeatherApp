//
//  TodaysWeatherViewModel.swift
//  WeatherApp
//
//  Created by MacBook on 21/05/2022.
//

import Foundation
import Combine

// For handling different states of TodaysWeatherViewModel for Api calling
enum HomeWeatherViewModelState:Equatable{
    case loading
    case finishLoading
    case error(String)
}
// MARK: HomeWeatherViewModel is responsible for calling the api and fetching the data
// We are using combine for communication between ViewModel and View
final class HomeWeatherViewModel : ObservableObject{
    
    internal let weatherApiService: WeatherApiServiceProtocol
    
    internal var bindings = Set<AnyCancellable>()
    @Published var state:HomeWeatherViewModelState = .finishLoading
    var todayViewModel:TodaysWeatherViewModel = TodaysWeatherViewModel()
    @Published var weeklyRowViewModels:[WeeklyWeatherRowViewModel]?
    
    var todayWeatherModel:TodaysWeatherForecastResponse? = nil{
        didSet{
            if let todayModel = todayWeatherModel{
                self.todayViewModel.setWeatherData(todayWeather: todayModel)
                fetchWeekWeatherDetails()
            }
        }
    }
    
    var weeklyWeatherModel:WeeklyWeatherForecastResponse? = nil{
        didSet{
            if let weeklyModel = weeklyWeatherModel{
                // Update the weather row view model
                prepareWeatherRowViewModels(weeklyWeatherReponse: weeklyModel)
                // Save to database
                saveToDatabase()
            }
        }
    }
    
    init(weatherApi:WeatherApiServiceProtocol = WeatherApiService()){
        self.weatherApiService = weatherApi
    }
}
