//
//  ProfileHeader.swift
//  InstagramSwiftUI
//
//  Created by Владимир on 03.05.2021.
//

import SwiftUI

struct ProfileHeaderView: View {
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Image("avatar1")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 80, height: 80)
                    .clipShape(Circle())
                    .padding(.leading)
                
                Spacer()
                
                HStack(spacing: 16) {
                    UserStatView(value: 1, title: "Post")
                    UserStatView(value: 599, title: "Followers")
                    UserStatView(value: 499, title: "Following")
                }
                .padding(.trailing, 32)
            }
            
            Text("Firstname Lastname")
                .font(.system(size: 15, weight: .semibold))
                .padding([.leading, .top])
            
            Text("Status Text")
                .font(.system(size: 15))
                .padding(.leading)
                .padding(.top, 4)
            
            HStack() {
                Spacer()

                ProfileActionButtonView()
                
                Spacer()
            }
        }
    }
}


struct ProfileHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileHeaderView()
    }
}
