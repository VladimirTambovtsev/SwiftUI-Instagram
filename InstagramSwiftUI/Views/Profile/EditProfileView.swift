//
//  EditProfileView.swift
//  InstagramSwiftUI
//
//  Created by Владимир on 10.05.2021.
//

import SwiftUI

struct EditProfileView: View {
    @State private var bioText = ""
    @ObservedObject private var viewModel: EditProfileViewModel
    @Binding var user: User
    @Environment(\.presentationMode) var mode

    init(user: Binding<User>) {
        self._user = user
        self.viewModel = EditProfileViewModel(user: self._user.wrappedValue)
        self._bioText = State(initialValue: _user.wrappedValue.bio ?? "")
    }
    
    var body: some View {
        VStack {
            HStack {
                Button(action: { mode.wrappedValue.dismiss() }, label: {
                    Text("Cancel")
                })
                
                Spacer()
                
                Button(action: { viewModel.saveUserData(bio: bioText) }, label: {
                    Text("Done").bold()
                })
            }
            .padding()
            
            TextArea(placeholder: "Add your bio..", text: $bioText)
                .frame(width: 370, height: 200)
                .padding()
            
            Spacer()
            
        }
        .onReceive(viewModel.$uploadComplete) { completed in
            if completed {
                self.mode.wrappedValue.dismiss()
                self.user.bio = bioText
            }
        }
    }
}

//struct EditProfileView_Previews: PreviewProvider {
//    static var previews: some View {
//        EditProfileView()
//    }
//}
