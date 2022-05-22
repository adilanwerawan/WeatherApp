//
//  LocationViewModel.swift
//  WeatherApp
//
//  Created by MacBook on 22/05/2022.
//

import Foundation
import CoreLocation
import SwiftUI

class LocationViewModel: NSObject, ObservableObject, CLLocationManagerDelegate {
    @Published var authorizationStatus: CLAuthorizationStatus
    @Published var lastSeenLocation: CLLocation?
    @Published var currentPlacemark: CLPlacemark?
    
    private let locationManager: CLLocationManager
    
    static var notificationCount = 0
    
    override init() {
        locationManager = CLLocationManager()
        authorizationStatus = locationManager.authorizationStatus
        
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.distanceFilter = 0.4
        locationManager.startUpdatingLocation()
    }
    
    func requestPermission() {
        locationManager.requestWhenInUseAuthorization()
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        authorizationStatus = manager.authorizationStatus
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        if lastSeenLocation != locations.first{
            lastSeenLocation = locations.first
            fetchCountryAndCity(for: locations.first)
            LatLong.latitude = locations.first?.coordinate.latitude
            LatLong.longitude = locations.first?.coordinate.longitude
            
            if LocationViewModel.notificationCount < 1{
                NotificationCenter.default.post(name: HomeViewNotifications.locationIsUpdated, object: nil, userInfo: nil)
            }
            LocationViewModel.notificationCount += 1
        }
    }
    
    func fetchCountryAndCity(for location: CLLocation?) {
        guard let location = location else { return }
        let geocoder = CLGeocoder()
        geocoder.reverseGeocodeLocation(location) { (placemarks, error) in
            self.currentPlacemark = placemarks?.first
        }
    }
}

struct LatLong{
    static var latitude:Double? = nil
    static var longitude:Double? = nil
}
