//
//  LogInView.swift
//  GServ
//
//  Created by Кирилл Садретдинов on 01.01.2022.
//

import SwiftUI

struct LogInView: View {
    
    @Binding var showLogInSheet: Bool
    
    @State private var secondStep = false
    @State private var userCode = ""
    @State private var userPhoneNumber = ""
    
    fileprivate func Auth() {
        
        var usr = CreatedUser(phone: Int(self.userPhoneNumber)!)
        
        if self.secondStep {
            usr.code = Int(self.userCode)
        }
        
        API().postuser(user: usr, numberSent: self.secondStep) { code in
            if code == 200 {
                if self.secondStep {
                    GServApp.appstate = .loggedin
                    self.showLogInSheet = false
                } else if !self.secondStep {
                    self.secondStep = true
                }
            } else {
                print("error while creating")
            }
        }
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack(alignment: .center) {
                Spacer()
                Button(action: { self.showLogInSheet=false }, label: {
                    Image(systemName: "xmark.circle")
                        .resizable()
                        .foregroundColor(.white)
                        .frame(width: 30, height: 30, alignment: .center)
                    
                })
            }
            
            
            Text("Войдите, прежде чем записываться на услуги")
                .font(.title)
                .fontWeight(.black)
                .foregroundColor(.white)
                .multilineTextAlignment(.leading)
                .padding(.vertical)
            Text("Ваш номер телефона:")
                .fontWeight(.bold)
                .foregroundColor(Color.white)
                .multilineTextAlignment(.leading)
            
            
            Capsule()
                .foregroundColor(.white)
                .overlay(TextField("8 (912) 345 67-89", text: $userPhoneNumber)
                    .keyboardType(.phonePad)
                    .textContentType(.telephoneNumber)
                    .padding())
                .frame(height: 46)
            
            
            if secondStep {
                Text("Код из сообщения:")
                    .fontWeight(.bold)
                    .foregroundColor(Color.white)
                    .multilineTextAlignment(.leading)
                
                
                Capsule()
                    .foregroundColor(.white)
                    .overlay(TextField("123456", text: $userCode)
                        .keyboardType(.numberPad)
                        .textContentType(.oneTimeCode)
                        .padding())
                    .frame(height: 46)
                
            }
            
            Spacer()
            
            Button(action: { Auth() }) {
                Capsule()
                    .foregroundColor(.white)
                    .overlay(Text(self.secondStep ? "ВОЙТИ" : "ПОДТВЕРДИТЬ НОМЕР")
                        .font(.title2)
                        .fontWeight(.black)
                        .foregroundColor(Color.accentColor))
                    .frame(height: 80)
            }.disabled((self.secondStep && self.userCode.count == 6) || (!self.secondStep && self.userPhoneNumber.count == 11) ? false : true)
        }.padding().onAppear(perform: {UIImpactFeedbackGenerator(style: .medium).impactOccurred()}).background(Color.accentColor.ignoresSafeArea())
    }
}


//
//struct LogInView_Previews: PreviewProvider {
//    static var previews: some View {
//        LogInView()
//    }
//}
