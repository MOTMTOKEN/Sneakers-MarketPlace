//
//  Sneakers_MarketPlaceApp.swift
//  Sneakers-MarketPlace
//
//  Created by Amir Nilsson on 2022-01-18.
//

import SwiftUI
import Firebase

@main
struct Sneakers_MarketPlaceApp: App {
    
   
    
    init () {
        FirebaseApp.configure()
        
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
