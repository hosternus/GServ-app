//
//  SearchView.swift
//  GServ
//
//  Created by Кирилл Садретдинов on 03.12.2021.
//

import SwiftUI

struct SearchView: View {
    
    @State private var searchQt = ""
    
    @State private var services: [gService] = []
    @State private var updatedServices: [gService] = []
    
    var body: some View {
        VStack(alignment: .center, spacing: 20) {
        Capsule()
            .foregroundColor(Color.accentColor.opacity(0.15))
            .overlay(
                HStack(alignment: .center, spacing: 0) {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(.accentColor)
                            .padding()
                        TextField("Что ищем сегодня?", text: $searchQt)
                        .onChange(of: searchQt) { searchValue in
                                updatedServices = services.filter { $0.name.contains(searchValue)}
                        }
                    }
                )
                .frame(minHeight: 40, maxHeight: 60)
                .padding()
            
            
            ScrollView(.vertical, showsIndicators: false) {
                VStack {
                    ForEach(updatedServices) { service in
                        ServiceCardView(service: service)
                    }
                }
            }
            
            
//            ScrollView(.vertical, showsIndicators: false) {
//                VStack(alignment: .center, spacing: 20) {
//                    ScrollView(.horizontal, showsIndicators: false) {
//                        HStack(alignment: .center, spacing: 20) {
//                            ForEach(1..<90) { num in
//                                RoundedRectangle(cornerRadius: 40)
//                                    .foregroundColor(Color.accentColor.opacity(0.15))
//                                    .frame(width: 150, height: 150, alignment: .center)
//                                    .overlay(Text(String(num)).foregroundColor(.red).bold().font(.largeTitle))
//                            }
//                        }.padding(.horizontal)
//                    }
//                    ScrollView(.horizontal, showsIndicators: false) {
//                        HStack(alignment: .center, spacing: 20) {
//                            ForEach(1..<90) { num in
//                                RoundedRectangle(cornerRadius: 40)
//                                    .foregroundColor(Color.accentColor.opacity(0.15))
//                                    .frame(width: 250, height: 250, alignment: .center)
//                                    .overlay(Text(String(num)).foregroundColor(.red).bold().font(.largeTitle))
//
//                            }
//                        }.padding(.horizontal)
//                    }
//                    ScrollView(.horizontal, showsIndicators: false) {
//                        HStack(alignment: .center, spacing: 20) {
//                            ForEach(1..<90) { num in
//                                RoundedRectangle(cornerRadius: 40)
//                                    .foregroundColor(Color.accentColor.opacity(0.15))
//                                    .frame(width: 300, height: 200, alignment: .center)
//                                    .overlay(Text(String(num)).foregroundColor(.red).bold().font(.largeTitle))
//                            }
//                        }.padding(.horizontal)
//                    }
//                }.padding(.bottom)
//            }
            
            
            
        }.onAppear {
            API().getservices() { services in
                self.services = services
            }
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
