//
//  ContentView.swift
//  Sneakers-MarketPlace
//
//  Created by Amir Nilsson on 2022-01-18.
//

import SwiftUI
import Firebase

struct ContentView: View {
    
    var db = Firestore.firestore()

    
    var body: some View {
        //loginPage()
        Home()
    }
    
    
    
    
}

struct ContentView_Previews:
    PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}



