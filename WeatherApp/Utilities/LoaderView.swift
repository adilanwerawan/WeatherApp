//
//  LoaderView.swift
//  WeatherApp
//
//  Created by MacBook on 22/05/2022.
//

import Foundation
import SwiftUI

// Progress loader like activity indicator
struct LoaderView: View {
    var tintColor: Color = .blue
    var scaleSize: CGFloat = 1.0
    
    var body: some View {
        ProgressView()
            .scaleEffect(scaleSize, anchor: .center)
            .progressViewStyle(CircularProgressViewStyle(tint: tintColor))
    }
}
