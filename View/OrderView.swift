//
//  OrderView.swift
//  GServ
//
//  Created by Кирилл Садретдинов on 20.03.2022.
//

import SwiftUI

struct OrderView: View {
    
    let order: UserOrder
    
    var body: some View {
        
        
        VStack(alignment: .leading, spacing: 7.5) {
            VStack (alignment: .leading) {
                Text(order.sname)
                    .font(.title)
                    .fontWeight(.bold)
                Text(order.ename)
                    .font(.title3)
                    .fontWeight(.semibold)
                
            }
            orderStatusView(order: order)
            
            Spacer()
            
            
            Button(action: {}) {
                Capsule()
                    .frame(height: 70)
                    .overlay {
                        Text("Оставить отзыв")
                            .fontWeight(.medium)
                            .foregroundColor(.white)
                    }
                    .foregroundColor(.accentColor)
            }
            HStack(alignment: .center) {
                Button(action: {}) {
                    Capsule()
                        .frame(height: 70)
                        .overlay {
                            Text("Перейти к сервису")
                                .fontWeight(.medium)
                                .foregroundColor(.white)
                            
                        }
                        .foregroundColor(.accentColor)
                }
                Button(action: {}) {
                    Capsule()
                        .frame(height: 70)
                        .overlay {
                            Text("Повторить")
                                .fontWeight(.medium)
                                .foregroundColor(.white)
                        }
                        .foregroundColor(.accentColor)
                }
                
            }
            
        }.padding([.leading, .bottom, .trailing])
    }
}


struct OrderView_Previews: PreviewProvider {
    static var previews: some View {
        OrderView(order: UserOrder(id: 1, serviceid: 1, ename: "jnununi", sname: "jnjuiu", price: 323232, isCompleted: true, accepted: true))
    }
}
