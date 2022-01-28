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
                        withAnimation(.easeIn){
                            HomeModel.showSideBar.toggle()
                        }
                    }, label: {
                        Image(systemName: "line.horizontal.3")
                            .font(.title)
                            .foregroundColor(.pink)
                    })
                    
                    
                    
                    if ((HomeModel.userLocation) != nil) {
                        Text(Image(systemName: "location"))
                            .foregroundColor(.black)
                            
                    } else {
                        Text("Locating...")
                            .foregroundColor(.black)
                            
                    }
                    
                    
                    
                    
                    
                    Text(HomeModel.userAdress)
                        .font(.caption)
                        .fontWeight(.heavy)
                        .foregroundColor(.pink)
                    
                    Spacer(minLength: 0)
                    
                    Button(action: {
                        
                    }, label: {
                        Image(systemName: "plus.circle")
                            .foregroundColor(.pink)
                    })
                    
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
            
            // side bar
            
            HStack {
                sideBar(homeData: HomeModel)
                    .offset(x: HomeModel.showSideBar ? 0 : -UIScreen.main.bounds.width / 1.6)
                
                Spacer(minLength: 0)
            }
            .background(Color.black.opacity(HomeModel.showSideBar ? 0.3 : 0).ignoresSafeArea())
            // closing when tap again
            .onTapGesture {
                withAnimation(.easeIn){
                    HomeModel.showSideBar.toggle()
                }
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
