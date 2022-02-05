//
//  ItemView.swift
//  Sneakers-MarketPlace
//
//  Created by Amir Nilsson on 2022-02-04.
//

import SwiftUI
import SDWebImageSwiftUI

struct ItemView: View {
    
    var item: Item
    
    var body: some View {
        
        VStack {
            
            WebImage(url: URL(string: item.item_image))
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(height: 250)
            
            HStack(spacing: 8) {
                
                Text(item.item_name)
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(.black)
                
                Spacer(minLength: 0)
                
                // ratings view
                
                ForEach(1...5, id: \.self){
                    index in
                    
                    Image(systemName: "star.fill")
                        .foregroundColor(index <= Int(item.item_rating) ?? 0 ? .pink : .gray)
                }
                
            }
            
            
            HStack {
                Text(item.item_details)
                    .font(.caption)
                    .foregroundColor(.gray)
                    .lineLimit(2)
                
                Spacer(minLength: 0)
            }
        }
    }
}

