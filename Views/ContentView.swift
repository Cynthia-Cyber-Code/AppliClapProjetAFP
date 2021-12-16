//
//  ContentView.swift
//  Creatifs
//
//  Created by apprenant41 on 26/10/2021.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        Text("Hello, content!")
            .padding()
    }
}

struct MyProfileView: View {
    @State private var address = "Springfield, Illinois"
    var body: some View {
        VStack {
            Text("Location is")
        }
    }
}

struct ProfilesView: View {
    var body: some View {
        Text("Hello, les profiles!")
            .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
