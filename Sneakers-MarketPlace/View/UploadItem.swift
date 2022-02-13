//
//  UploadItem.swift
//  Sneakers-MarketPlace
//
//  Created by Amir Nilsson on 2022-02-12.
//

import SwiftUI

struct UploadItem: View {
    
    @State var itemName = ""
    @State var itemCost = ""
    @State var itemImage = ""
    @State var itemDetails = ""
    @State var itemRating = 0
    
    
    var body: some View {
        
        VStack {
            
            
            
            Text("Please enter needed information")
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(.black)
                .padding(.top, 35)
            
            TextField("Sneaker Name", text: self.$itemName)
                .keyboardType(.emailAddress)
            .padding()
            .background(RoundedRectangle(cornerRadius: 4).stroke(.pink,lineWidth: 2))
            .padding(.top, 25)
            
            TextField("Sneaker Cost", text: self.$itemCost)
                .keyboardType(.emailAddress)
            .padding()
            .background(RoundedRectangle(cornerRadius: 4).stroke(.pink,lineWidth: 2))
            .padding(.top, 25)
            
            TextField("Sneaker Details", text: self.$itemDetails)
                .keyboardType(.emailAddress)
            .padding()
            .background(RoundedRectangle(cornerRadius: 4).stroke(.pink,lineWidth: 2))
            .padding(.top, 25)
            
            Picker("Rating", selection: $itemRating) {
                ForEach(0..<6){
                    Text(String($0))
                }
            }
            .pickerStyle(.wheel)
            
            
            
            
            
            
            Button(action: {
                
            }, label: {
                Text("Upload")
                    .foregroundColor(.white)
                    .padding(.vertical)
                    .frame(width: UIScreen.main.bounds.width - 50)
            })
                .background(.pink)
                .cornerRadius(10)
                .padding(.top, 25)
            
        }
        .padding(.horizontal, 25)
        
        
    }
}


