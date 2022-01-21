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
        Button(action: {
            saveToFireStore()
        }, label: {
            Text("Save")
        })
    }
    
    func saveToFireStore() {
        
        db.collection("tmp").addDocument(data: ["name":"Amir"])
        
    }
    
    
}

struct ContentView_Previews:
    PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}



