//
//  MainView.swift
//  Creatifs
//
//  Created by apprenant41 on 27/10/2021.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        TabView {
            ExplorerView()
                .tabItem {
                    Label("Explorer", systemImage: "magnifyingglass")
                }
            MonProfil()
                .tabItem {
                    Label("Mon profil", systemImage: "person.circle")
                }
            ChatHistoryView()
                .tabItem {
                    Label("Chats", systemImage: "bubble.left.and.bubble.right")
                }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
