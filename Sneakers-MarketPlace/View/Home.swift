//
//  Home.swift
//  Sneakers-MarketPlace
//
//  Created by Amir Nilsson on 2022-01-23.
//

import SwiftUI

struct Home: View {
    
    @StateObject var HomeModel = HomeViewModel()
    
    var body: some View {
        
        ZStack {
            
            VStack(spacing: 10) {
                
                HStack(spacing: 15) {
                    
                    Button(action: {
                        
                    }, label: {
                        Image(systemName: "line.horizontal.3")
                            .font(.title)
                            .foregroundColor(.pink)
                    })
                    
                    
                    Text(HomeModel.userLocation == nil ? "Locating..." : "Location is;")
                        .foregroundColor(.black)
                    
                    Text(HomeModel.userAdress)
                        .font(.caption)
                        .fontWeight(.heavy)
                        .foregroundColor(.pink)
                    
                    Spacer(minLength: 0)
                    
                }.padding([.horizontal, .top])
                
                Divider()
                
                HStack(spacing: 15){
                    
                    TextField("Search for Sneakers", text: $HomeModel.search)
                    
                    if HomeModel.search != "" {
                        
                        Button(action: {
                            
                        }, label: {
                            Image(systemName: "magnifyingglass")
                                .font(.title2)
                                .foregroundColor(.red)
                        }).animation(.easeIn)
                        
                    }
                    
                }.padding(.horizontal)
                    .padding(.top, 10)
                
                Divider()
                
                Spacer()
            }
            
            // non closable alert if permission denied
            
            if HomeModel.noLocation {
                Text("Please enable location access in setting to move on!")
                    .foregroundColor(.black)
                    .frame(width: UIScreen.main.bounds.width - 100, height: 120)
                    .background(.white)
                    .cornerRadius(10)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(Color.black.opacity(0.3).ignoresSafeArea())
            }
            
        }
        .onAppear(perform: {
            // calling location delegate
            
            HomeModel.locationManager.delegate = HomeModel
            
            
        })
        
        
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
