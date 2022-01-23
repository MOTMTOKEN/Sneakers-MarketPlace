//
//  Home.swift
//  Sneakers-MarketPlace
//
//  Created by Amir Nilsson on 2022-01-23.
//

import SwiftUI

struct Home: View {
    var body: some View {
        
        VStack(spacing: 10) {
            
            HStack(spacing: 15) {
                
                Button(action: {
                    
                }, label: {
                    Image(systemName: "line.horizontal.3")
                        .font(.title)
                        .foregroundColor(.pink)
                })
                
                
                Text("Current location is:")
                    .foregroundColor(.black)
                
                Text("Location")
                    .font(.caption)
                    .fontWeight(.heavy)
                    .foregroundColor(.pink)
                
            }.padding([.horizontal, .top])
            
            Divider()
            
            Spacer()
        }
        
        
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
