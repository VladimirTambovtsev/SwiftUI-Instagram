//
//  Extensions.swift
//  InstagramSwiftUI
//
//  Created by Владимир on 03.05.2021.
//

import Foundation
import UIKit


extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
