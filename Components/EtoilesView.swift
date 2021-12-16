//
//  EtoilesView.swift
//  ApplicationCinePlace
//
//  Created by apprenant37 on 27/10/2021.
//

import Foundation
import SwiftUI

struct Etoile: View {
    @State var note : Double = 0
    @State var description: String
    @State private var showingAlert = false
    @State private var alert = false
    @Binding var listeDesAutres : [Avis]
    @Binding var newTotal: Int
    @Binding var newDescription: String
    @Binding var dismiss: Bool
    @Binding var firstname : String
    @Binding var name : String
    var body: some View {
        //        NavigationView {
        VStack{
            Button(action: {
                dismiss.toggle()
            }, label: {
                Image(systemName: "clear.fill")
                    .font(.system(size: 33))
            })
            .padding()
            
            HStack {
                Text("Ma note :")
                noteEtoile(nombreEtoiles: Int(note/10.0) + 1)
            }
            
            Slider(value: $note, in: 0...49)
                .padding()
            Form{
                Section(header: Text("Avis")){
                    TextField("Mon commentaire", text: $description).background(RoundedRectangle(cornerRadius: 50).foregroundColor( .white))
                }
            }
            
            Button(action: {
                newDescription = description
                newTotal = Int(note/10.0) + 1
                listeDesAutres.insert(Avis(image: "MG1", firstname: firstname, name: name, total: newTotal, description: description), at: 0)
                showingAlert = true
            }) {
                HStack {
                    Spacer()
                    Text("Enregistrer mon vote")
                    Spacer()
                }
            }
            .foregroundColor(.white)
            .padding(10)
            .background(Color.accentColor)
            .cornerRadius(8)
            .alert(isPresented: $showingAlert) {
                Alert(title: Text("Avis bien enregistré"),
                      message: Text("Merci \n pour votre commentaire").font(.title),
                      dismissButton:
                            .default(Text("OK")))
            }
        }
    }
    //    }
}

struct Etoile_Previews: PreviewProvider {
    static var previews: some View {
        Etoile(description: "", listeDesAutres: .constant([Avis]()), newTotal: .constant(1), newDescription: .constant(""), dismiss: .constant(false), firstname: .constant(""), name: .constant(""))
    }
}

struct noteEtoile: View {
    var nombreEtoiles: Int
    
    var body: some View {
        HStack{
            if nombreEtoiles == 1 {
                Image(systemName: "star.fill").frame(width: 14)
                Image(systemName: "star").frame(width: 14)
                Image(systemName: "star").frame(width: 14)
                Image(systemName: "star").frame(width: 14)
                Image(systemName: "star").frame(width: 14)
            } else if nombreEtoiles == 2 {
                Image(systemName: "star.fill").frame(width: 14)
                Image(systemName: "star.fill").frame(width: 14)
                Image(systemName: "star").frame(width: 14)
                Image(systemName: "star").frame(width: 14)
                Image(systemName: "star").frame(width: 14)
            } else if nombreEtoiles == 3 {
                Image(systemName: "star.fill").frame(width: 14)
                Image(systemName: "star.fill").frame(width: 14)
                Image(systemName: "star.fill").frame(width: 14)
                Image(systemName: "star").frame(width: 14)
                Image(systemName: "star").frame(width: 14)
            } else if nombreEtoiles == 4 {
                Image(systemName: "star.fill").frame(width: 14)
                Image(systemName: "star.fill").frame(width: 14)
                Image(systemName: "star.fill").frame(width: 14)
                Image(systemName: "star.fill").frame(width: 14)
                Image(systemName: "star").frame(width: 14)
            } else if nombreEtoiles == 5 {
                Image(systemName: "star.fill").frame(width: 14)
                Image(systemName: "star.fill").frame(width: 14)
                Image(systemName: "star.fill").frame(width: 14)
                Image(systemName: "star.fill").frame(width: 14)
                Image(systemName: "star.fill").frame(width: 14)
            } else {
                Image(systemName: "star").frame(width: 14)
                Image(systemName: "star").frame(width: 14)
                Image(systemName: "star").frame(width: 14)
                Image(systemName: "star").frame(width: 14)
                Image(systemName: "star").frame(width: 14)
            }
        }
        .foregroundColor(.blue)
    }
}

struct noteAvisPreviews: PreviewProvider {
    static var previews: some View {
        noteAvis(newTotal: 1, array: .constant([Avis]()), firstname : .constant(""), name : .constant(""))
    }
}

struct noteAvis: View {
    @State var newTotal: Int = 5
    @State var description: String = "description : "
    @State private var showAvis: Bool = false
    @Binding var array: [Avis]
    @Binding var firstname : String
    @Binding var name : String
    var isPresented = false
    var body: some View {
        VStack{
            Button(action: {
                showAvis = true
            }) {
                ZStack {
                    Capsule()
                        .fill(Color.blue)
                        .frame(width: 60, height: 30)
                    HStack {
                        Image(systemName: "hand.thumbsup")
                        Image(systemName: "hand.thumbsdown")
                    }
                    .foregroundColor(.white)
                }.sheet(isPresented: self.$showAvis) {
                    Etoile(description: "", listeDesAutres: $array, newTotal: $newTotal, newDescription : $description, dismiss: $showAvis, firstname: $firstname, name: $name)
                }
            }
        }
    }
}
