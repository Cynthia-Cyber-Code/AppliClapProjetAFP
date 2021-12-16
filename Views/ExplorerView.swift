//
//  Explorer.swift
//  Creatifs
//
//  Created by apprenant41 on 26/10/2021.
//

import SwiftUI
import MapKit

struct ExplorerView: View {
    @State private var selectorIndex = 0
    @State private var selectorList = ["Carte","Liste"]
    
    @State private var showMateriels: Bool = true
    @State private var showAccessoires: Bool = true
    @State private var showLieux: Bool = true
    @State private var showCostumes: Bool = true
    
    @State private var places: [IdentifiablePlace] = data
    
    var body: some View {
        NavigationView {
            ZStack {
                if selectorIndex == 0 {
                    MapView(showMateriels: showMateriels, showAccessoires: showAccessoires, showLieux: showLieux, showCostumes: showCostumes, places: $places)
                } else {
                    ListView(showMateriels: showMateriels, showAccessoires: showAccessoires, showLieux: showLieux, showCostumes: showCostumes)
                }
                
                VStack {
                    Color.white
                        .ignoresSafeArea()
                        .frame(height: 55)
                    Spacer()
                }
                
                VStack {
                    Picker("ViewMode", selection: $selectorIndex) {
                        ForEach(0 ..< selectorList.count) { index in
                            Text(self.selectorList[index]).tag(index)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .padding()
                    
                    HStack {
                        Spacer()
                        Button { showMateriels.toggle() }
                    label: {
                        CategoryFilter(icon: "camera", text: "Matériels", isActive: showMateriels)
                    }
                        Spacer()
                        Button { showAccessoires.toggle() }
                    label: {
                        CategoryFilter(icon: "umbrella", text: "Accessoires", isActive: showAccessoires)
                    }
                        Spacer()
                        Button { showLieux.toggle() }
                    label: {
                        CategoryFilter(icon: "house", text: "Lieux", isActive: showLieux)
                    }
                        Spacer()
                        Button { showCostumes.toggle() }
                    label: {
                        CategoryFilter(icon: "tshirt", text: "Costumes", isActive: showCostumes)
                    }
                        Spacer()
                    }
                    Spacer()
                }
            } // ZStack
            .navigationBarTitle("Explorer", displayMode: .inline)
            .navigationBarHidden(true)
        } // NavView
        .padding(.top, 0)
        .padding(.bottom, 1)
    } // body
} // struct

struct CategoryFilter: View {
    let icon: String
    let text: String
    let isActive: Bool
    var body: some View {
        VStack {
            Image(systemName: icon)
                .imageScale(.large)
                .foregroundColor(isActive ? .white : /*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                .frame(width: 44, height: 44, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                .padding(.all, 4)
                .overlay(Circle().stroke(Color.blue, lineWidth: 4))
                .background(isActive ? Color.blue :  Color.white)
                .clipShape(Circle())
            Text(text)
                .font(.system(size: 14))
                .padding(4)
                .padding(.leading, 2)
                .padding(.trailing, 2)
                .lineLimit(1)
                .background(Color.white)
                .foregroundColor(.black)
                .clipShape(Capsule())
                .shadow(color: .gray, radius: 4.0, x: 0, y: 0)
        }
    }
}

struct Map_Previews: PreviewProvider {
    static var previews: some View {
        ExplorerView()
    }
}
