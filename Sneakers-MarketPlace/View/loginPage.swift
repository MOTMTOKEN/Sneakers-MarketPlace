//
//  loginPage.swift
//  Sneakers-MarketPlace
//
//  Created by Amir Nilsson on 2022-01-27.
//

import SwiftUI
import Firebase

struct loginPage: View {
    
    @StateObject var HomeModel = HomeViewModel()
    
    @State var email = ""
    @State var pass = ""
    @State var visable = false
    
    var body : some View {
        
        
        
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
                                loginUser()
                            }, label: {
                                Text("Login")
                                    .foregroundColor(.white)
                                    .padding(.vertical)
                                    .frame(width: UIScreen.main.bounds.width - 50)
                            })
                                .background(.pink)
                                .cornerRadius(10)
                                .padding(.top, 25)
                                .alert("\(errorMessage)", isPresented: $showingAlert) {
                                            Button("OK", role: .cancel) {
                                                showingAlert = false
                                            }
                                        }
                            
                        }
                        .padding(.horizontal, 25)
                    
            
                    
                    
                    
                        
            
                    
                            
            }
            .navigationBarHidden(true)
            .navigationBarBackButtonHidden(false)
        }
        .fullScreenCover(isPresented: $isLoginMode, onDismiss: nil, content: {
            Home()
        })
        
        
                }
    
    @State var isLoginMode = false
    @State var errorMessage = ""
    @State var showingAlert = false
    
    private func loginUser(){
        Auth.auth().signIn(withEmail: email, password: pass, completion: {
            result, err in
            if let err = err {
                print("ERROR FAILED TO LOGIN USER", err)
                errorMessage = "ERROR FAILED TO LOGIN USER: \(err.localizedDescription)"
                showingAlert = true
                return
            }
            print("user logged in as \(result?.user.uid ?? "")")
            isLoginMode = true
            HomeModel.checkLoginForData()
            errorMessage = "user logged in as \(result?.user.uid ?? "")"
            
            
        })
    }
                
            }


struct loginPage_Previews: PreviewProvider {
    static var previews: some View {
        loginPage()
    }
}




