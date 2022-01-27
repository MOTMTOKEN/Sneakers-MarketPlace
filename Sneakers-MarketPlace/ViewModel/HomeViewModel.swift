//
//  HomeViewModel.swift
//  Sneakers-MarketPlace
//
//  Created by Amir Nilsson on 2022-01-23.
//

import SwiftUI
import CoreLocation

class HomeViewModel : NSObject ,ObservableObject, CLLocationManagerDelegate {
    
    @Published var locationManager = CLLocationManager()
    @Published var search = ""
    
    // location details
    @Published var userLocation : CLLocation!
    @Published var userAdress = ""
    @Published var noLocation = false
    
    // side bar
    @Published var showSideBar = false
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        //check location acess
        
        switch manager.authorizationStatus {
        case .authorizedWhenInUse:
            print("authorized")
            self.noLocation = false
            manager.requestLocation()
        case .denied:
            print("denied")
            self.noLocation = true
        default:
            print("unkown")
            self.noLocation = false
            // direct call
            locationManager.requestWhenInUseAuthorization()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        
        print(error.localizedDescription)
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        // reading user location and extracting details
        
        self.userLocation = locations.last
        self.extractLocation()
        
    }
    
    func extractLocation () {
        
        CLGeocoder().reverseGeocodeLocation(self.userLocation) { (res, err) in
            
            guard let safeData = res else {return}
            
            var adress = ""
            
            // getting area and locality name
            
            adress += safeData.first?.name ?? ""
            adress += ", "
            adress += safeData.first?.locality ?? ""
            
            self.userAdress = adress
            
        }
        
    }
    
}
