//
//  sideBar.swift
//  Sneakers-MarketPlace
//
//  Created by Amir Nilsson on 2022-01-27.
//

import SwiftUI

struct sideBar: View {
    
    @ObservedObject var homeData : HomeViewModel
    
    var body: some View {
        
        VStack {
            
            Button(action: {}, label: {
            HStack(spacing : 15){
                Image(systemName: "person.crop.circle.fill")
                    .font(.title)
                    .foregroundColor(.pink)
                
                Text("Profile")
                    .fontWeight(.bold)
                    .foregroundColor(.black)
                
                Spacer(minLength: 0)
                
            }
            .padding()
        })
            
            Button(action: {
                
            }, label: {
                Image(systemName: "message")
                    .font(.title)
                    .foregroundColor(.pink)
                
                Text("Messages")
                    .fontWeight(.bold)
                    .foregroundColor(.black)
                
                Spacer(minLength: 0)
            })
                .padding()
            
            
            
            NavigationLink {
                UploadItem()
            } label: {
                Image(systemName: "square.and.arrow.up")
                    .font(.title)
                    .foregroundColor(.pink)
                
                Text("Upload for sale")
                    .fontWeight(.bold)
                    .foregroundColor(.black)
                
                Spacer(minLength: 0)
            }
                .padding()
            
                
            
            Spacer()
            
            HStack{
                Spacer()
                
                Text("Version 1")
                    .fontWeight(.bold)
                    .foregroundColor(.pink)
            }
            .padding(10)
            
            
            
            
        }
        .padding([.top, .trailing])
        .frame(width: UIScreen.main.bounds.width / 1.6)
        .background(Color.white.ignoresSafeArea())
        
    }
}
