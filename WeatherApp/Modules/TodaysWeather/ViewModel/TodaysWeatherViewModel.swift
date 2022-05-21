//
//  TodaysWeatherViewModel.swift
//  WeatherApp
//
//  Created by MacBook on 21/05/2022.
//

import Foundation
import Combine

final class TodaysWeatherViewModel{
    
    private let weatherApiService: WeatherApiServiceProtocol
    private var bindings = Set<AnyCancellable>()
    
    init(weatherApi:WeatherApiService = WeatherApiService()){
        self.weatherApiService = weatherApi
    }
    
}
