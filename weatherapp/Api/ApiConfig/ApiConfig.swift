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
}
