//
//  loginPage.swift
//  Sneakers-MarketPlace
//
//  Created by Amir Nilsson on 2022-01-27.
//

import SwiftUI

struct loginPage: View {
    
    
    @State var email = ""
    @State var pass = ""
    @State var visable = false
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack{
                    
                    Image("logo")
                    
                    Text("Log in to your account")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(.black)
                        .padding(.top, 35)
                    
                    TextField("Email", text: self.$email)
                        .keyboardType(.emailAddress)
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 4).stroke(.pink,lineWidth: 2))
                    .padding(.top, 25)
                
                    HStack (spacing: 15) {
                        
                        
                        VStack {
                            
                            if self.visable {
                                
                                TextField("Password", text: self.$pass)
                            } else {
                                SecureField("Password", text: self.$pass)
                            }
                            
                        }
                        
                        Button(action: {
                            self.visable.toggle()
                        }, label: {
                            Image(systemName: self.visable ?  "eye.slash.fill" : "eye.fill")
                                .foregroundColor(.pink)
                        })
                        
                    }
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 4).stroke(.pink,lineWidth: 2))
                    .padding(.top, 25)
                    
                    Button(action: {
                        
                    }, label: {
                        Text("Login")
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
    }
    
    }

struct loginPage_Previews: PreviewProvider {
    static var previews: some View {
        loginPage()
    }
}



