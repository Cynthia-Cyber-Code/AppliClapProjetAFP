//
//  AvisRowView.swift
//  Creatifs
//
//  Created by apprenant37 on 27/10/2021.
//
import Foundation
import SwiftUI

struct Avis: Identifiable {
    var id = UUID()
    var image: String
    var firstname: String
    var name: String
    var total : Int
    var description: String
}

struct AvisRow: View {
    var pro: Avis
    
    var body: some View {
        VStack {
            HStack {
                Text("\(pro.firstname) \(pro.name)")
                    .fontWeight(.semibold)
                    .foregroundColor(.black)
                    .multilineTextAlignment(.center)
                    .lineLimit(2)
                Spacer()
                noteEtoile(nombreEtoiles: pro.total).padding(.top, 5)
            }
            HStack(alignment: .top) {
                Image(pro.image).resizable().aspectRatio(contentMode:.fill) .clipShape(Circle()).frame(width: 90, height: 90)
                Text(pro.description)
                    .fontWeight(.regular)
                    .foregroundColor(.black)
                    .multilineTextAlignment(.leading)
                    .lineLimit(5)
                Spacer()
            }
            
        } // VS
        .frame(height: 140)
        .padding(.horizontal, 10)
//        .background(Color.white)
    }
}

struct AvisRow_Previews: PreviewProvider {
    static var previews: some View {
        AvisRow(pro: Avis(image: "MG1", firstname: "Michel", name: "Gondry", total: 5, description: "description"))
    }
}
