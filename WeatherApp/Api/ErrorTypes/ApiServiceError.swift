//
//  ApiServiceError.swift
//  weatherapp
//
//  Created by MacBook on 21/05/2022.
//

import Foundation

/// Different types of error to be return during api calling
enum ApiServiceError:Error{
    case url(URLError)
    case urlRequest
    case decode(String)
}
