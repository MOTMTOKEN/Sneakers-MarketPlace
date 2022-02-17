//
//  Item.swift
//  Sneakers-MarketPlace
//
//  Created by Amir Nilsson on 2022-02-04.
//

import SwiftUI
import Firebase
import FirebaseFirestoreSwift

struct Item: Identifiable, Codable {
    
    @DocumentID var id: String?
    var item_name: String
    var item_cost: Double
    var item_details: String    
    var item_image: String
    var item_rating: String
    var user_location: String
    var user_email: String
    var user_phone: String
    
}
