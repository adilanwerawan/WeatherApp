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
                                .opacity(0)
                        }
                    }
                    Spacer()
                }
            }
            .padding(.top, 20.0)
        }
        .onAppear(){
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
        .onDisappear(){
            for binding in bindings{
                binding.cancel()
            }
            bindings.removeAll()
        }
    }
}
