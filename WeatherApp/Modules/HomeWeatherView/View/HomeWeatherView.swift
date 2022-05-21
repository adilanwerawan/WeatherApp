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
    
    init(viewModel:HomeWeatherViewModel){
        self.viewModel = viewModel
    }
    
    var body: some View {
        HStack{
            if isTodaysWeatherRecieved{
                let temp = viewModel.todayViewModel!.temperature
                Text("Hello, world! \(temp)")
                    .padding()
            } else{
                Text("Fetching...")
                    .padding()
            }
        }
        .onAppear(){
            self.viewModel.fetchTodayWeatherDetails()
            viewModel.$todayViewModel
                .receive(on: RunLoop.main)
                .sink(receiveValue: { todaysWeatherInfo in
                    if let _ = todaysWeatherInfo{
                        isTodaysWeatherRecieved.toggle()
                    }
                })
                .store(in: &bindings)
        }
    }
}
