//
//  Data.swift
//  Creatifs
//
//  Created by apprenant41 on 29/10/2021.
//

import Foundation
import MapKit

var data: [IdentifiablePlace] = [
    IdentifiablePlace(lat: 48.855459158554694, long: 2.4334211854542236,
                      name: "Lionel Messi", photo: "homme1", bio: "kdfkfjdkj", note: 1,
                      hasMateriels: true, hasAccessoires: false, hasLieux: false, hasCostumes: false,
                      comments: [
                        IdentifiableComment(txt: "super", date: "25 déc 2020", author: "Spielberg")
                      ], posts: [
                        IdentifiablePost(title: "Apporte caméra HX550 PRO", text: "J'apporte ma caméra pour participer à des tournages de courts métrages", photo: "camera1", category: "materiels", name: "Lionel Messi", portrait: "homme1")
                      ]),
    IdentifiablePlace(lat: 48.89600885967493, long: 2.4714541249839157,
                      name: "Laurent Blanc", photo: "homme2", bio: "kdfkfjdkj", note: 2,
                      hasMateriels: false, hasAccessoires: true, hasLieux: false, hasCostumes: false,
                      comments: [
                        IdentifiableComment(txt: "super", date: "25 déc 2020", author: "Spielberg")
                      ], posts: [
                        IdentifiablePost(title: "Cède projecteur 16mm", text: "Je cède un projecteur cinéma 16 mm ayant beaucoup servi mais complètement opé", photo: "projecteur1", category: "materiels", name: "Laurent Blanc", portrait: "homme2")
                      ]),
    IdentifiablePlace(lat: 48.825459158554694, long: 2.4934211854542236,
                      name: "Cynthia Athéna", photo: "femme1", bio: "kdfkfjdkj", note: 3,
                      hasMateriels: false, hasAccessoires: false, hasLieux: true, hasCostumes: false,
                      comments: [
                        IdentifiableComment(txt: "super", date: "25 déc 2020", author: "Spielberg")
                      ], posts: [
                        IdentifiablePost(title: "Prête clap numérique", text: "Je prête un clap numérique standard X500, sur plusieurs semaines possible, Tips welcome", photo: "clap1", category: "materiels", name: "Cynthia Athéna", portrait: "femme1")
                      ]),
    IdentifiablePlace(lat: 50.855459158554694, long: 1.5334211854542236,
                      name: "Les amis de la Tour", photo: "castle1", bio: "kdfkfjdkj", note: 4,
                      hasMateriels: false, hasAccessoires: false, hasLieux: true, hasCostumes: false,
                      comments: [
                        IdentifiableComment(txt: "super", date: "25 déc 2020", author: "Spielberg")
                      ], posts: [
                        IdentifiablePost(title: "Met à disposition château", text: "L'association des amis de la tour Vauban met à disposition son patrimoine pour vos scènes Contre publicité sur les réseaux sociaux", photo: "castle1", category: "lieux", name: "Les amis de la Tour", portrait: "castle1")
                      ]),
    IdentifiablePlace(lat: 44.855459158554694, long: 6.5334211854542236,
                      name: "Chris Topher", photo: "costume1", bio: "kdfkfjdkj", note: 4,
                      hasMateriels: false, hasAccessoires: false, hasLieux: false, hasCostumes: true,
                      comments: [
                        IdentifiableComment(txt: "super", date: "25 déc 2020", author: "Spielberg")
                      ], posts: [
                        IdentifiablePost(title: "Apporte costume d'époque", text: "J'apporte un costume d'époque contre actorat ou figuration", photo: "costume1", category: "costumes", name: "Chris Topher", portrait: "costume1")
                      ]),
    IdentifiablePlace(lat: 48.855459158554694, long: 2.5334211854542236,
                      name: "Garage Marcel", photo: "car1", bio: "kdfkfjdkj", note: 4,
                      hasMateriels: false, hasAccessoires: true, hasLieux: false, hasCostumes: false,
                      comments: [
                        IdentifiableComment(txt: "super", date: "25 déc 2020", author: "Spielberg")
                      ], posts: [
                        IdentifiablePost(title: "Cède épaves de voiture", text: "Casse pro cède carcasses de voiture pour vos cascades ou plan intérieur, contre enlèvement, et citation au générique", photo: "car1", category: "accessoires", name: "Garage Marcel", portrait: "car1")
                      ]),
]

struct IdentifiablePlace: Identifiable {
    let id: UUID
    let location: CLLocationCoordinate2D
    let name: String
    let photo: String
    let bio: String
    let note: Int
    let hasMateriels: Bool
    let hasAccessoires: Bool
    let hasLieux: Bool
    let hasCostumes: Bool
    let comments: [IdentifiableComment]
    let posts: [IdentifiablePost]
    init(id: UUID = UUID(), lat: Double, long: Double,
         name: String, photo: String, bio: String, note: Int = 0,
         hasMateriels: Bool, hasAccessoires: Bool, hasLieux: Bool, hasCostumes: Bool,
         comments: [IdentifiableComment], posts: [IdentifiablePost]) {
        self.id = id
        self.location = CLLocationCoordinate2D(
            latitude: lat,
            longitude: long)
        self.name = name
        self.photo = photo
        self.bio = bio
        self.note = note
        self.hasMateriels = hasMateriels
        self.hasAccessoires = hasAccessoires
        self.hasLieux = hasLieux
        self.hasCostumes = hasCostumes
        self.comments = comments
        self.posts = posts
    }
}

struct IdentifiableComment: Identifiable {
    let id = UUID()
    let txt: String
    let date: String
    let author: String
}

struct IdentifiablePost: Identifiable {
    let id = UUID()
    let title: String
    let text: String
    let photo: String
    let category: String
    let name: String
    let portrait: String
}
