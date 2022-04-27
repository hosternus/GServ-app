//
//  OrdersView.swift
//  GServ
//
//  Created by Кирилл Садретдинов on 14.01.2022.
//

import SwiftUI


enum OrderStatus {
    case ordered
    case sheluded
    case completed
    case UncaughtStatus
}


func getStatus(order: UserOrder) -> OrderStatus {
    var statusEnum: OrderStatus
    if order.isCompleted && order.accepted {
        statusEnum = OrderStatus.completed
    } else if order.accepted && !order.isCompleted {
        statusEnum = OrderStatus.sheluded
    } else if !order.accepted && !order.isCompleted {
        statusEnum = OrderStatus.ordered
    } else {
        statusEnum = OrderStatus.UncaughtStatus
    }
    return statusEnum
}

struct slabel: View {
    let string: String
    let color: Color
    let icon: String
    var body: some View {
        HStack(alignment: .center, spacing: 4) {
            Image(systemName: icon)
                .foregroundColor(color)
            Text(string)
                .fontWeight(.medium)
        }
    }
}

@ViewBuilder func orderStatusView(order: UserOrder) -> some View {
    
    
    
    switch getStatus(order: order) {
    case .ordered:
        slabel(string: "Обрабатывается", color: .yellow, icon: "clock.fill")
    case .sheluded:
        slabel(string: "Запланирован", color: .green, icon: "clock.fill")
    case .completed:
        slabel(string: "Выполнен", color: .green, icon: "checkmark.circle.fill")
    case .UncaughtStatus:
        slabel(string: "Ошибка", color: .red, icon: "exclamationmark.circle.fill")
    }
}

fileprivate struct OneOrderView: View {
    
    let order: UserOrder
//    @State private var showFeedView = false
    
    var body: some View {
        
        VStack {
            HStack(alignment: .center) {
                Text(order.ename)
                    .font(.title)
                    .fontWeight(.black)
                    .minimumScaleFactor(0.4)
                Spacer()
                Text(order.sname)
                    .font(.title3)
                    .fontWeight(.bold)
                    .minimumScaleFactor(0.4)
            }
            
            HStack(alignment: .center) {
                orderStatusView(order: order)
                Spacer()
                Text(String(order.price)+" ₽")
                    .font(.title3)
                    .fontWeight(.medium)
            }
        }.padding()
            .background(
                RoundedRectangle(cornerRadius: 20)
                    .foregroundColor(
                        .accentColor.opacity(0.15)
                    )
            )
            .frame(height: 80)
//            .contextMenu
//        {
//            Button(action: { showFeedView = true }) {
//
//                Text("Оставить отзыв")
//                Image(systemName: "plus.message")
//            }.sheet(isPresented: $showFeedView) {
//                FeedView(service: gService(id: order.serviceid, category: 0, phone: 0, name: order.sname, description: "", address: "", rating: 0, longitude: 0, latitude: 0), showFeedSheet: $showFeedView)
//            }
//
//            Button(action: { print("action 2 triggered") }, label:
//                    {
//                Text("Повторить")
//                Image(systemName: "arrow.clockwise")
//            })
//            Button(action: { print("action 2 triggered") }, label:
//                    {
//                Text("Перейти к сервису")
//                Image(systemName: "arrow.forward")
//            })
//        }
    }
}

struct OrdersListView: View {
    
    @State private var orders: [UserOrder] = []
    
    fileprivate func update() {
        DispatchQueue.main.async {
            API().getorders(user: user) { recievedOrders in
                self.orders = recievedOrders
            }
        }
    }
    
    var body: some View {
        NavigationView{
            ScrollView {
                VStack(spacing: 25) {
                    ForEach(orders.sorted { itemA, itemB in
                        itemA.id > itemB.id
                    }) { order in
                        NavigationLink(destination: OrderView(order: order)) {
                            OneOrderView(order: order)
                        }
                    }
                }.padding()
            }.navigationBarTitleDisplayMode(.large).navigationTitle("Заказы")
        }
        .buttonStyle(PlainButtonStyle())
        .onAppear { update() }
    }
}

struct OrdersView_Previews: PreviewProvider {
    static var previews: some View {
        OrdersListView()
    }
}


//
//RoundedRectangle(cornerRadius: 20)
//    .foregroundColor(.accentColor.opacity(0.15))
//    .frame(height: 80)
//    .overlay {
//        VStack {
//            HStack(alignment: .center) {
//                Text(order.ename)
//                    .font(.title)
//                    .fontWeight(.black)
//                    .minimumScaleFactor(0.4)
//                Spacer()
//                Text(order.sname)
//                    .font(.title3)
//                    .fontWeight(.bold)
//                    .minimumScaleFactor(0.4)
//            }
//
//            HStack(alignment: .center) {
//                orderStatusView(order: order)
//                Spacer()
//                Text(String(order.price)+" ₽")
//                    .font(.title3)
//                    .fontWeight(.medium)
//            }
//        }.padding()
//    }
