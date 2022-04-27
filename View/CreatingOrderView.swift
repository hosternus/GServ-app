//
//  OrderingView.swift
//  GServ
//
//  Created by Кирилл Садретдинов on 13.03.2022.
//

import SwiftUI


fileprivate struct ExecOneCardView: View {
    let exec: ExecutorOneService
    var body: some View {
        ZStack {
            Color.white.opacity(0.15)
            VStack(alignment: .leading) {
                Text(exec.name)
                    .font(.title2)
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                Text(exec.description)
                    .foregroundColor(.white)
                Spacer()
                Text(String(exec.price) + "₽")
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
            }.padding(15)
        }.frame(width: 200, height: 200, alignment: .center)
    }
}



struct CreatingOrderView: View {
    
    let service: gService
    @State private var execs: [ExecutorOneService] = []
    @State private var additionalText = "2222-09-09 22:22:22.123456"
    @State private var showLogInSheet = false
    @State private var selectedExec = ExecutorOneService(id: 0, name: "", description: "", price: 0)
    
    @Binding var showOrderSheet: Bool
    
    fileprivate func getExecs() {
        DispatchQueue.main.async {
            API().getexecs(service: service, completition: {(execs) in self.execs = execs})
        }
    }
    
    fileprivate func sendOrder() {
        if GServApp.appstate == .loggedin {
            DispatchQueue.main.async {
                API().postorder(order: PostOrder(runtime: self.additionalText, uslugaid: self.selectedExec.id, userid: user.id)) { response in
                    if response == 200 {
                        self.showOrderSheet = false
                    } else {
                        print("error while posting")
                    }
                }
            }
        } else {
            self.showLogInSheet = true
        }
        
    }
    
    var body: some View {
        VStack(alignment: .center) {
            
            HStack(alignment: .center) {
                Spacer()
                Button(action: { showOrderSheet=false }, label: {
                    Image(systemName: "xmark.circle")
                        .resizable()
                        .foregroundColor(.white)
                        .frame(width: 30, height: 30, alignment: .center)
                    
                })
            }
            
            
            
            Text("Запись в \(service.name)")
                .font(.title)
                .fontWeight(.black)
                .foregroundColor(.white)
                .multilineTextAlignment(.leading)
                .padding(.vertical)
            
            VStack(alignment: .leading, spacing: 7.5) {
                Text("Выберите услугу")
                    .font(.title)
                    .fontWeight(.bold)
                    .padding(.horizontal)
                    .foregroundColor(.white)
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(alignment: .center, spacing: 20) {
                        ForEach(execs) { execitem in
                            ExecOneCardView(exec: execitem)
                                .clipShape(RoundedRectangle(cornerRadius: 40))
                                .onTapGesture {
                                    selectedExec = execitem
                                }
                                .overlay {
                                    RoundedRectangle(cornerRadius: 40)
                                        .stroke(lineWidth: 3)
                                        .opacity(execitem.id == self.selectedExec.id ? 1 : 0)
                                        .foregroundColor(.white)
                                        .padding(2)
                                }
                        }
                    }.padding(.horizontal)
                }
            }
            
            
            
            Capsule()
                .foregroundColor(.white)
                .overlay(TextField("Ваши пожелания", text: $additionalText)
                    .padding())
                .frame(height: 40)
                .padding(.vertical)
            
            
            Spacer()
            
            
            Button(action: { sendOrder() }) {
                Capsule()
                    .foregroundColor(.white)
                    .overlay(Text(self.selectedExec.price != 0.0 ? "ОПЛАТИТЬ " + String(self.selectedExec.price) + "₽" : "ОПЛАТИТЬ")
                        .font(.title2)
                        .fontWeight(.black)
                        .foregroundColor(Color.accentColor))
                    .frame(height: 80)
                    .disabled(self.selectedExec.price == 0.0)
                
            }
            .sheet(isPresented: $showLogInSheet, onDismiss: {
                //                    sendOrder()
                
            }, content: {LogInView(showLogInSheet: $showLogInSheet)})
        }.padding().background(Color.accentColor.ignoresSafeArea())
            .onAppear {
                UIImpactFeedbackGenerator(style: .medium).impactOccurred()
                getExecs()
            }
    }
}

//struct OrderingView_Previews: PreviewProvider {
//    static var previews: some View {
//        OrderingView(execs: [exeserv], service: s1)
//    }
//}
