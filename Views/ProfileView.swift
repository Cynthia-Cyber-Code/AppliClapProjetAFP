//
//  MyProfileView.swift
//  Creatifs
//
//  Created by apprenant37 on 26/10/2021.
//

import SwiftUI
import MapKit

struct MonProfil: View {
    @State private var show_form: Bool = false
    @State private var name = "Gondry"
    @State private var firstname = "Michel"
    @State private var description = "Il vaut mieux un maladroit qui essaye de faire du adroit, qu’un adroit qui essaye de faire du maladroit. C’est à l’aide de ciseaux, bâtons de colle, feutres et autres blocs de papiers que je filme grâce à un smartphone suspendu au-dessus de ma table de travail. J'aime cette esthétique du fait-maison, qui joue avec les codes de la BD et de la série Z."
    @State private var titre = "Un maladroit qui essaye de faire du adroit"
    @State private var image = "MG1"
    @State private var exemple = "Exemple"
    @State private var photoMateriel = "Photo"
    @State var listeDeProfils = [
        Avis(image: "femme1", firstname: "Mathilde", name:  "Arnault", total: 4, description: "Michel est un génie. Il bricole de véritables chefs d'oeuvre."),
        Avis(image: "pp1", firstname: "Marie", name: "Harthur", total: 3, description: "Michel vous fabrique de véritables petits bijoux, avec 3 euros et un bout de ficelle, mais on ne sait jamais quand cela sera prêt."),
        Avis(image: "pp4", firstname: "James", name: "Cameron", total: 2,  description: "Michel est probablement génial. Mais comme tous les génies, on ne peut rien planifier. Si vous aimez la spontanéïté, Foncez !! mais ce n'est pas pour moi.")
    ]
    @State var offre = [
        Materiels(texte:"Clap", image: "Clap", donnee: false, descriptif : "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.")
    ]
    var isPresented = false
    
    var body: some View {
        NavigationView {
            ScrollView {
                HStack {
                    Button(action: {
                        self.show_form = true
                    }) {
                        ZStack {
                            Image(image).resizable().aspectRatio(contentMode:.fill) .clipShape(Circle()).frame(width: 80, height: 80)
                            Image(systemName: "pencil.circle.fill")
                                .font(.system(size: 33, weight: .bold))
                                .background(Color.white)
                                .clipShape(Circle())
                                .offset(x: 30, y: 30)
                                .foregroundColor(.blue)
                        }
                        .frame(width: 90, height: 90)
                    }.sheet(isPresented: self.$show_form) {
                        Formulaire(newName: $name, newFirstname: $firstname, newDescription: $description, newTitre: $titre, newImage: $image)
                    }
                    VStack(alignment: .leading) {
                        Text(firstname + " " + name)
                            .foregroundColor(.blue).font(.title)
                            .lineLimit(2)
                        Text(titre).font(.title3).padding(.bottom, 5).lineLimit(2)
                    }
                    .padding(.leading, 10)
                    Spacer()
                }
                .padding(.top, 60)
                .padding(.horizontal)
                .padding(.bottom, 10)
                
                HStack{
                    noteEtoile(nombreEtoiles: 3)
                    Text(" (\(listeDeProfils.count) avis)")
                }
                .padding(.horizontal)
                
                Text(description)
                    .fontWeight(.medium)
                    .multilineTextAlignment(.leading)
                    .lineLimit(8)
                    .padding(8)
                
                HStack {
                    Text("MES OFFRES")
                        .fontWeight(.semibold)
                        .foregroundColor(.black).opacity(0.5)
                        .padding(4)
                        .multilineTextAlignment(.leading)
                    Spacer()
                }.padding(.leading, 8)
                
                ScrollView(.horizontal) {
                    HStack{
                        ForEach(offre) { offreDeServices in
                            NavigationLink(destination: DetailMaterielView(element: offreDeServices)) {
                                MaterielEtService(element: offreDeServices)
                            }.frame(height: 130)
                        }
                        Button(action: {
                            self.offre.append(Materiels(texte: "Caméra", image: "Camera_Canon", donnee: false, descriptif : "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat."))
                        }) {
                            VStack {
                                ZStack {
                                    Rectangle()
                                        .fill(Color.white).opacity(0.4)
                                        .frame(width: 100, height: 100.0)
                                        .padding(2)
                                    Circle()
                                        .fill(Color.white)
                                        .frame(width: 40, height: 40)
                                    Image(systemName: "plus.circle.fill")
                                        .font(.system(size: 44, weight: .bold))
                                        .foregroundColor(.blue)
//                                        .opacity(0.5)
                                }
                                Spacer()
                            }.frame(height: 130)
                                .padding(.horizontal, 7)
                        }
                    }
                }
                
                HStack {
                    Text("LES AVIS")
                        .fontWeight(.semibold)
                        .foregroundColor(.black).opacity(0.5)
                        .padding(4)
                        .multilineTextAlignment(.leading)
                        .offset(y: 14)
                    Spacer()
                }.padding(.leading, 8).padding(.top, 8)
                
                VStack {
                    ForEach(listeDeProfils) { profil in
                        NavigationLink(destination: DetailView(pro: profil, descriptionProfil: description, firstname: $firstname, name : $name))
                        {
                            AvisRow(pro: profil)
                        }
                    }
                    .navigationBarTitle("")
                    .navigationBarHidden(true)
                }
                .padding(.top).padding(.bottom)
                Spacer()
            }
            .background(Color("lightGray"))
            .ignoresSafeArea(.all)
        } // NV
        .padding(.top, 0)
        .padding(.bottom, 1)
    }
}

struct MonProfil_Previews: PreviewProvider {
    static var previews: some View {
        MonProfil()
    }
}

// Lien profil des avis de la liste
struct DetailView: View {
    @State private var donnee: Bool = false
    var pro: Avis
    var descriptionProfil : String = "Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."
    @State private var profilsDesAutres = [
        Avis(image: "homme2", firstname: "Stanley", name: "Kubrick", total : 4, description: "Personne de confiance et assure dans son travail."),
        Avis(image: "pp4", firstname: "James", name: "Cameron", total: 5, description: "Un travail de qualité et du matériel très correct dont elle a pu nous en faire don après le tournage.")
    ]
    @State var offre = [
        Materiels(texte: "Caméra", image: "Camera_Canon", donnee: true, descriptif : "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat."),
        Materiels(texte: "Micro", image: "Micro", donnee: true, descriptif : "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.")
    ]
    @Binding var firstname : String
    @Binding var name : String
    
    var body: some View {
        ScrollView {
            HStack {
                NavigationLink(destination: ChatView(name: pro.firstname + " " + pro.name, image: pro.image)) {
                    ZStack {
                        Image(pro.image).resizable().aspectRatio(contentMode:.fill).clipShape(Circle()).frame(width: 80, height: 80)
                        Image(systemName: "paperplane.circle.fill")
                            .font(.system(size: 33, weight: .bold))
                            .background(Color.white)
                            .clipShape(Circle())
                            .offset(x: 30, y: 30)
                            .foregroundColor(.blue)
                    }
                    .frame(width: 90, height: 90)
                }
                VStack(alignment: .leading) {
                    Text(pro.firstname + " " + pro.name)
                        .foregroundColor(.blue).font(.title)
                        .lineLimit(1)
                    Text("son métier, sa vocation").font(.title3).padding(.bottom, 5).lineLimit(1)
                }
                .padding(.leading, 10)
                Spacer()
            }
            .padding(.top, 80)
            .padding(.horizontal)
            .padding(.bottom, 10)
            
            HStack {
                let noteTotal = profilsDesAutres.count == 0 ? 0 : profilsDesAutres.map({$0.total}).reduce(0,+)
                let moyNote = profilsDesAutres.count == 0 ? 0 : noteTotal/profilsDesAutres.count
                noteEtoile(nombreEtoiles: moyNote)
                Text(" (\(profilsDesAutres.count) avis)")
                
                noteAvis(description: "", array: $profilsDesAutres, firstname: $firstname, name: $name)
                    .padding(.horizontal, 3)
            }
            .padding(.horizontal)
            
            Text(descriptionProfil)
                .fontWeight(.medium)
                .multilineTextAlignment(.leading)
                .lineLimit(8)
                .padding(8)
            
            VStack {
                HStack {
                    Text("SES OFFRES")
                        .fontWeight(.semibold)
                        .foregroundColor(.black).opacity(0.5)
                        .padding(4)
                        .multilineTextAlignment(.leading)
                    Spacer()
                }.padding(.leading, 8).padding(.top, 8)
                
                ScrollView(.horizontal) {
                    HStack{
                        ForEach (offre) { offreDeServices in
                            NavigationLink(destination: DetailMaterielView(element: offreDeServices)) {
                                MaterielEtService(element: offreDeServices)
                            }
                        }
                    }
                }
            }
           
            HStack {
                Text("LES AVIS")
                    .fontWeight(.semibold)
                    .foregroundColor(.black).opacity(0.5)
                    .padding(4)
                    .multilineTextAlignment(.leading)
                    .offset(y: 14)
                Spacer()
            }.padding(.leading, 8).padding(.top, 8)
            
            ScrollView {
                ForEach(profilsDesAutres, id: \.id) { profil in
                    NavigationLink(destination: DetailView(pro: profil, descriptionProfil: "Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.", firstname: $firstname, name: $name))
                    {
                        AvisRow(pro: profil)
                    }
                    .navigationTitle("")
                }
            }
            .padding(.top).padding(.bottom)
            Spacer()
        }
        .background(Color("lightGray")).ignoresSafeArea()
    }
}



struct DetailMaterielView: View {
    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        return formatter
    }()
  
    @State private var dateAquisition = Date()
    @State private var dateModele = Date()
//    @State var descriptif : String
    var element : Materiels
    
    var body: some View {
        VStack(alignment: .center) {
            Image(element.image).resizable().aspectRatio(contentMode:.fill).clipShape(Rectangle()).frame(width: 200, height: 200)
            
            Text(element.texte).foregroundColor(Color.blue).font(.title)
            if element.donnee == false
            {
                NavigationLink(destination: DetailAjoutDeMaterielView(descriptif: "", newDescriptif: .constant("")))
                {
                    ZStack{
                        RoundedRectangle(cornerRadius: 25)
                            .foregroundColor(.blue.opacity(0.5))
                            .frame(width: 176, height: 30, alignment: .topLeading)
                            .padding()
                        Text("Modifier cette fiche").foregroundColor(.black)
                    }
//                    .navigationTitle("\(element.texte)")
                }
            }
            
            Spacer()
            Text("Acquis(e) le \(dateAquisition, formatter: dateFormatter)")
            Text("Le modèle date du \(dateModele, formatter: dateFormatter)")
            Spacer()
            Text("Description : \(element.descriptif)").padding()
            Spacer()
        }
    }
}

struct DetailAjoutDeMaterielView: View {
    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.locale = Locale(identifier: "fr")
//        formatter.dateFormat = DateFormatter.dateFormat(fromTemplate: "dd-MMM-yyyy", options: 0, locale: dateFormatter.locale)
        return formatter
    }()
    @State private var showingAlert = false
    @State private var dateAquisition = Date()
    @State private var dateModele = Date()
    @State var descriptif : String
    @Binding var newDescriptif : String
    //@Binding var newDateAquisition : String
    var body: some View {
        VStack {
            Form {
                Section(header: Text("Les dates du matériel (si possible)")){
                    DatePicker("date d'acquisition", selection: $dateAquisition, displayedComponents: [.date])
                    DatePicker("date du modèle", selection: $dateModele, displayedComponents: [.date])
                }
                Section(header: Text("Description de l'offre")){
                    TextEditor(text: $descriptif)
                }
            }
            Spacer()
            Button(action: {
                //newDateAquisition = String(dateAquisition)
                newDescriptif = descriptif
                showingAlert = true
            }) {
                HStack {
                    Spacer()
                    Text("Enregistrer")
                    Spacer()
                }
            }
            .foregroundColor(.white)
            .padding(10)
            .background(Color.accentColor)
            .cornerRadius(8)
            .alert(isPresented: $showingAlert) {
                Alert(title: Text("Félicitations"),
                      message: Text("Merci d'avoir rempli correctement \n Vous pouvez retourner sur la fiche détaillée pour voir le résultat").font(.title),
                      dismissButton: .default(Text("OK")))
            }
        }
    }
}

