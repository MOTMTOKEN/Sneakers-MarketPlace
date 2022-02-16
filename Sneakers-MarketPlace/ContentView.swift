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

    @State var show = false
    
    var body: some View {
        
      //  signInPage()
      Home()
     // UploadItem()
    }
    
    
}



struct ContentView_Previews:
    PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}




