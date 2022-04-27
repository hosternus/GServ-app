//
//  MainTabView.swift
//  GServ
//
//  Created by Кирилл Садретдинов on 03.12.2021.
//

import SwiftUI

struct MainTabView: View {
    var body: some View {
        TabView {
            MainView()
                .tabItem {
//                    Image(systemName: "heart.text.square")
                    Image(systemName: "lanyardcard.fill")
                    Text("Услуги")
                }
//            SearchView()
//                .tabItem{
//                    Image(systemName: "magnifyingglass")
//                    Text("Поиск")
//                }
            OrdersListView()
                .tabItem {
                    Image(systemName: "list.bullet.rectangle.fill")
                    Text("Заказы")
                }
            ProfileView()
                .tabItem {
                    Image(systemName: "person")
                    Text("Профиль")
                }
        }
    }
}

struct MainTabView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView()
    }
}
