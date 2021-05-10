//
//  ProfileHeader.swift
//  InstagramSwiftUI
//
//  Created by Владимир on 03.05.2021.
//

import SwiftUI
import Kingfisher

struct ProfileHeaderView: View {
    @ObservedObject var viewModel: ProfileViewModel
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                KFImage(URL(string: viewModel.user.profileImageUrl))
                    .resizable()
                    .scaledToFill()
                    .frame(width: 80, height: 80)
                    .clipShape(Circle())
                    .padding(.leading)
                
                Spacer()
                
                HStack(spacing: 16) {
//                    if let stats = viewModel.user.stats {
                        UserStatView(value: viewModel.user.stats?.posts ?? 0, title: "Post")
                        UserStatView(value: viewModel.user.stats?.followers ?? 0, title: "Followers")
                        UserStatView(value: viewModel.user.stats?.following ?? 0, title: "Following")
//                    }
                }
                .padding(.trailing, 32)
            }
            
            Text(viewModel.user.fullname)
                .font(.system(size: 15, weight: .semibold))
                .padding([.leading, .top])
            
            if let bio = viewModel.user.bio {
                Text(bio)
                    .font(.system(size: 15, weight: .semibold))
                    .padding([.leading])
                    .padding(.top, 1)
            }
            
            
            Text(viewModel.user.username)
                .font(.system(size: 15))
                .padding(.leading)
                .padding(.top, 4)
            
            HStack() {
                Spacer()

                ProfileActionButtonView(viewModel: viewModel)
                
                Spacer()
            }
        }
    }
}

