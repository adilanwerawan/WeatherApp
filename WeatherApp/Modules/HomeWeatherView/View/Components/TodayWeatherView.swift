//
//  TodayWeatherView.swift
//  WeatherApp
//
//  Created by MacBook on 21/05/2022.
//

import SwiftUI

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
                Text("H:\(viewModel.maxTemperature)°")
                Text("L:\(viewModel.minTemperature)°")
            }
        }
    }
}

