//
//  Date+Extension.swift
//  WeatherApp
//
//  Created by MacBook on 21/05/2022.
//

import Foundation

extension Date{
    var onlyDate :String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd"
        return dateFormatter.string(from: self)
    }
    
    var dateShortMonth :String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM"
        return dateFormatter.string(from: self)
    }
}
