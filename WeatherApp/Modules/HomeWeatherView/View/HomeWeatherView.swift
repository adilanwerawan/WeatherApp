//
//  ContentView.swift
//  weatherapp
//
//  Created by MacBook on 21/05/2022.
//

import SwiftUI
import Combine

struct HomeWeatherView: View {
    @ObservedObject var viewModel:HomeWeatherViewModel
    @State var bindings = Set<AnyCancellable>()
    @State var isTodaysWeatherRecieved = false
    @State var isWeeklyWeatherRecieved = false
//    @EnvironmentObject var locationViewModel: LocationViewModel
    
    @AppStorage(UserDefaultKeys.latitude) private var latitude = 0.0
    @AppStorage(UserDefaultKeys.longitude) private var longitude = 0.0
    
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
                // When todays Weather info received then build its view
                if isTodaysWeatherRecieved{
                    TodayWeatherView(viewModel: viewModel.todayViewModel)
                        .padding(.top, 40.0)
                    if isWeeklyWeatherRecieved{
                        if let viewModels = viewModel.weeklyRowViewModels{
                            WeeklyWeatherView(rowViewModels: viewModels)
                                .padding()
                        }
                    }
                    Spacer()
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
        .onReceive(NotificationCenter.default.publisher(for: HomeViewNotifications.locationIsUpdated))
        { (output) in
            DispatchQueue.main.async {
                fetchWeatherInfo()
            }
        }
    }
    
    func fetchWeatherInfo(){
        if let lati = LatLong.latitude, let longi = LatLong.longitude, lati != 0, longi != 0{
//                    NotificationCenter.default.removeObserver(self)
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

struct HomeViewNotifications
{
    static let locationIsUpdated = NSNotification.Name("com.samples.weatherapp")
}
