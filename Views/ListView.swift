//
//  ListView.swift
//  Creatifs
//
//  Created by apprenant05 on 28/10/2021.
//

import SwiftUI

func filterPost(myArray: [IdentifiablePlace], showMateriels: Bool, showAccessoires: Bool, showLieux: Bool, showCostumes: Bool, search: String) -> [IdentifiablePost] {
    var newArray: [IdentifiablePost] = []
    for item in myArray {
        for post in item.posts {
            let materiel: Bool = post.category == "materiels" && showMateriels
            let accessoires: Bool = post.category == "accessoires" && showAccessoires
            let lieux: Bool = post.category == "lieux" && showLieux
            let costumes: Bool = post.category == "costumes" && showCostumes
            let trimmed = search
                .trimmingCharacters(in: .whitespacesAndNewlines)
                .lowercased()
                .applyingTransform(.stripDiacritics, reverse: false)!
            if materiel || accessoires || lieux || costumes {
                if trimmed != "" && (post.title.lowercased().applyingTransform(.stripDiacritics, reverse: false)!.contains(trimmed) ||  post.text.lowercased().applyingTransform(.stripDiacritics, reverse: false)!.contains(trimmed) ||  post.name.lowercased().applyingTransform(.stripDiacritics, reverse: false)!.contains(trimmed)) {
                    newArray.append(post)
                } else if trimmed == "" {
                    newArray.append(post)
                }
            }
        }
    }
    return newArray
}

struct ListView: View {
    var showMateriels: Bool
    var showAccessoires: Bool
    var showLieux: Bool
    var showCostumes: Bool
    
    @State var offres: [IdentifiablePlace] = data
    
    @State private var search : String = ""
    @State private var name = "Gondry"
    @State private var firstname = "Michel"
    @State private var description = "Il vaut mieux un maladroit qui essaye de faire du adroit, qu’un adroit qui essaye de faire du maladroit. C’est à l’aide de ciseaux, bâtons de colle, feutres et autres blocs de papiers que je filme grâce à un smartphone suspendu au-dessus de ma table de travail. J'aime cette esthétique du fait-maison, qui joue avec les codes de la BD et de la série Z."
    @State private var titre = "Un maladroit qui essaye de faire du adroit"
    var body: some View {
        VStack {
            HStack {
                TextField ("Trouver quelque chose ou quelqu'un...", text : $search)
                    .textFieldStyle(.roundedBorder)
                    .padding(.vertical, 10)
                    .padding(.leading, 20)
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
                Image(systemName: "magnifyingglass")
                    .frame(width: 10, height: 10)
                    .scaledToFit()
                    .padding()
            }
            .padding(.top, 160)
            
            ScrollView {
                ForEach(filterPost(myArray: offres, showMateriels: showMateriels, showAccessoires: showAccessoires, showLieux: showLieux, showCostumes: showCostumes, search: search), id: \.id) { post in
                    NavigationLink(destination: DetailView(pro: Avis(image: post.portrait, firstname: post.name, name: "", total: 4, description: ""), descriptionProfil: description, firstname: $firstname, name : $name)) {
                        PostCellView(post: post)
                    }
                }
            }
        }
    }
}

struct PostCellView: View {
    let post: IdentifiablePost
    //    let place: IdentifiablePlace
    var body: some View {
        HStack {
            Image(post.photo)
                .resizable()
                .aspectRatio(contentMode: /*@START_MENU_TOKEN@*/.fill/*@END_MENU_TOKEN@*/)
                .frame(width:100, height: 100, alignment: .center)
                .clipShape(Rectangle())
            Divider()
            VStack(alignment: .leading) {
                Text(post.title)
                    .font(.system(size: 18))
                    .fontWeight(.semibold)
                    .foregroundColor(.blue)
                    .multilineTextAlignment(.leading)
                    .lineLimit(1)
                Text(post.text)
                    .fontWeight(.regular)
                    .font(.system(size: 16))
                    .foregroundColor(.black)
                    .multilineTextAlignment(.leading)
                    .lineLimit(3)
                Spacer()
                HStack {
                    Spacer()
                    Text(post.name)
                        .fontWeight(.regular)
                        .font(.system(size: 16))
                        .foregroundColor(.black)
                        .multilineTextAlignment(.trailing)
                        .lineLimit(1)
                }
            }
            Spacer()
        }
        .padding(.leading, 15)
        .padding(.trailing, 5)
    }
}

//struct UsersPost: View {
//    let post: IdentifiablePost
//    var body: some View {
//        Image(post.photo)
//            .resizable()
//            .aspectRatio(contentMode: /*@START_MENU_TOKEN@*/.fill/*@END_MENU_TOKEN@*/)
//            .clipShape(Rectangle())
//            .frame(width: 15, height: 70, alignment: .trailing)
//    }
//}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        ListView(showMateriels: true, showAccessoires: true, showLieux: true, showCostumes: true)
    }
}
