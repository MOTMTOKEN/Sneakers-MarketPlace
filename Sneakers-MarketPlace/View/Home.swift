//
//  Home.swift
//  Sneakers-MarketPlace
//
//  Created by Amir Nilsson on 2022-01-23.
//

import SwiftUI
import Firebase


struct Home: View {
    
    @StateObject var HomeModel = HomeViewModel()
    
    

    var body: some View {
        
        
        
        ZStack {
            
            NavigationView {
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
                    
                    Image(systemName: "magnifyingglass")
                        .font(.title2)
                        .foregroundColor(.red)

                    
                    TextField("Search for Sneakers", text: $HomeModel.search)
                    
                    
                    
                }.padding(.horizontal)
                    .padding(.top, 10)
                
                Divider()
                
                
                ScrollView(.vertical, showsIndicators: false, content: {
                    
                    VStack(spacing: 25) {
                    
                        ForEach(HomeModel.filtered, id: \.id) { item in
                            
                            NavigationLink(destination: {
                                
                                    DetailView(item: item)
                                
                                
                            }, label: {
                                ItemView(item: item)
                                    .frame(width: UIScreen.main.bounds.width - 30)
                            })
                                .navigationBarHidden(true)
                                                            
                      
                        }
                        
                        
                    }
                    .padding(.top, 10)
                    
                    
                })
                    .onAppear(){
                        self.HomeModel.fetchData2()
                    }
                
                }
                
                
            }
            .accentColor(.pink)

            
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
        .onChange(of: HomeModel.search, perform: { value in
            // to avoid continues search requests
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3){
                if value == HomeModel.search && HomeModel.search != "" {
                    
                    // search data
                    HomeModel.filterData()
                }
            }
            
            if HomeModel.search == "" {
                // reset all data
                
                withAnimation(.linear) {
                    HomeModel.filtered = HomeModel.items
                }
            }
            
        })
        
        
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
