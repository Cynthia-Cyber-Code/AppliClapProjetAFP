//
//  MapView.swift
//  Creatifs
//
//  Created by apprenant41 on 29/10/2021.
//

import SwiftUI
import MapKit

struct MapView: View {
    var showMateriels: Bool
    var showAccessoires: Bool
    var showLieux: Bool
    var showCostumes: Bool
    
    @State var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(
            latitude: 48.855459158554694,
            longitude: 2.4334211854542236),
        span: MKCoordinateSpan(
            latitudeDelta: 0.25,
            longitudeDelta: 0.25))
    @Binding var places: [IdentifiablePlace]

    var body: some View {
        Map(coordinateRegion: $region,
            // interactionModes: [.zoom],
            showsUserLocation: true,
            userTrackingMode: .constant(.follow),
            annotationItems: places
        ) { place in
            MapAnnotation(coordinate: place.location) {
                let materiels: Bool = place.hasMateriels && showMateriels
                let accessoires: Bool = place.hasAccessoires && showAccessoires
                let lieux: Bool = place.hasLieux && showLieux
                let costumes: Bool = place.hasCostumes && showCostumes
                if materiels || accessoires || lieux || costumes {
                    MapAnnotationMarker(place : place)
                }
            }
        }
        .ignoresSafeArea()
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView(showMateriels: true, showAccessoires: true, showLieux: true, showCostumes: true, places: .constant([IdentifiablePlace]()))
    }
}

struct MapAnnotationMarker: View {
    @State private var name = "Gondry"
    @State private var firstname = "Michel"
    @State private var description = "Il vaut mieux un maladroit qui essaye de faire du adroit, qu’un adroit qui essaye de faire du maladroit. C’est à l’aide de ciseaux, bâtons de colle, feutres et autres blocs de papiers que je filme grâce à un smartphone suspendu au-dessus de ma table de travail. J'aime cette esthétique du fait-maison, qui joue avec les codes de la BD et de la série Z."
    @State private var titre = "Un maladroit qui essaye de faire du adroit"
    var place: IdentifiablePlace
    var body: some View {
        NavigationLink(
            destination: DetailView(pro: Avis(image: place.photo, firstname: place.name, name: "", total: 4, description: ""), descriptionProfil: description, firstname: $firstname, name : $name),
            label: {
                ZStack {
                    Rectangle()
                        .fill(Color.red)
                        .frame(width: 40, height: 40)
                        .rotationEffect(.degrees(45))
                    ZStack {
                        Circle()
                            .fill(Color.red)
                            .frame(width: 44, height: 44)
                            .padding(.bottom, 20)
                        Image(place.photo)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 40, height: 40, alignment: .center)
                            .overlay(Circle().stroke(Color.red, lineWidth: 4))
                            .clipShape(Circle())
                            .padding(.bottom, 20)
                    }
                }
            })
    }
}
