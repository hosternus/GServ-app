//
//  MainView.swift
//  GServ
//
//  Created by Кирилл Садретдинов on 03.12.2021.
//

import SwiftUI
import CachedAsyncImage

struct ServiceCardView: View {
    
    let service: gService
    @State private var showOrderSheet = false
    
    var body: some View {
        CachedAsyncImage(url: URL(string: "https://gserv.herokuapp.com/static/ServicePhoto/\(service.id).jpg"), urlCache: .imageCache) { image in
            image
                .resizable()
                .aspectRatio(contentMode: .fill)
                .overlay(
                    VStack(alignment: .center) {
                        Spacer()
                        Capsule()
                        //                            .foregroundStyle(.ultraThinMaterial)
                            .foregroundColor(.accentColor)
                            .frame(height: 80.0, alignment: .center)
                            .overlay(
                                HStack(alignment: .center) {
                                    VStack(alignment: .leading) {
                                        Text(service.name)
                                            .font(.title)
                                            .fontWeight(.bold)
                                            .foregroundColor(.white)
                                            .minimumScaleFactor(0.25)
                                            .multilineTextAlignment(.leading)
                                        HStack(alignment: .bottom, spacing: 3.5) {
                                            Image(systemName: "star.fill")
                                                .foregroundColor(.yellow)
                                            Text(String(service.rating))
                                                .fontWeight(.medium)
                                                .foregroundColor(.white)
                                        }
                                    }
                                    //                                    COCKCOCKCOCKCOCKCOCK
                                    Spacer()
                                    Button(action: { showOrderSheet = true }, label: {
                                        
                                        Capsule()
                                            .foregroundColor(.white)
                                            .overlay {
                                                Text("Записаться")
                                                    .fontWeight(.semibold)
                                                    .foregroundColor(.accentColor)
                                            }
                                            .frame(minWidth: 100, maxWidth: 140, minHeight: 40, maxHeight: 50, alignment: .center)
                                        //                                                                                .shadow(color: .white, radius: 5, x: 0, y: 0)
                                    })
                                    .sheet(isPresented: $showOrderSheet) {
                                        CreatingOrderView(service: self.service, showOrderSheet: self.$showOrderSheet)
                                    }
                                }.padding()
                            )
                            .padding(10)
                    })
                .clipShape(RoundedRectangle(cornerRadius: 40.0))
                .padding(.horizontal)
                .shadow(radius: 7)
        } placeholder: {
            RoundedRectangle(cornerRadius: 40.0)
                .padding(.horizontal)
                .foregroundStyle(.ultraThinMaterial)
                .frame(height: 120)
                .overlay {
                    ProgressView()
                }
        }
    }
}




struct MainView: View {
    
    @State private var selectedFilter = 0
    @State private var filters: [Filter] = []
    @State private var services: [gService] = []
    
    var body: some View {
        NavigationView {
            ScrollView(.vertical, showsIndicators: false) {
                VStack(alignment: .center, spacing: 26.5) {
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(alignment: .center, spacing: 15.0) {
                            if selectedFilter != 0 {
                                Button(action: {selectedFilter = 0}) {
                                    Image(systemName: "circle.fill")
                                        .foregroundColor(.accentColor)
                                        .font(.largeTitle)
                                        .overlay(Image(systemName: "xmark")
                                            .foregroundColor(.white)
                                            .font(.headline))
                                }
                            }
                            ForEach(filters) {filter in
                                Button(action: {selectedFilter = filter.id}) {
                                    Capsule()
                                        .foregroundColor(Color.accentColor)
                                        .overlay(Text(filter.name).foregroundColor(.white))
                                        .frame(minWidth: 100, maxWidth: 140, minHeight: 40, maxHeight: 50, alignment: .center)
                                }
                            }
                        }.padding(.horizontal)
                    }.onAppear {
                        DispatchQueue.main.async {
                            API().getfilters {(filters) in self.filters = filters}
                        }
                    }
                    ForEach(selectedFilter == 0 ? services : services.filter { $0.category == selectedFilter}) { serviceItem in
                        NavigationLink(destination: {DetailCardView(service: serviceItem)}, label: {ServiceCardView(service: serviceItem)}).buttonStyle(NoAnim())
                    }
                }.padding(.bottom)
            }.navigationTitle("GSERV")
                .onAppear {
                    DispatchQueue.main.async {
                        API().getservices {(services) in self.services = services}
                    }
                }
        }.buttonStyle(PlainButtonStyle())
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
