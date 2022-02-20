//
//  DetailView.swift
//  Sneakers-MarketPlace
//
//  Created by Amir Nilsson on 2022-02-12.
//

import SwiftUI
import SDWebImageSwiftUI
import Firebase
import FirebaseFirestore
import FirebaseFirestoreSwift
import FirebaseStorage
import FirebaseStorageSwift


struct DetailView: View {
    
    var item: Item!
    
    // @ObservedObject var HomeModel : HomeViewModel
    
    @StateObject var HomeModel = HomeViewModel()
    
    @State var more = false
    
    var edges = UIApplication.shared.windows.first?.safeAreaInsets
    
    // @State var adress : String
    
    var body: some View {
        
        
        /*
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
         */
        
        VStack {
            
            ZStack{
                
                HStack(spacing: 30){
                    
                    Spacer(minLength: 0)
                    
                    Button(action: {
                        
                        
                        
                    }, label: {
                        
                        Image(systemName: "suit.heart")
                            .font(.system(size: 22))
                            .foregroundColor(Color.black.opacity(0.2))
                            .frame(width: 40, height: 40)
                            .background(.white)
                            .cornerRadius(10)
                            .shadow(color: .black.opacity(0.2), radius: 5, x: 5, y: 5)
                        
                    })
                    
                }
                
                
            }
            .padding([.top], 50)
            .padding([.trailing], 10)
            
            WebImage(url: URL(string: item.item_image))
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: UIScreen.main.bounds.width - (more ? 200 : 100))
                .padding(.top, 25)
            
            ZStack{
                
                Color.white
                    .clipShape(CustomShape())
                    .shadow(color: .black.opacity(0.12), radius: 5, x: -5, y: -10)
                
                VStack{
                    
                    HStack{
                        
                        Text(item.item_name)
                            .font(.title2)
                            .fontWeight(.heavy)
                            .foregroundColor(.black)
                        
                        Spacer(minLength: 0)
                        
                        let cost = String(item.item_cost)
                        Text("$\(cost)")
                            .font(.title2)
                            .fontWeight(.heavy)
                            .foregroundColor(.red)
                    }
                    .padding(.top, 25)
                    .padding(.trailing)
                    
                    VStack(alignment: .leading, spacing: 5){
                        
                        Text(item.item_details)
                            .lineLimit(more ? nil : 3)
                            .foregroundColor(.black)
                        
                        Button(action: {
                            
                            withAnimation{
                                more.toggle()
                            }
                            
                        }, label: {
                            Text("Read More")
                                .fontWeight(.bold)
                                .foregroundColor(.red)
                        })
                    }
                    .padding([.vertical, .trailing])
                    
                    
                    HStack(spacing: 15){
                        
                        Text("Phone: ")
                            .fontWeight(.heavy)
                            .foregroundColor(.black)
                            .frame(width: 75, alignment: .leading)
                        
                        
                        Text(item.user_phone) // item.user_location
                            .fontWeight(.bold)
                            .foregroundColor(.black)
                        
                        Spacer(minLength: 0)
                        
                    }
                    .padding(.trailing)
                    .padding(.top, 10)
                    
                    
                    HStack(spacing: 15){
                        
                        Text("Contact:")
                            .fontWeight(.heavy)
                            .foregroundColor(.black)
                            .frame(width: 75, alignment: .leading)
                        
                        
                        Text(item.user_email)
                            .fontWeight(.bold)
                            .foregroundColor(.black)
                        
                        Spacer(minLength: 0)
                        
                    }
                    .padding(.trailing)
                    .padding(.top, 10)
                    
                    
                    
                    Spacer(minLength: 0)
                    
                    Button(action: {
                        
                        let phone = "tel://"
                        let phoneNumberformatted = phone + item.user_phone
                        guard let url = URL(string: phoneNumberformatted) else { return }
                        UIApplication.shared.open(url)
                        
                    }) {
                        
                        Label(title: {
                            
                            Text("Call Seller")
                                .font(.title2)
                                .foregroundColor(.white)
                                .fontWeight(.heavy)
                            
                        }) {
                            
                            Image(systemName: "phone")
                                .font(.system(size: 22))
                                .foregroundColor(.white)
                            
                        }
                        .padding(.vertical, 12)
                        .frame(width: UIScreen.main.bounds.width - 75)
                        .background(.red)
                        .clipShape(Capsule())
                        .padding(.leading, -45)
                        .padding(.top)
                        .padding(.bottom, edges!.bottom == 0 ? 15 : edges!.bottom)
                        
                        
                    }
                }
                .padding(.leading, 45)
            }
            .padding(.top, 30)
            
            
        }
        .background(Color("blue")).ignoresSafeArea(.all, edges: .all)
        .ignoresSafeArea(.all, edges: .bottom)
    }
}

struct CustomShape : Shape {
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: [.topLeft], cornerRadii: CGSize(width: 85, height: 85))
        
        return Path(path.cgPath)
    }
}
