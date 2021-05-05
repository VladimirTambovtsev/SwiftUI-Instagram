//
//  FeedCell.swift
//  InstagramSwiftUI
//
//  Created by Владимир on 03.05.2021.
//

import SwiftUI

struct FeedCell: View {
    var body: some View {
        VStack(alignment: .leading) {
//            User info
            HStack {
                Image("avatar1")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 36, height: 36)
                    .clipped()
                    .cornerRadius(18)
                
                Text("Text")
                    .font(.system(size: 14, weight: .semibold))
            }
            .padding([.leading, .bottom], 8)
            
//            Post info
            Image("background1")
                .resizable()
                .scaledToFit()
                .frame(maxHeight: 440)
                .clipped()
            
            HStack(spacing: 16) {
                Button(action: {}, label: {
                    Image(systemName: "heart")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 20, height: 20)
                        .font(.system(size: 20))
                        .padding(4)
                })
                Button(action: {}, label: {
                    Image(systemName: "bubble.right")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 20, height: 20)
                        .font(.system(size: 20))
                        .padding(4)
                })
                Button(action: {}, label: {
                    Image(systemName: "paperplane")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 20, height: 20)
                        .font(.system(size: 20))
                        .padding(4)
                })
            }
            .padding(.leading, 4)
            .foregroundColor(.black)
            

//            Caption
            Text("3 likes")
                .font(.system(size: 14, weight: .semibold))
                .padding(.leading, 8)
                .padding(.bottom, 2)
            HStack {
                Text("User: ").font(.system(size: 14, weight: .semibold)) + Text(" Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis convallis eros lectus, sit amet volutpat velit eleifend nec.")
                    .font(.system(size: 14))
            }.padding(.horizontal, 8)
            Text("2d")
                .font(.system(size: 14))
                .foregroundColor(.gray)
                .padding(.leading, 8)
                .padding(.top, -2)
        }
    }
}

struct FeedCell_Previews: PreviewProvider {
    static var previews: some View {
        FeedCell()
    }
}
