//
//  DetailView.swift
//  Sneakers-MarketPlace
//
//  Created by Amir Nilsson on 2022-02-12.
//

import SwiftUI
import SDWebImageSwiftUI

struct DetailView: View {
    
    var item: Item!
    
    @StateObject var HomeModel = HomeViewModel()
    
    
    var body: some View {
        
        VStack {
            
            VStack() {
                
                
                Text(item.item_name)
                    .fontWeight(.heavy)
                    .foregroundColor(.pink)
                    .font(.largeTitle)
                
                Text(item.user_location)
                    .fontWeight(.heavy)
                    .foregroundColor(.pink)
                    .font(.largeTitle)
            }
        
        
        
        WebImage(url: URL(string: item.item_image))
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(height: 250)
            
        
     }
        
    }
}
