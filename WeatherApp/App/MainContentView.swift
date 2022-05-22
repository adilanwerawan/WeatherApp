//
//  MainContentView.swift
//  WeatherApp
//
//  Created by MacBook on 22/05/2022.
//

import SwiftUI
import CoreLocation

struct ContentView: View {
    // locationViewModel is using corelocation to get the user location
    @StateObject var locationViewModel = LocationViewModel()
    
    var body: some View {
        switch locationViewModel.authorizationStatus {
        case .notDetermined:
            /*
             Showing the request location view
             so user can grant the access to his location
             */
            AnyView(RequestLocationView())
                .environmentObject(locationViewModel)
        case .restricted:
            ErrorView(errorText: "Location use is restricted.")
        case .denied:
            ErrorView(errorText: "The app does not have location permissions. Please enable them in settings.")
        case .authorizedAlways, .authorizedWhenInUse:
            /*
             Once permission has been given open HomeWeatherScreen
             */
            MainWeatherView().environmentObject(locationViewModel)
        default:
            Text("Unexpected status")
        }
    }
}

struct MainWeatherView:View{
    var body: some View {
        HStack{
            let homeViewModel = HomeWeatherViewModel()
            HomeWeatherView(viewModel: homeViewModel)
        }
        .onAppear(){
            
        }
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
