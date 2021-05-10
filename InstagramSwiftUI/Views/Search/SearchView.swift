//
//  SearchView.swift
//  InstagramSwiftUI
//
//  Created by Владимир on 03.05.2021.
//

import SwiftUI

struct SearchView: View {
    @State var searchText = ""
    @State var searchMode = false
    @ObservedObject var viewModel = SearchViewModel()
    
    var body: some View {
        ScrollView {
            //  Search bar
            SearchBar(text: $searchText, isEditing: $searchMode)
                .padding()
            
            //  Photos grid
            ZStack {
                if searchMode {
                    //  Searched users list view
                    UserListView(viewModel: viewModel, searchText: $searchText)
                } else {
                    //  Photos in grid style
                    PostGridView(config: .explore)
                }
            }
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
