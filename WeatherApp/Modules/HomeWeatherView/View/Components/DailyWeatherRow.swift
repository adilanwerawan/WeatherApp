//
//  DailyWeatherRow.swift
//  WeatherApp
//
//  Created by MacBook on 22/05/2022.
//

import Foundation
import SwiftUI

struct DailyWeatherRow: View {
  private let viewModel: WeeklyWeatherRowViewModel
  
  init(viewModel: WeeklyWeatherRowViewModel) {
    self.viewModel = viewModel
  }
  
  var body: some View {
      HStack {
          VStack {
              Text("\(viewModel.onlyDate)")
              Text("\(viewModel.monthNameShort)")
          }
          VStack(alignment: .leading) {
              Text("\(viewModel.shortWeatherName)")
                  .font(.body)
              Text("\(viewModel.weatherDescription)")
                  .font(.footnote)
          }
          .padding(.leading, 8)
          Spacer()
          Text("\(viewModel.temperature)°")
              .font(.title)
      }
  }
}
