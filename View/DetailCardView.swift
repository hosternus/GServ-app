//
//  DetailCardView.swift
//  GServ
//
//  Created by Кирилл Садретдинов on 10.12.2021.
//

import SwiftUI
import MapKit
import CachedAsyncImage


fileprivate struct ExecOneCardView: View {
    let exec: ExecutorOneService
    var body: some View {
        ZStack {
            Color.accentColor.opacity(0.15)
            VStack(alignment: .leading) {
                Text(exec.name)
                    .font(.title2)
                    .fontWeight(.semibold)
                Text(exec.description)
                Spacer()
                Text(String(exec.price) + "₽")
                    .fontWeight(.semibold)
            }.padding(15)
        }.frame(width: 200, height: 200, alignment: .center)
    }
}



struct MapPointView: View {
    var body: some View {
        VStack(alignment: .center, spacing: 3) {
            Circle()
                .foregroundStyle(.ultraThickMaterial)
                .frame(width: 30, height: 30, alignment: .center)
                .overlay {
                    Image(systemName: "house")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .foregroundColor(.accentColor)
                        .padding(8)
                }
            Circle()
                .foregroundStyle(.ultraThickMaterial)
                .frame(width: 10, height: 10, alignment: .bottom)
        }
    }
}


struct FeedbackOneCardView: View {
    let feedback: UserFeedback
    var body: some View {
        ZStack {
            Color.accentColor.opacity(0.15)
            VStack(alignment: .leading, spacing: 0) {
                Text(feedback.name!)
                    .font(.title2)
                    .fontWeight(.semibold)
                HStack(spacing: 0.7) {
                    ForEach(0..<feedback.mark) {star in
                        Image(systemName: "star.fill")
                            .foregroundColor(.yellow)
                    }
                }
                Spacer()
                Text(feedback.feed)
                Spacer()
            }.padding(15)
        }
    }
}


struct DetailCardView: View {
    
    let service: gService
    
    @State private var execs: [ExecutorOneService] = []
    @State private var feeds: [UserFeedback] = []
    
    @State private var showFeedSheet = false
    @State private var showOrderSheet = false
    
    @State private var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 0.0, longitude: 0.0), span: MKCoordinateSpan(latitudeDelta: 0.033, longitudeDelta: 0.033))
    
    fileprivate func update() {
        DispatchQueue.main.async {
            API().getfeeds(service: service, completition: {(feeds) in self.feeds = feeds})
            API().getexecs(service: service, completition: {(execs) in self.execs = execs})
        }
    }
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(alignment: .leading, spacing: 20) {
                ZStack {
                    CachedAsyncImage(url: URL(string: "https://gserv.herokuapp.com/static/ServicePhoto/\(service.id).jpg"), urlCache: .imageCache) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                    } placeholder: {
                        ProgressView()
                    }
                    VStack(alignment: .center) {
                        Spacer()
                        HStack(alignment: .center) {
                            Text(service.name)
                                .font(.largeTitle)
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                                .shadow(radius: 7)
                            Spacer()
                            Button(action: { showOrderSheet = true }) {
                                Capsule()
                                    .foregroundColor(Color.accentColor)
                                    .frame(minWidth: 100, maxWidth: 140, minHeight: 40, maxHeight: 50, alignment: .center)
                                    .overlay {
                                        Text("Записаться")
                                            .fontWeight(.semibold)
                                            .foregroundColor(.white)
                                    }
                                    .shadow(radius: 7)
                            }.sheet(isPresented: $showOrderSheet) {
                                CreatingOrderView(service: self.service, showOrderSheet: self.$showOrderSheet)
                            }
                        }.padding()
                    }
                }.shadow(radius: 7)
                VStack(alignment: .leading, spacing: 7.5) {
                    Text("Услуги")
                        .font(.title)
                        .fontWeight(.bold)
                        .padding(.horizontal)
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(alignment: .center, spacing: 20) {
                            ForEach(execs) { execitem in
                                ExecOneCardView(exec: execitem)
                                    .clipShape(RoundedRectangle(cornerRadius: 40))
                                    .onTapGesture {
                                        showOrderSheet = true
                                    }
                                    .sheet(isPresented: $showOrderSheet) {
                                        CreatingOrderView(service: self.service, showOrderSheet: self.$showOrderSheet)
                                    }
                            }
                        }.padding(.horizontal)
                    }
                }
                VStack(alignment: .leading, spacing: 7.5) {
                    Text("Описание")
                        .font(.title)
                        .fontWeight(.bold)
                    Text(service.description)
                }.padding(.horizontal)
                
                VStack(alignment: .leading, spacing: 7.5) {
                    Text("Контакты")
                        .font(.title)
                        .fontWeight(.bold)
                    
                    HStack(alignment: .center) {
                        Image(systemName: "phone")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 17, height: 17, alignment: .center)
                        Text(String(service.phone))
                    }
                    
                    HStack(alignment: .center) {
                        Image(systemName: "house")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 17, height: 17, alignment: .center)
                        Text(service.address)
                    }
                    
                    Map(coordinateRegion: $region, annotationItems: [MapPoint(coordinates: CLLocationCoordinate2D(latitude: service.latitude, longitude: service.longitude))]) { location in
                        MapAnnotation(coordinate: location.coordinates) { MapPointView() }
                    }
                    .frame(height: 230, alignment: .center)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    .onAppear {
                        region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: service.latitude, longitude: service.longitude), span: MKCoordinateSpan(latitudeDelta: 0.0033, longitudeDelta: 0.0033))
                    }
                }.padding(.horizontal)
                
                
                VStack(alignment: .leading, spacing: 7.5) {
                    HStack(alignment: .center, spacing: 7.5) {
                        Text("Отзывы")
                            .font(.title)
                            .fontWeight(.bold)
                        Image(systemName: "star.fill")
                            .foregroundColor(.yellow)
                        Text(String(service.rating))
                            .fontWeight(.thin)
                    }.padding(.horizontal)
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(alignment: .center, spacing: 20) {
                            Button(action: {showFeedSheet = true}) {
                                Image(systemName: "plus.circle.fill")
                                    .foregroundColor(Color.accentColor)
                                    .font(.largeTitle)
                            }.sheet(isPresented: $showFeedSheet, onDismiss: { update() }, content: {
                                FeedView(service: service, showFeedSheet: self.$showFeedSheet)
                            })
                            ForEach(feeds.sorted { itemA, itemB in
                                itemA.id! > itemB.id!
                            }) { feedbackItem in
                                FeedbackOneCardView(feedback: feedbackItem)
                                    .frame(width: 250, height: 200, alignment: .center)
                                    .clipShape(RoundedRectangle(cornerRadius: 40))
                            }
                        }.padding(.horizontal)
                    }
                }
            }.padding(.bottom)
        }.edgesIgnoringSafeArea([.top]).onAppear { update() }
    }
}


struct DetailCardView_Previews: PreviewProvider {
    static var previews: some View {
        DetailCardView(service: s1)
    }
}
