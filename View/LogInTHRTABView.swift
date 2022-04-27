//
//  LogInTHRTABView.swift
//  GServ
//
//  Created by Кирилл Садретдинов on 20.03.2022.
//

import SwiftUI

struct LogInTHRTABView: View {
    
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
            
            
            
            Text("Войдите, прежде чем записываться на услуги")
                .font(.title)
                .fontWeight(.black)
                .multilineTextAlignment(.leading)
                .padding(.vertical)
            Text("Ваш номер телефона:")
                .fontWeight(.bold)
                .multilineTextAlignment(.leading)
            
            
            Capsule()
                .foregroundColor(.accentColor.opacity(0.25))
                .overlay(TextField("8 (912) 345 67-89", text: $userPhoneNumber)
                    .keyboardType(.phonePad)
                    .textContentType(.telephoneNumber)
                    .padding())
                .frame(height: 46)
            
            
            if secondStep {
                Text("Код из сообщения:")
                    .fontWeight(.bold)
                    .multilineTextAlignment(.leading)
                
                
                Capsule()
                    .foregroundColor(.accentColor.opacity(0.25))
                    .overlay(TextField("123456", text: $userCode)
                        .keyboardType(.numberPad)
                        .textContentType(.oneTimeCode)
                        .padding())
                    .frame(height: 46)
                
            }
            
            Spacer()
            
            Button(action: { Auth() }) {
                Capsule()
                    .foregroundColor(.accentColor)
                    .overlay(
                        Text(self.secondStep ? "ВОЙТИ" : "ПОДТВЕРДИТЬ НОМЕР")
                        .font(.title2)
                        .fontWeight(.black)
                    )
                    .frame(height: 80)
            }.disabled((self.secondStep && self.userCode.count == 6) || (!self.secondStep && self.userPhoneNumber.count == 11) ? false : true)
        }.padding()
        
    }
}

struct LogInTHRTABView_Previews: PreviewProvider {
    static var previews: some View {
        LogInTHRTABView()
    }
}
