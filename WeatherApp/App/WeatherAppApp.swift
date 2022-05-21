//
//  weatherappApp.swift
//  weatherapp
//
//  Created by MacBook on 21/05/2022.
//

import SwiftUI

@main
struct WeatherAppApp: App {
    var body: some Scene {
        WindowGroup {
            let homeViewModel = HomeWeatherViewModel()
            HomeWeatherView(viewModel: homeViewModel)
        }
    }
}
