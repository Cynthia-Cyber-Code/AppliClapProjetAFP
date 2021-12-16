//
//  ChatView.swift
//  Appli
//
//  Created by Christopher on 28/10/2021.
//

import SwiftUI

struct ChatView: View {
    @ObservedObject var model = ChatModel()
    
    @State var name: String
    @State var image: String
    
    @State var reponsesIndex = 0
    let reponses: [String] = [
        "Salut",
        "Oui je vais bien et toi ?",
        "toujours OK pour la caméra ?",
        "Magnifique"
    ]
    
    @State private var myname = "Gondry"
    @State private var firstname = "Michel"
    @State private var description = "Il vaut mieux un maladroit qui essaye de faire du adroit, qu’un adroit qui essaye de faire du maladroit. C’est à l’aide de ciseaux, bâtons de colle, feutres et autres blocs de papiers que je filme grâce à un smartphone suspendu au-dessus de ma table de travail. J'aime cette esthétique du fait-maison, qui joue avec les codes de la BD et de la série Z."
    @State private var titre = "Un maladroit qui essaye de faire du adroit"
    
    var body: some View {
        ZStack {
            Color("lightGray").ignoresSafeArea().padding(.bottom, 1)
            GeometryReader { geo in
                // MARK: - ScrollView
                CustomScrollView(scrollToEnd: true) {
                    LazyVStack {
                        ForEach(0..<model.arrayOfMessages.count, id:\.self) { index in
                            ChatBubble(position: model.arrayOfPositions[index], color: model.arrayOfPositions[index] == BubblePosition.right ?.blue : .gray) {
                                Text(model.arrayOfMessages[index])
                            }
                        }
                    }
                }
                .padding(.top,140)
                .padding(.bottom,70)
            }
            
            VStack() {
                ZStack {
                    Rectangle()
                        .fill(Color("lightGray"))
                    NavigationLink(
                        destination: DetailView(pro: Avis(image: image, firstname: name, name: "", total: 4, description: ""), descriptionProfil: description, firstname: $firstname, name : $myname),
                        label: {
                            VStack {
                                Image(image)
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .clipShape(Circle())
                                    .frame(width: 90, height: 90)
                                Text(name)
                                    .font(.title)
                                    .lineLimit(1)
                                    .offset(y: -8)
                            }
                        })
                        }
                            .frame(height: 120)
                            .padding(.top, 15)
             
                Spacer()
                // MARK: - text editor
                HStack {
                    ZStack {
                        TextEditor(text: $model.text)
                            .clipShape(RoundedRectangle(cornerRadius: 20))
                            .autocapitalization(.none)
                        //RoundedRectangle(cornerRadius: 20)
                        //.stroke()
                        //.foregroundColor(.blue)
                    }.frame(height: 35)
                    
                    Button(action: {
                        if model.text != "" {
                            model.position = model.position == BubblePosition.right ? BubblePosition.left : BubblePosition.right
                            model.arrayOfPositions.append(model.position)
                            model.arrayOfMessages.append(model.text)
                            model.text = ""
                            // repondre automatiquement
                            model.position = model.position == BubblePosition.right ? BubblePosition.left : BubblePosition.right
                            model.arrayOfPositions.append(model.position)
                            model.arrayOfMessages.append(reponses[reponsesIndex])
                            if reponsesIndex < reponses.count - 1 {
                                reponsesIndex += 1
                            } else {
                                reponsesIndex = 0
                            }
                        }
                    }) {
                        Image(systemName: "paperplane.circle.fill")
                            .font(.system(size: 33, weight: .bold))
                    }
                }
                .padding()
            }
        }
    }
}

struct CustomScrollView<Content>: View where Content: View {
    var axes: Axis.Set = .vertical
    var reversed: Bool = false
    var scrollToEnd: Bool = false
    var content: () -> Content
    
    @State private var contentHeight: CGFloat = .zero
    @State private var contentOffset: CGFloat = .zero
    @State private var scrollOffset: CGFloat = .zero
    
    var body: some View {
        GeometryReader { geometry in
            if self.axes == .vertical {
                self.vertical(geometry: geometry)
            } else {
                // implement same for horizontal orientation
            }
        }
        .clipped()
    }
    
    private func vertical(geometry: GeometryProxy) -> some View {
        VStack {
            content()
        }
        .modifier(ViewHeightKey())
        .onPreferenceChange(ViewHeightKey.self) {
            self.updateHeight(with: $0, outerHeight: geometry.size.height)
        }
        .frame(height: geometry.size.height, alignment: (reversed ? .bottom : .top))
        .offset(y: contentOffset + scrollOffset)
        .animation(.easeInOut)
        .background(Color("lightGray")).ignoresSafeArea()
        .gesture(DragGesture()
                    .onChanged { self.onDragChanged($0) }
                    .onEnded { self.onDragEnded($0, outerHeight: geometry.size.height) }
        )
    }
    
    private func onDragChanged(_ value: DragGesture.Value) {
        self.scrollOffset = value.location.y - value.startLocation.y
    }
    
    private func onDragEnded(_ value: DragGesture.Value, outerHeight: CGFloat) {
        let scrollOffset = value.predictedEndLocation.y - value.startLocation.y
        
        self.updateOffset(with: scrollOffset, outerHeight: outerHeight)
        self.scrollOffset = 0
    }
    
    private func updateHeight(with height: CGFloat, outerHeight: CGFloat) {
        let delta = self.contentHeight - height
        self.contentHeight = height
        if scrollToEnd {
            self.contentOffset = self.reversed ? height - outerHeight - delta : outerHeight - height
        }
        if abs(self.contentOffset) > .zero {
            self.updateOffset(with: delta, outerHeight: outerHeight)
        }
    }
    
    private func updateOffset(with delta: CGFloat, outerHeight: CGFloat) {
        let topLimit = self.contentHeight - outerHeight
        
        if topLimit < .zero {
            self.contentOffset = .zero
        } else {
            var proposedOffset = self.contentOffset + delta
            if (self.reversed ? proposedOffset : -proposedOffset) < .zero {
                proposedOffset = 0
            } else if (self.reversed ? proposedOffset : -proposedOffset) > topLimit {
                proposedOffset = (self.reversed ? topLimit : -topLimit)
            }
            self.contentOffset = proposedOffset
        }
    }
}

struct ViewHeightKey: PreferenceKey {
    static var defaultValue: CGFloat { 0 }
    static func reduce(value: inout Value, nextValue: () -> Value) {
        value = value + nextValue()
    }
}

extension ViewHeightKey: ViewModifier {
    func body(content: Content) -> some View {
        return content.background(GeometryReader { proxy in
            Color.clear.preference(key: Self.self, value: proxy.size.height)
        })
    }
}

enum BubblePosition {
    case left
    case right
}
class ChatModel: ObservableObject {
    var text = ""
    @Published var arrayOfMessages : [String] = []
    @Published var arrayOfPositions : [BubblePosition] = []
    @Published var position = BubblePosition.left
}
struct ChatBubble<Content>: View where Content: View {
    let position: BubblePosition
    let color : Color
    let content: () -> Content
    init(position: BubblePosition, color: Color, @ViewBuilder content: @escaping () -> Content) {
        self.content = content
        self.color = color
        self.position = position
    }
    
    var body: some View {
        HStack(spacing: 0 ) {
            content()
                .padding(.all, 15)
                .foregroundColor(Color.white)
                .background(color)
                .clipShape(RoundedRectangle(cornerRadius: 18))
                .overlay(
                    Image(systemName: "arrowtriangle.left.fill")
                        .foregroundColor(color)
                        .rotationEffect(Angle(degrees: position == .left ? -50 : -130))
                        .offset(x: position == .left ? -5 : 5)
                    ,alignment: position == .left ? .bottomLeading : .bottomTrailing)
        }
        .padding()
        .padding(position == .left ? .leading : .trailing, 15)
        .padding(position == .right ? .leading : .trailing, 40)
        .frame(width: UIScreen.main.bounds.width, alignment: position == .left ? .leading : .trailing)
    }
}

struct ChatView_Previews: PreviewProvider {
    static var previews: some View {
        ChatView(name: "Sally", image: "pp5")
    }
}
