//
//  CommentCellView.swift
//  InstagramSwiftUI
//
//  Created by Владимир on 09.05.2021.
//

import SwiftUI
import Kingfisher


struct CommentCell: View {
    let comment: Comment
    
    var body: some View {
        HStack {
            KFImage(URL(string: comment.profileImageUrl))
                .resizable()
                .scaledToFill()
                .frame(width: 36, height: 36)
                .clipShape(Circle())
            
            Text(comment.username).font(.system(size: 14, weight: .semibold)) + Text(" \(comment.commentText)").font(.system(size: 14))
            
            Text(" \(comment.timestampString ?? "")")
                .foregroundColor(.gray)
                .font(.system(size: 12))
                .padding(.trailing)
        }.padding(.horizontal)
    }
}

//struct CommentCellView_Previews: PreviewProvider {
//    static var previews: some View {
//        CommentCell()
//    }
//}
