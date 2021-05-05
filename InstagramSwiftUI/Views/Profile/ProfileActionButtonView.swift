//
//  ProfileActionButtonView.swift
//  InstagramSwiftUI
//
//  Created by Владимир on 03.05.2021.
//

import SwiftUI

struct ProfileActionButtonView: View {
    var isCurrentUser = false
    var isFollowed = false
    
    var body: some View {
        if isCurrentUser {
            Button(action: {}, label: {
                Text("Edit Profile")
                    .font(.system(size: 14, weight: .semibold))
                    .frame(width: 360, height: 32)
                    .foregroundColor(.black)
                    .overlay(
                        RoundedRectangle(cornerRadius: 3)
                            .stroke(Color.gray, lineWidth: 1)
                    )
            })
            .padding(.top)
        } else {
            HStack {
                Button(action: {}, label: {
                    Text(isFollowed ? "Following" : "Follow")
                        .font(.system(size: 14, weight: .semibold))
                        .frame(width: 172, height: 32)
                        .foregroundColor(isFollowed ? .black : .white)
                        .background(isFollowed ? Color.white : Color.blue)
                        .overlay(
                            RoundedRectangle(cornerRadius: 3)
                                .stroke(Color.blue, lineWidth: isFollowed ? 1 : 0)
                        )
                })
                .cornerRadius(3)
                .padding(.top)
                
                Button(action: {}, label: {
                    Text("Message")
                        .font(.system(size: 14, weight: .semibold))
                        .frame(width: 172, height: 32)
                        .foregroundColor(.black)
                        .overlay(
                            RoundedRectangle(cornerRadius: 3)
                                .stroke(Color.gray, lineWidth: 1)
                        )
                })
                .padding(.top)
            }
        }
    }
}

struct ProfileActionButtonView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileActionButtonView()
    }
}
