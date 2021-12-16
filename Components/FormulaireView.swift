//
//  FormulaireView.swift
//  Creatifs
//
//  Created by apprenant37 on 29/10/2021.
//

import SwiftUI

struct Formulaire: View {
    @Environment(\.presentationMode) var presentationMode
    @State var name: String = ""
    @State var firstname: String = ""
    @State var description: String = ""
    @State var titre: String = ""
    @State var imageDuProfil: String = "MG1"
    @State private var fondName = Color.white
    @State private var fondFirstname = Color.white
    @State private var showingAlert = false
    @State private var alert = false
    @Binding var newName: String
    @Binding var newFirstname: String
    @Binding var newDescription: String
    @Binding var newTitre: String
    @Binding var newImage: String
    var body: some View {
        VStack {
            Button(action: {
                self.presentationMode.wrappedValue.dismiss()
            }) {
                Image(systemName: "clear.fill")
                    .font(.system(size: 33))
            }.padding()
            Form(content: {
                Section(header: Text("Nom Prénom"))
                {
                    TextField("Nom", text: $name).background(RoundedRectangle(cornerRadius: 50).fill(fondName.opacity(0.2)))
                    TextField("Prénom", text: $firstname)
                        .background(RoundedRectangle(cornerRadius: 50).fill(fondFirstname.opacity(0.2)))
                }
                Section(header: Text("À propos de moi, en quelques mots"))
                {
                    TextEditor(text: $titre)
                }
                Section(header: Text("À propos de moi, en quelques lignes"))
                {
                    TextEditor(text: $description)
                }
                Section(header: Text("Image profil"))
                {
                    HStack {
                        ImageIllustration(imageProfil : "MG2")
                        ImageIllustration(imageProfil : "MG3")
                        ImageIllustration(imageProfil : imageDuProfil)
                    }
                }
                
                Button(action: {
                    if name.isEmpty {
                        self.fondName = Color.red
                        newName = "Gondry"
                    } else {
                        self.fondName = Color.white
                        newName = name
                        showingAlert = true
                    }
                    
                    if firstname.isEmpty {
                        self.fondFirstname = Color.red
                        newFirstname = "Michel"
                    } else {
                        self.fondFirstname = Color.white
                        newFirstname = firstname
                        showingAlert = true
                    }
                    
                    if description.isEmpty {
                        newDescription = "Il vaut mieux un maladroit qui essaye de faire du adroit, qu’un adroit qui essaye de faire du maladroit. C’est à l’aide de ciseaux, bâtons de colle, feutres et autres blocs de papiers que je filme grâce à un smartphone suspendu au-dessus de ma table de travail. J'aime cette esthétique du fait-maison, qui joue avec les codes de la BD et de la série Z."
                    } else {
                        newDescription = description
                        showingAlert = true
                    }
                    
                    if titre.isEmpty {
                        newTitre = "Un maladroit qui essaye de faire du adroit"
                    } else {
                        newTitre = titre
                        showingAlert = true
                    }
                }) {
                    HStack {
                        Spacer()
                        Text("Valider")
                        Spacer()
                    }
                }
                .foregroundColor(.white)
                .padding(10)
                .background(Color.accentColor)
                .cornerRadius(8)
                .alert(isPresented: $showingAlert) {
                    Alert(title: Text("Formulaire bien enregistré"),
                          message: Text("Merci \(firstname)\n Vous pouvez retourner sur votre profil").font(.title),
                          dismissButton: .default(Text("OK")))
                }
            })
        }
    }
}

struct ImageIllustration: View {
    var imageProfil : String
    var body: some View {
        HStack(alignment: .center) {
            Spacer()
            Image(imageProfil).resizable().aspectRatio(contentMode:.fill) .clipShape(Circle()).frame(width: 50, height: 50)
            Spacer()
        }
    }
}
