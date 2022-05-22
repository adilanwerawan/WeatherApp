//
//  MainContentView.swift
//  WeatherApp
//
//  Created by MacBook on 22/05/2022.
//

import SwiftUI
import CoreLocation

struct ContentView: View {
    
    @StateObject var locationViewModel = LocationViewModel()
    
    var body: some View {
        switch locationViewModel.authorizationStatus {
        case .notDetermined:
            AnyView(RequestLocationView())
                .environmentObject(locationViewModel)
        case .restricted:
            ErrorView(errorText: "Location use is restricted.")
        case .denied:
            ErrorView(errorText: "The app does not have location permissions. Please enable them in settings.")
        case .authorizedAlways, .authorizedWhenInUse:
            
            // Set in user defaults
            MainWeatherView().environmentObject(locationViewModel)
        default:
            Text("Unexpected status")
        }
    }
}

struct MainWeatherView:View{
    
//    @EnvironmentObject var locationViewModel: LocationViewModel
    
    var body: some View {
        HStack{
//            if coordinate?.latitude != nil && coordinate?.longitude != nil{
                let homeViewModel = HomeWeatherViewModel()
                HomeWeatherView(viewModel: homeViewModel)
//            } else {
//                Text("Location not found")
//            }
        }
        .onAppear(){
            
        }
    }
    
//    var coordinate: CLLocationCoordinate2D? {
//        locationViewModel.lastSeenLocation?.coordinate
//    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
