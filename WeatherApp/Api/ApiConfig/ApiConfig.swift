//
//  ApiConfig.swift
//  weatherapp
//
//  Created by MacBook on 21/05/2022.
//

import Foundation

struct ApiConfig{
    static func baseURL() -> String?{
        var plistDict:NSDictionary? = nil
        if let path = Bundle.main.path(forResource: "Info", ofType: "plist"){
            plistDict = NSDictionary(contentsOfFile: path)
            guard let dict = plistDict, let baseURL = dict["SERVER_URL"] as? String else{
                return nil
            }
            return baseURL
        }
        return nil
    }
    
    static var apiKey = "7c075dce98d448e46be888bda42c0418"
    
    enum EndPoints:String{
        case weather = "weather" // today
        case forecast = "forecast" // weekly
    }
}

/* https://api.openweathermap.org/data/2.5/forecast?lat=51.5085&lon=-0.1257&cnt=7&appid=7c075dce98d448e46be888bda42c0418
 */
