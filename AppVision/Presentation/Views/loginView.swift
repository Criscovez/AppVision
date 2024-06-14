//
//  loginView.swift
//  AppVision
//
//  Created by Cristian Contreras Velásquez on 10-06-24.
//

import SwiftUI

struct loginView: View {
    @Environment(AppStateVM.self) private var appStateVM
    
    @State private var user: String = "bejl@keepcoding.es"
    @State private var pass: String = "123456"
    
    var body: some View {
        ZStack {
            ZStack {
                Image(.cielo)
                    .resizable()
                
                HStack {
                    VStack {
                        Image(.gokuOK)
                            .resizable()
                            .scaledToFit()
                            .padding([.all], 20)
                    }
                    
                    VStack {
                        Image(.logo)
                            .resizable()
                            .scaledToFit()
                            .padding(.top, 70)
                        
                        Form {
                            Section {
                                TextField("Ususrio", text: $user)
                                    .textInputAutocapitalization(.never)
                                    .autocorrectionDisabled()
                                    .font(.title)
                                    .id(1)
                            }
                            Section {
                               SecureField("Clave", text: $pass)
                                    .textInputAutocapitalization(.never)
                                    .autocorrectionDisabled()
                                    .font(.title)
                                    .id(2)
                                
                            }
                        }
                        .padding(.top, 50)
                        .padding([.leading, .trailing], 10)
                        
                        Button(action: {
                            Task {
                                await appStateVM.login(user: self.user, password: self.pass)
                            }
                        }, label: {
                            Text("Login")
                                .font(.title)
                                .padding()
                                .frame(width: 400, height: 60)
                        })
                        .background(Color.orange)
                        .cornerRadius(20)
                        .padding(.bottom, 50)
                    }
                }
            }
        }
    }
}

#Preview {
    loginView()
        .environment(AppStateVM())
}
