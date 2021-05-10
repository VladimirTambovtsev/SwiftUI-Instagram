//
//  CustomInputView.swift
//  InstagramSwiftUI
//
//  Created by Владимир on 09.05.2021.
//

import SwiftUI

struct CustomInputView: View {
    @Binding var inputText: String
    
    var action: () -> Void
    
    var body: some View {
        VStack {
            Rectangle()
                .foregroundColor(Color(.separator))
                .frame(width: UIScreen.main.bounds.width, height: 0.75)
                .padding(.bottom, 8)
            
            HStack {
                TextField("Comment..", text: $inputText)
                    .font(.system(size: 14))
                    .textFieldStyle(PlainTextFieldStyle())
                    .frame(minHeight: 30)
                
                Button(action: action) {
                    Text("Send")
                        .font(.system(size: 14))
                        .padding(.horizontal)
                        .padding(.vertical, 8)
                        .foregroundColor(.white)
                        .background(Color(#colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)))
                        .clipShape(RoundedRectangle(cornerSize: .init(width: 14, height: 14)))
                }

            }
            .padding(.horizontal)
        }
        .padding(.bottom, 8)
        .padding(.horizontal)
    }
}

//struct CustomInputView_Previews: PreviewProvider {
//    static var previews: some View {
//        CustomInputView()
//    }
//}
