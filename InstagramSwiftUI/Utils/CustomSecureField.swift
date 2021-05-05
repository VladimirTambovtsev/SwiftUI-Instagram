//
//  CustomSecureField.swift
//  InstagramSwiftUI
//
//  Created by Владимир on 04.05.2021.
//

import SwiftUI

struct CustomSecureField: View {
    @Binding var text: String
    let placeholder: Text
    let imageName: String
    
    var body: some View {
        ZStack(alignment: .leading) {
            if text.isEmpty {
                placeholder
                    .foregroundColor(Color(.init(white: 1, alpha: 0.8)))
                    .padding(.leading, 40)
            }
            HStack {
                Image(systemName: imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20, height: 20)
                    .foregroundColor(.white)
                
                SecureField("", text: $text   )
            }
        }
    }
}

struct CustomSecureField_Previews: PreviewProvider {
    static var previews: some View {
        CustomSecureField(
            text: .constant(""),
            placeholder: Text("Email"),
            imageName: "envelope"
        )
    }
}
