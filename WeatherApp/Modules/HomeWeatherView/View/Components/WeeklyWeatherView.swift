//
//  WeeklyWeatherView.swift
//  WeatherApp
//
//  Created by MacBook on 21/05/2022.
//

import SwiftUI

struct WeeklyWeatherView: View {
    @State var rowViewModels:[WeeklyWeatherRowViewModel]
    
    var body: some View {
        VStack{
            Spacer()
            List{
                ForEach(rowViewModels) { model in
                    HStack{
                        DailyWeatherRow(viewModel: model)
                            .padding()
                    }
                    .background(Color.white)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .onAppear(){
                        print("weather : \(model.shortWeatherName)")
                    }
                }
                .listRowBackground(Color.clear)
            }
            .listStyle(.plain)
            Spacer()
        }
    }
}
