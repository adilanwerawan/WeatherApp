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
        List{
            ForEach(rowViewModels) { model in
                HStack{
                    Text("Row 1")
                }
                .onAppear(){
                    print("weather : \(model.shortWeatherName)")
                }
            }
        }
    }
}
