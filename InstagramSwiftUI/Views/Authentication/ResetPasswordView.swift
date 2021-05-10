//
//  ResetPasswordView.swift
//  InstagramSwiftUI
//
//  Created by Владимир on 04.05.2021.
//

import SwiftUI

struct ResetPasswordView: View {
    @EnvironmentObject var viewModel: AuthViewModel
    @State private var email = ""
    @Environment(\.presentationMode) var mode

    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color.purple, Color.blue]), startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            
            VStack {
                Image("instagram_logo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 220, height: 100)
                    .foregroundColor(.white)
                
                VStack {
                    //  Email
                    CustomTextField(text: $email, placeholder: Text("Email"), imageName: "envelope")
                        .padding()
                        .background(Color(.init(white: 1, alpha: 0.15)))
                        .cornerRadius(10)
                        .foregroundColor(.white)
                        .padding(.horizontal, 32)
                }
                
                
                //                    Sign in
                Button(action: {
                    viewModel.resetPassword(email: email)
                }, label: {
                    Text("Reset Password")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(width: 360, height: 50)
                        .background(Color(#colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)))
                        .clipShape(Capsule())
                        .padding()
                })
                
                Spacer()
                
                //                    Sign up
                NavigationLink(
                    destination: RegistrationView().navigationBarHidden(true),
                    label: {
                        HStack {
                            Text("Don't have account yet?")
                                .font(.system(size: 14))
                            
                            Text("Sign Up")
                                .font(.system(size: 14, weight: .semibold))
                        }
                        .padding(.bottom, 32)
                        .foregroundColor(.white)
                    }).padding(.top, -44)
                
            }
        }
        .onReceive(viewModel.$didSendResetPassword) { perform in
            self.mode.wrappedValue.dismiss()
        }
    }
}

struct ResetPasswordView_Previews: PreviewProvider {
    static var previews: some View {
        ResetPasswordView()
    }
}
