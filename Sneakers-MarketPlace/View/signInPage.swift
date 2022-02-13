//
//  signInPage.swift
//  Sneakers-MarketPlace
//
//  Created by Amir Nilsson on 2022-02-03.
//

import SwiftUI
import Firebase

struct signInPage: View {
    
    @State var email = ""
    @State var pass = ""
    @State var visable = false
    
    var body : some View {
        
        
        
        NavigationView {
            ScrollView {
        
                HStack(alignment: .top) {
                    
                    NavigationLink{
                        loginPage()
                    } label : {
                        Spacer()
                        Text("Login")
                            .fontWeight(.bold)
                            .foregroundColor(.pink)
                            
                    }
                    .padding()
                    
                    
                    
                    
                    
                }
                        
                        VStack{
                            
                            
                            
                            Image("logo")
                            
                            Text("Register account")
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
                                handleAction()
                            }, label: {
                                Text("Register")
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
                                .alert("Account created please log in!", isPresented: $positive) {
                                            Button("OK", role: .cancel) {
                                                positive = false
                                            }
                                        }
                            
                            
                        
                            
                        }
                        .padding(.horizontal, 25)
                            
                        }
                        .padding(.horizontal, 25)
                        .navigationBarHidden(true)
                        .navigationBarBackButtonHidden(false)
                        .fullScreenCover(isPresented: $isLoginMode, onDismiss: nil, content: {
                            Home()
                        })
            
                    
            
                
                    
            
                
    
                    
                            
            }
        }
    
    @State var isLoginMode = false
    
    func handleAction(){
        if isLoginMode {
        //loginUser()
        } else {
            createNewAccount()
            
        }
    }
    
    @State var errorMessage = ""
    @State var showingAlert = false
    @State var positive = false
    
    func createNewAccount() {
        Auth.auth().createUser(withEmail: email, password: pass) {
            result, err in
            if let err = err {
                print("ERROR FAILED TO CREATE USER", err)
                errorMessage = "ERROR FAILED TO CREATE USER: \(err.localizedDescription)"
                showingAlert = true
                return
            }
            print("user created \(result?.user.uid ?? "")")
            
            errorMessage = "user created \(result?.user.uid ?? "")"
        
            positive = true
            
            
        }
        
    }
    
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
            
            errorMessage = "user logged in as \(result?.user.uid ?? "")"
        })
    }
        
        
                }



struct signInPage_Previews: PreviewProvider {
    static var previews: some View {
        signInPage()
    }
}
