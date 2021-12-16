//
//  ConversationHistory.swift
//  Appli
//
//  Created by apprenant23 on 28/10/2021.
//

import SwiftUI

struct Conversation: Identifiable {
    var id = UUID()
    var name: String
    var image: String
}

func filtrerConversations( myArray: [Conversation] , search: String) -> [Conversation] {
    var newArray: [Conversation] = []
    let trimmed = search.trimmingCharacters(in: .whitespacesAndNewlines).lowercased().applyingTransform(.stripDiacritics, reverse: false)!
    for item in myArray {
        if trimmed != "" && item.name.lowercased().applyingTransform(.stripDiacritics, reverse: false)!.contains(trimmed){
            newArray.append(item)
        } else if trimmed == "" {
            newArray.append(item)
        }
    }
    return newArray
}

struct ChatHistoryView: View {
    @State var text = ""
    
    var ConversationList = [
        Conversation(name: "Lionel Messi", image: "homme1"),
        Conversation(name: "Laurent Blanc", image: "homme2"),
        Conversation(name: "Cynthia Athéna", image: "femme1"),
        Conversation(name: "Les amis de la Tour", image: "castle1"),
        Conversation(name: "Chris Topher", image: "costume1"),
        Conversation(name: "Garage Marcel", image: "car1"),
        Conversation(name: "Sally", image: "pp1"),
        Conversation(name: "Morgan", image: "pp2"),
        Conversation(name: "Jackson", image: "pp3"),
        Conversation(name: "Leonard", image: "pp4"),
        Conversation(name: "Peach Blossom", image: "pp5"),
    ]
    
    var body: some View{
        NavigationView {
            VStack {
                HStack {
                    TextField("Trouver quelqu'un...",text: $text)
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
                //                }
                ScrollView(.vertical) {
                    ForEach(filtrerConversations(myArray: ConversationList, search: text), id: \.id) { item in
                        NavigationLink(destination: ChatView(name: item.name, image: item.image)) {
                            ConvCell(myConv: item)
                        }
                    }
                }
                .padding(.top, 10)
                .background(Color("lightGray"))
            }
            .navigationBarTitle("Chats", displayMode: .inline)
            .navigationBarHidden(true)
        } // NV
    }
}

//Chaque ligne de ma List
struct ConvCell: View {
    var myConv: Conversation
    var body: some View {
        HStack(alignment: .center, spacing: 1.0) {
            Image(myConv.image)
                .resizable()
                .aspectRatio( contentMode: ContentMode.fill)
                .frame(width: 60, height: 60)
                .clipShape(Circle())
                .padding(8)
            Text(myConv.name)
                .fontWeight(.light)
                .lineLimit(2)
                .frame(width: 160, alignment: .leading)
                .multilineTextAlignment(.leading)
            Spacer()
            Image(systemName: "bubble.left.and.bubble.right")
                .font(.system(size: 28, weight: .ultraLight))
                .foregroundColor(.blue)
                .padding(.trailing, 10)
        }
        .background(Color.white.opacity(0.6))
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .padding(.horizontal, 15)
        .padding(.top, 2)  
    }
}

struct ChatHistory_Previews: PreviewProvider {
    static var previews: some View {
        ChatHistoryView()
    }
}
