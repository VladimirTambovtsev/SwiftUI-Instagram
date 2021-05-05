//
//  MainTabView.swift
//  InstagramSwiftUI
//
//  Created by Владимир on 03.05.2021.
//

import SwiftUI


struct MainTabView: View {
    var body: some View {
        NavigationView {
            TabView {
                FeedView()
                    .tabItem { Image(systemName: "house") }
                
                SearchView()
                    .tabItem { Image(systemName: "magnifyingglass") }
                
                UploadPostView()
                    .tabItem { Image(systemName: "plus.square") }
                
                NotificationView()
                    .tabItem { Image(systemName: "heart") }
                
                ProfileView()
                    .tabItem { Image(systemName: "person") }
            }
            .navigationTitle("Home")
            .navigationBarTitleDisplayMode(.inline)
            .accentColor(.black)
        }
    }
}

struct MainTabView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView()
    }
}
