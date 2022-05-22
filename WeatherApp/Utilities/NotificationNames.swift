//
//  NotificationNames.swift
//  WeatherApp
//
//  Created by MacBook on 22/05/2022.
//

import Foundation

struct HomeViewNotifications
{
    // Notification name for the user location update
    // We are using it inside the LocationViewModel
    static let locationIsUpdated = NSNotification.Name("com.samples.weatherapp.userlocation.update")
}
