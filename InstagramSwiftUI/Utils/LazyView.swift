//
//  LazyView.swift
//  InstagramSwiftUI
//
//  Created by Владимир on 10.05.2021.
//

import SwiftUI

struct LazyView <Content: View>: View {
    let build: () -> Content
    
    init(_ build: @autoclosure @escaping() -> Content) {
        self.build = build
    }
    
    var body: Content {
        build()
    }
}

