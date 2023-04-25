//
//  NewPostView.swift
//  Squirrel.IO
//
//  Created by Fabrizzio Perez on 4/16/23.
//

import SwiftUI
import FirebaseStorage
import FirebaseFirestore
import FirebaseAuth

struct NewPostView: View {
    @EnvironmentObject var user_info: UserInfo
    @EnvironmentObject var message: Message
    @State private var sourceType: UIImagePickerController.SourceType = .photoLibrary
    @State private var showImagePicker = false
    @State private var selectedImage: UIImage?
    
    @State private var caption = ""
    @Environment(\.presentationMode) var presentationMode
    
    
    @FocusState private var isFocused: Bool
    
    
    var body: some View {
        VStack{
            HStack{
                Button {
                    presentationMode.wrappedValue.dismiss()
                } label:{
                    Text("Cancel")
                        .foregroundColor(Color(.systemBlue))
                        .bold()
                }
                
                Spacer()
                Button(action: createPost) {
                    Text("Post").bold().padding(.horizontal, 3).padding(.vertical, -2)
                }.buttonStyle(.borderedProminent).clipShape(Capsule()).disabled(!checkPostValid())
            }
            .padding()
            
            
            
            VStack{
                
                TextField("What's new in College Park?", text: $caption, axis: .vertical)
                    .font(.title3)
                    .focused($isFocused)
                
            }
            .padding()
            .onAppear{
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.02){
                    self.isFocused = true
                }
            }
            
            
            Spacer()
            
            if selectedImage != nil {
                VStack {
                    Text("Selected Image:")
                    Image(uiImage: selectedImage!).resizable().frame(width: 200, height: 200)
                }
            }
            
            //bottom divider and buttons
            VStack(spacing: 2){
                Divider()
                
                HStack(spacing: 20){
                    
                    //camera
                    Button{
                        //action
                        openCamera()
                    }label: {
                        //image button
                        Image(systemName: "camera.fill")
                            .font(.system(size: 25)).foregroundColor(.white)
                    }
                    
                    
                    //camera roll
                    Button{
                        //action
                        openRoll()
                    }label: {
                        //image button
                        Image(systemName: "photo.fill")
                            .font(.system(size: 25)).foregroundColor(.white)
                    }
                    
                    //allowing location
                    Button{
                        //action
                        //NEED TO DO*****
                    }label: {
                        //image button
                        Image(systemName: "location.circle")
                            .font(.system(size: 25)).foregroundColor(.white)
                    }
                    
                    Spacer()
                }
                .padding(.vertical, 4)
                .padding(.horizontal, 12)
                
            }
            
            
        }
        .background(Color(.systemYellow)).sheet(isPresented: $showImagePicker) {
            CameraPickView(selectedImage: self.$selectedImage, sourceType: $sourceType)
        }
        
    }
    
    func checkPostValid() -> Bool {
        let trimmedCaption = caption.trimmingCharacters(in: .whitespacesAndNewlines)
        
        return !trimmedCaption.isEmpty && trimmedCaption.count >= 8 && selectedImage != nil
    }

    func createPost() {
        // No need to check if the picture and caption are valid since the post button will be disabled if they aren't
        
        // First upload the file
        let storageRef = Storage.storage().reference()
        let imageData = selectedImage!.jpegData(compressionQuality: 0.8)
        
        guard imageData != nil else {
            return
        }
        
        let path = "images/\(UUID().uuidString).jpg"
        let fileRef = storageRef.child(path)
        
        let uploadTask = fileRef.putData(imageData!, metadata: nil) { metadata, error in
            if error == nil && metadata != nil {
                // Successful upload
                let db = Firestore.firestore()
                let currentUser = Auth.auth().currentUser!.uid
                db.collection("images").document().setData(["url":path, "uploader": currentUser, "dateUploaded": Timestamp(date: Date()), "uploaderEmail": user_info.user?.email ?? "No email"])
                message.message = "Successfully created post"
                message.messageType = .success
                presentationMode.wrappedValue.dismiss()
            } else {
                message.message = "Failed to create post"
                message.messageType = .error
                presentationMode.wrappedValue.dismiss()
            }
        }
    }
    
    func openCamera() {
        sourceType = .camera
        showImagePicker.toggle()
    }
    
    func openRoll() {
        sourceType = .photoLibrary
        showImagePicker.toggle()
    }
}

struct NewPostView_Previews: PreviewProvider {
    static var previews: some View {
        NewPostView().environmentObject(Message(messageType: .none, message: "")).environmentObject(UserInfo())
    }
}
