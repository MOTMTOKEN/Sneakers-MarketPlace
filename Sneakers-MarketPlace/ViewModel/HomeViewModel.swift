//
//  HomeViewModel.swift
//  Sneakers-MarketPlace
//
//  Created by Amir Nilsson on 2022-01-23.
//

import SwiftUI
import CoreLocation
import Firebase
import FirebaseFirestore
import FirebaseFirestoreSwift

class HomeViewModel : NSObject ,ObservableObject, CLLocationManagerDelegate {
    
    @Published var locationManager = CLLocationManager()
    @Published var search = ""
    
    // location details
    @Published var userLocation : CLLocation!
    @Published var userAdress = ""
    @Published var noLocation = false
    
    
    // side bar
    @Published var showSideBar = false
    
    // itemData
    @Published var items: [Item] = []
    @Published var filtered: [Item] = []
    
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
    
    // fetching Data
    /*
    func fetchData() {
        
        let db = Firestore.firestore()
        
        db.collection("Items").getDocuments { (snap, err) in
            guard let itemData = snap else {return}
            
            print("before line 93")
            self.items = itemData.documents.compactMap({  (doc) -> Item? in
                print("after line 93")
                
                let id = doc.documentID
                let name = doc.get("item_name") as! String
                let cost = doc.get("item_cost") as! NSNumber
                let ratings = doc.get("item_rating") as! String
                let image = doc.get("item_image") as! String
                let details = doc.get("item_details") as! String
                
                print("just before line 103")
                return Item(id: id, item_name: name, item_cost: cost, item_details: details, item_image: image, item_rating: ratings)
            })
        }
    }
     */
    
    func fetchData2() {
        
        let db = Firestore.firestore()
        
        db.collection("Items1").addSnapshotListener{ (querySnapshot, error ) in
            guard let documents = querySnapshot?.documents else {
                print("no documents")
                return
            }
            self.items = documents.map{(queryDocumentSnapshot) -> Item in
                let data = queryDocumentSnapshot.data()
                
                let id = queryDocumentSnapshot.documentID
                let name = data["item_name"] as! String
                print("this is line 127 \(name)")
                let cost = data["item_cost"] as! Double
                let ratings = data["item_rating"] as! String
                let image = data["item_image"] as! String
                let details = data["item_details"] as! String
                let location = data["user_location"] as? String
                let email = data["user_email"] as? String
                let phone = data["user_phone"] as? String
                
                
                print("right before returning item")
                
                return Item(id: id, item_name: name, item_cost: cost, item_details: details, item_image: image, item_rating: ratings, user_location: location ?? "", user_email: email ?? "", user_phone: phone ?? "")
            }
            self.filtered = self.items
        }
    }
    
    
     func checkLoginForData() {
        
            self.fetchData2()
            print("fetchData func ran")
        
    }
    
    
    func filterData() {
        
        withAnimation(.linear) {
            self.filtered = self.items.filter {
                return $0.item_name.lowercased().contains(self.search.lowercased())
            }
        }
    }
    
    
}
