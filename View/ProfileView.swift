//
//  ProfileView.swift
//  GServ
//
//  Created by Кирилл Садретдинов on 03.12.2021.
//

import SwiftUI
import CachedAsyncImage

struct ProfileView: View {
    
    @State private var useraddress = user.address
    @State private var userphone = String(user.phone)
    
    var body: some View {
        
        if GServApp.appstate == .loggedin {
            
            NavigationView {
                ScrollView(.vertical, showsIndicators: false) {
                    VStack(alignment: .leading, spacing: 15) {
                        Capsule()
                            .foregroundStyle(.ultraThinMaterial)
                            .overlay {
                                HStack(alignment: .center, spacing: 0) {
                                    CachedAsyncImage(url: URL(string: "https://www.culture.ru/storage/images/b446463a8b1265f3f18d11bc4f9c1761/87355361794d12dbea11c4674db7277c.jpeg")) { image in
                                        image
                                            .resizable()
                                            .aspectRatio(contentMode: .fill)
                                            .clipShape(Circle())
                                            .frame(width: 100, height: 100, alignment: .center)
                                            .padding()
                                            .shadow(radius: 7)
                                    } placeholder: {
                                        ProgressView()
                                            .padding()
                                    }
                                    VStack(alignment: .leading) {
                                        Group {
                                            Text(user.name)
                                                .fontWeight(.semibold)
                                            Text(user.surname)
                                                .fontWeight(.semibold)
                                        }
                                        .multilineTextAlignment(.leading)
                                        .font(.title)
                                    }
                                    Spacer()
                                }
                            }
                            .padding(.horizontal)
                            .frame(height: 130)
                        
                        
                        Capsule()
                            .foregroundStyle(.ultraThinMaterial)
                            .overlay {
                                VStack(alignment: .leading, spacing: 15) {
                                    HStack(alignment: .center) {
                                        Image(systemName: "phone.fill")
                                        TextField("Ваш номер телефона", text: $userphone)
                                            .keyboardType(.phonePad)
                                            .textContentType(.telephoneNumber)
                                        Spacer()
                                        Image(systemName: "pencil")
                                    }.padding(.horizontal)
                                }
                            }
                            .padding(.horizontal)
                            .frame(height: 70)
                        
                        
                        
                        Capsule()
                            .foregroundStyle(.ultraThinMaterial)
                            .overlay {
                                VStack(alignment: .leading, spacing: 15) {
                                    HStack(alignment: .center) {
                                        Image(systemName: "house.fill")
                                        TextField("Ваш адрес", text: $useraddress)
                                        Spacer()
                                        Image(systemName: "pencil")
                                    }.padding(.horizontal)
                                }
                            }
                            .padding(.horizontal)
                            .frame(height: 70)
                        
                    }
                    .navigationTitle("Профиль")
                    .navigationBarTitleDisplayMode(.large)
                }
            }
            
        } else {
            LogInTHRTABView()
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
