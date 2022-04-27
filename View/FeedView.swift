//
//  LogInView.swift
//  GServ
//
//  Created by Кирилл Садретдинов on 01.01.2022.
//

import SwiftUI

struct FeedView: View {
    
    @State private var feedText = ""
    let service: gService
    @Binding var showFeedSheet: Bool
    @State private var selectedStars = 0
    
    var body: some View {
        
        
        
        VStack(alignment: .center) {
            
            HStack(alignment: .center) {
                Spacer()
                Button(action: {showFeedSheet=false}, label: {
                    Image(systemName: "xmark.circle")
                        .resizable()
                        .foregroundColor(.white)
                        .frame(width: 30, height: 30, alignment: .center)
                    
                })
            }
            
            
            
            Text("Что Вы хотите сказать о сервисе \(service.name)?")
                .font(.title)
                .fontWeight(.black)
                .foregroundColor(.white)
                .multilineTextAlignment(.leading)
                .padding(.vertical)
            
            HStack(alignment: .center) {
                ForEach(1..<6) { id in
                    Button(action: {selectedStars=id}) {
                        Image(systemName: "star.fill")
                            .foregroundColor(id <= selectedStars ? .yellow : .white)
                            .font(.largeTitle)
                    }.buttonStyle(NoAnim())
                }
            }.padding()
            
            
            Capsule()
                .foregroundColor(.white)
                .overlay(TextField("Ваш отзыв", text: $feedText)
                    .padding())
                .frame(height: 40)
                .padding(.vertical)
            
            
            
            
            Spacer()
            
            
            Button(action: {
                DispatchQueue.main.async {
                    API().postfeed(feed: UserFeedback(mark: selectedStars, feed: feedText, userid: user.id, serviceid: service.id)) { response in
                        if response == 200 {
                            showFeedSheet = false
                        } else {
                            print("error while posting")
                        }
                    }
                }
                
                
                
            }) {
                Capsule()
                    .foregroundColor(.white)
                    .overlay(Text("ОПУБЛИКОВАТЬ")
                        .font(.title2)
                        .fontWeight(.black)
                        .foregroundColor(Color.accentColor))
                    .frame(height: 80)
                
            }
        }.padding()
            .background(Color.accentColor.ignoresSafeArea())
            .onAppear(perform: {UIImpactFeedbackGenerator(style: .medium).impactOccurred()})
    }
}

//struct FeedView_Previews: PreviewProvider {
//    static var previews: some View {
//        FeedView(service: gService(id: 1, category: 1, name: "Массаж", description: "descripteni", rating: 4.6))
//    }
//}
