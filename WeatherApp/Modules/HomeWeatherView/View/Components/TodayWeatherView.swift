//
//  TodayWeatherView.swift
//  WeatherApp
//
//  Created by MacBook on 21/05/2022.
//

import SwiftUI

/// Purpose : TodayWeatherView is responsible for showing the current day weather info
///  it is getting this info from its view model
struct TodayWeatherView: View {
    @ObservedObject var viewModel:TodaysWeatherViewModel
    var body: some View {
        VStack(alignment: .center, spacing: 3.0){
            Text(viewModel.city)
                .font(.system(size: 30, weight: .bold))
            Text(viewModel.weatherDescription)
                .font(.system(size: 23, weight: .medium))
            Text("\(viewModel.temperature)°")
                .font(.system(size: 30, weight: .bold))
            HStack(spacing: 5.0){
                // H means high temprature
                // L means low temprature
                Text("H:\(viewModel.maxTemperature)°")
                Text("L:\(viewModel.minTemperature)°")
            }
        }
    }
}

