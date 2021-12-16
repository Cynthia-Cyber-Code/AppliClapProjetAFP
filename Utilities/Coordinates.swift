//
//  Coordinates.swift
//  Creatifs
//
//  Created by apprenant41 on 03/11/2021.
//
import SwiftUI
// https://stackoverflow.com/questions/42279252/convert-address-to-coordinates-swift
import CoreLocation

struct Locations: Decodable, Identifiable {
    var id: String = UUID().uuidString
    func getCoordinates(streetaddress: String, suburb: String, state: String, postcode: String, handler: @escaping ((CLLocationCoordinate2D) -> Void)) {
        
        let fullAddress = "\(streetaddress) \(suburb), \(state) \(postcode)"
        CLGeocoder().geocodeAddressString(fullAddress) { ( placemark, error ) in
            handler(placemark?.first?.location?.coordinate ?? CLLocationCoordinate2D())
        }
    }
}

struct Coordinates: View {
    let locs = Locations()
    @State var coordString = ""
    @State var streetaddress: String = "2 rue de Provigny"
    @State var suburb: String = "Cachan"
    @State var state: String = "France"
    @State var postcode: String = ""
    
    var body: some View {
        VStack {
            Text("rue:")
            TextField("streetaddress", text: $streetaddress)
            Text("ville:")
            TextField("suburb", text: $suburb)
            Text("pays:")
            TextField("state", text: $state)
            Text("CP:")
            TextField("postcode", text: $postcode)
            Text("fullAddress = \(streetaddress) \(suburb), \(state) \(postcode)")
            Text(coordString)
                .onAppear {
                    locs.getCoordinates(streetaddress: streetaddress, suburb:suburb, state: state, postcode: postcode) { coords in
                        coordString = "\(coords.latitude), \(coords.longitude)"
                    }
                }
        }
        .padding()
    }
}

struct Coordinates_Previews: PreviewProvider {
    static var previews: some View {
        Coordinates()
    }
}

