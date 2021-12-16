//
//  OffreView.swift
//  Creatifs
//
//  Created by apprenant37 on 27/10/2021.
//

import SwiftUI

struct Materiels : Identifiable {
    var id = UUID()
    var texte: String
    var image: String
    var donnee : Bool
    var descriptif: String
}

struct MaterielEtService: View {
    @State var element : Materiels
    var body: some View {
        VStack(alignment: .center){
            HStack {
                Spacer()
                Image(element.image)
                    .resizable()
                    .aspectRatio(contentMode: /*@START_MENU_TOKEN@*/.fill/*@END_MENU_TOKEN@*/)
                    .frame(width: 100, height: 100, alignment: .center)
                    .clipShape(Rectangle())
                    .padding(2)
                Spacer()
            }
            Text(element.texte).foregroundColor(.black).fontWeight(.semibold).lineLimit(1)
        }
        .frame(height: 130)
        
    }
}

struct MaterielEtService_Previews: PreviewProvider {
    static var previews: some View {
        MaterielEtService(element:  (Materiels(texte: "", image: "", donnee: false, descriptif: "")))
    }
}
