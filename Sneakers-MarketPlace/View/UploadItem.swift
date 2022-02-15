//
//  UploadItem.swift
//  Sneakers-MarketPlace
//
//  Created by Amir Nilsson on 2022-02-12.
//

import SwiftUI
import Firebase
import FirebaseFirestore
import FirebaseFirestoreSwift
import FirebaseStorage
import FirebaseStorageSwift


struct UploadItem: View {
    
    @StateObject var HomeModel = HomeViewModel()
    
    @State var itemName = ""
    @State var itemCost = ""
    @State var itemImage = ""
    @State var itemDetails = ""
    @State var itemRating = ""
    @State var uploaded = false
    
    @State var changeProfileImage = false
    @State var openCameraRoll = false
    @State var imageSelected = UIImage()
    
    
    var body: some View {
       
        
        ScrollView{
            VStack {
                
                Text("Please enter needed information")
                    .font(.title3)
                    .fontWeight(.bold)
                    .foregroundColor(.black)
                    .padding(.top, 35)
                
                
                    Button(action: {
                        changeProfileImage = true
                        openCameraRoll = true
                        
                    }, label: {
                        if changeProfileImage {
                            Image(uiImage: imageSelected)
                                .resizable()
                                .frame(width: 120, height: 120)
                                .clipShape(Circle())
                        } else {
                            Image("add-profile-image")
                                .resizable()
                                .frame(width: 120, height: 120)
                                .clipShape(Circle())
                                
                        }
                }).sheet(isPresented: $openCameraRoll) {
                    ImagePicker(selectedImage: $imageSelected, sourceType: .photoLibrary)
                }
                    
                    
                
                TextField("Sneaker Name", text: self.$itemName)
                .padding()
                .background(RoundedRectangle(cornerRadius: 4).stroke(.pink,lineWidth: 2))
                .padding(.top, 25)
                
                
                   
                
                TextField("Sneaker Cost", text: self.$itemCost)
                .padding()
                .background(RoundedRectangle(cornerRadius: 4).stroke(.pink,lineWidth: 2))
                .padding(.top, 25)
                .keyboardType(.numberPad)
                
                
                TextField("Sneaker Details", text: self.$itemDetails)
                .padding()
                .background(RoundedRectangle(cornerRadius: 4).stroke(.pink,lineWidth: 2))
                .padding(.top, 25)
                
                /*
                Picker("Rating", selection: self.$itemRating) {
                    ForEach(0..<6){
                        Text(String($0))
                    }
                }
                .pickerStyle(.wheel)
                */
                
                TextField("Rating 1-5", text: self.$itemRating)
                .padding()
                .background(RoundedRectangle(cornerRadius: 4).stroke(.pink,lineWidth: 2))
                .padding(.top, 25)
                
                
                
                
                
                Button(action: {
                    
                    persistImageToStorage()
                    uploaded = true
                    
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
            .fullScreenCover(isPresented: $uploaded, onDismiss: nil, content: {
                Home()
            })
        }
        
        
        
        
    }
        
    
    func persistImageToStorage () {
        print("upload to firestore")
      //  let fileName = UUID().uuidString
        guard let uid = Auth.auth().currentUser?.uid else {return}
        let ref = Storage.storage().reference(withPath: uid)
        guard let imageData = self.imageSelected.jpegData(compressionQuality: 0.5) else {return}
        ref.putData(imageData, metadata: nil) {metadata, err in
            if let err = err {
                print("\(err)")
                return
            }
            ref.downloadURL { url, err in
                if let err = err {
                    print("\(err)")
                    return
                }
                let cost = Double(itemCost) ?? 0.0
                
                let item = Item(item_name: itemName, item_cost: cost, item_details: itemDetails, item_image: url?.absoluteString ?? "", item_rating: itemRating, user_location: HomeModel.userAdress)
                
            
                
                let db = Firestore.firestore()
                
                do {
                   try db.collection("Items1").addDocument(from: item)
                    
                } catch {
                    print("error catch")
                    
                }
                
            }
        }
        
        
    }
}


