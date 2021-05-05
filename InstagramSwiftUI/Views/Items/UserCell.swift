//
//  UserCell.swift
//  InstagramSwiftUI
//
//  Created by Владимир on 03.05.2021.
//

import SwiftUI

struct UserCell: View {
    var body: some View {
        HStack {
            Image("avatar1")
                .resizable()
                .scaledToFill()
                .frame(width: 48, height: 48)
                .clipShape(Circle())
            
            VStack(alignment: .leading) {
                Text("User")
                    .font(.system(size: 14, weight: .semibold))
                
                Text("Firstname Lastname")
                    .font(.system(size: 14))
            }
            
            Spacer()
        }
    }
}

struct UserCell_Previews: PreviewProvider {
    static var previews: some View {
        UserCell()
    }
}
