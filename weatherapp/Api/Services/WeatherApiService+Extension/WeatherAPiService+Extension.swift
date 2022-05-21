//
//  WeatherAPiService+Extension.swift
//  weatherapp
//
//  Created by MacBook on 21/05/2022.
//

import Foundation
extension WeatherApiService{
    internal func weatherApiURLRequest(endPoint:ApiConfig.EndPoints) -> URLRequest?{
        
        guard let baseURL = ApiConfig.baseURL(), var urlComponents = URLComponents(string: baseURL + endPoint.rawValue) else {
            return nil
        }
        
        switch endPoint{
        case .forecast:
            // weekly
            urlComponents.queryItems = [
                URLQueryItem(name: "lat", value: String(self.providedLat)),
                URLQueryItem(name: "long", value: String(self.providedLong)),
                URLQueryItem(name: "cnt", value: String(7)),
                URLQueryItem(name: "appid", value: ApiConfig.apiKey)
            ]
            break
        case .weather:
            // todays
            urlComponents.queryItems = [
                URLQueryItem(name: "lat", value: String(self.providedLat)),
                URLQueryItem(name: "long", value: String(self.providedLong)),
                URLQueryItem(name: "appid", value: String(ApiConfig.apiKey))
            ]
            break
        }
        
        guard let url = urlComponents.url else {return nil}
        
        var urlRequest = URLRequest(url: url)
        urlRequest.timeoutInterval = 40.0
        urlRequest.httpMethod = "GET"
        return urlRequest
    }
}
