//
//  ContentView.swift
//  weatherapp
//
//  Created by MacBook on 21/05/2022.
//

import SwiftUI
import Combine

/// Purpose : Preparing the view for todays weather and weekly weather list
///  by using its view model
struct HomeWeatherView: View {
    @ObservedObject var viewModel:HomeWeatherViewModel
    @State var bindings = Set<AnyCancellable>()
    @State var isTodaysWeatherRecieved = false
    @State var isWeeklyWeatherRecieved = false
    
    // Saving user location in UserDefaults
    @AppStorage(UserDefaultKeys.latitude) private var latitude = 0.0
    @AppStorage(UserDefaultKeys.longitude) private var longitude = 0.0
    
    // Initializer dependency injection for HomeWeatherViewModel
    init(viewModel:HomeWeatherViewModel){
        self.viewModel = viewModel
    }
    
    var body: some View {
        ZStack{
            Image("weather-app-bg")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .edgesIgnoringSafeArea(.all)
            VStack{
                // When todays Weather info received from api then build its view
                if isTodaysWeatherRecieved{
                    if UIDevice.current.userInterfaceIdiom == .pad{
                        TodayWeatherView(viewModel: viewModel.todayViewModel)
                            .padding(.top, 300.0)
                    } else {
                        TodayWeatherView(viewModel: viewModel.todayViewModel)
                            .padding(.top, 40.0)
                    }
                    // When weekly Weather info received from api then build its view
                    if isWeeklyWeatherRecieved{
                        if let viewModels = viewModel.weeklyRowViewModels{
                            WeeklyWeatherView(rowViewModels: viewModels)
                                .padding()
                        }
                    }
                    Spacer()
                } else {
                    LoaderView(tintColor: .white, scaleSize: 3.0).padding(.bottom,50)
                }
            }
            .padding(.top, 20.0)
        }
        .onAppear(){
            
        }
        .onDisappear(){
            for binding in bindings{
                binding.cancel()
            }
            bindings.removeAll()
        }
        // This notifcation will be called from the LocationViewModel
        // once the device will get the user location
        .onReceive(NotificationCenter.default.publisher(for: HomeViewNotifications.locationIsUpdated))
        { (output) in
            DispatchQueue.main.async {
                fetchWeatherInfo()
            }
        }
    }
    /*
     Calling the view model for fetching the today and weekly weather data once we have
     the latitude and longitude of the user
     */
    func fetchWeatherInfo(){
        if let lati = LatLong.latitude, let longi = LatLong.longitude, lati != 0, longi != 0{
            self.latitude = lati
            self.longitude = longi
            self.viewModel.fetchTodayWeatherDetails()
            viewModel.todayViewModel.$weather
                .receive(on: RunLoop.main)
                .sink(receiveValue: { todaysWeatherViewModel in
                    // Checking if weather info has been received from api
                    if let _ = todaysWeatherViewModel{
                        isTodaysWeatherRecieved.toggle()
                    }
                })
                .store(in: &bindings)
            viewModel.$weeklyRowViewModels
                .receive(on: RunLoop.main)
                .sink(receiveValue: { rowViewModels in
                    // Checking if weather info has been received from api
                    if let _ = rowViewModels{
                        isWeeklyWeatherRecieved.toggle()
                    }
                })
                .store(in: &bindings)
        }
    }
}
