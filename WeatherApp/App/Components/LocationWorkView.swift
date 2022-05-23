//
//  LocationWorkViews.swift
//  WeatherApp
//
//  Created by MacBook on 22/05/2022.
//

import SwiftUI
import CoreLocation

/// Purpose : Requesting the location permission from the user
/// 
struct RequestLocationView: View {
    // Created enivronment object for notifying about the authorizationStatus
    @EnvironmentObject var locationViewModel: LocationViewModel
    
    var body: some View {
        VStack {
            Image(systemName: "location.circle")
                .resizable()
                .frame(width: 100, height: 100, alignment: .center)
                .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
            Button(action: {
                locationViewModel.requestPermission()
            }, label: {
                Label("Allow location", systemImage: "location")
            })
            .padding(10)
            .foregroundColor(.white)
            .background(Color.blue)
            .clipShape(RoundedRectangle(cornerRadius: 8))
            VStack(alignment: .center){
                Text("We need your permission of your location for getting weather information.")
                    .multilineTextAlignment(.center)
                    .foregroundColor(.gray)
                    .font(.caption)
            }
            .padding([.leading, .trailing], 25)
        }
    }
}

struct ErrorView: View {
    var errorText: String
    
    var body: some View {
        VStack {
            Image(systemName: "xmark.octagon")
                .resizable()
                .frame(width: 100, height: 100, alignment: .center)
            Text(errorText)
        }
        .padding()
        .foregroundColor(.white)
        .background(Color.red)
        .clipShape(RoundedRectangle(cornerRadius: 12))
    }
}
