//
//  UserStatView.swift
//  InstagramSwiftUI
//
//  Created by Владимир on 03.05.2021.
//

import SwiftUI

struct UserStatView: View {
    let value: Int
    let title: String
    
    var body: some View {
        VStack {
            Text("\(value)")
                .font(.system(size: 15, weight: .semibold))
            
            Text("\(title)")
                .font(.system(size: 15))
        }.frame(width: 80, alignment: .center)
    }
}

struct UserStatView_Previews: PreviewProvider {
    static var previews: some View {
        UserStatView(value: 1, title: "Post")
    }
}
