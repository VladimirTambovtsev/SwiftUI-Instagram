//
//  NotificationView.swift
//  InstagramSwiftUI
//
//  Created by Владимир on 03.05.2021.
//

import SwiftUI

struct NotificationView: View {
    @ObservedObject var viewModel = NotificationsViewModel()
    
    var body: some View {
        print("viewModel.notifications: ", viewModel.notifications)
        return ScrollView {
            LazyVStack(spacing: 20) {
                ForEach(viewModel.notifications, id: \.timestamp) { notification in
                    NotificationCell(viewModel: NotificationCellViewModel(notificationParam: notification))
                        .padding(.top)
                }
            }
        }
    }
}

//struct NotificationView_Previews: PreviewProvider {
//    static var previews: some View {
//        NotificationView()
//    }
//}
