//
//  SetCardGameView.swift
//  Set
//
//  Created by Jake Ledner on 6/5/25.
//

import SwiftUI

struct SetCardGameView: View {
    @ObservedObject var viewModel: SetCardGame
    private let aspectRatio: CGFloat = 2/3
    
    var body: some View {
        VStack(spacing: 0) {
            topNavBar
            cards
                .layoutPriority(1)
            score
        }
        .padding()
    }
    
    private var topNavBar: some View {
        HStack{
            newGameButtonComponent
            Spacer()
        }
        .padding(.horizontal)
        .padding(.top, 10)

    }
    
    private var score: some View {
        VStack{
            Spacer()
            HStack{
                Spacer()
                Text("Score")
                    .bold()
                    .padding(.vertical, 15)
                Spacer()
                Spacer()
                Text("")
                    .frame(minWidth: 30)
                    .padding(.vertical, 10)
                    .padding(.horizontal, 10)
                    .background(.white)
                    .clipShape(Capsule())
                    .shadow(radius: 3)
                Spacer()
            }
            .background(.ultraThinMaterial)
            .clipShape(RoundedRectangle(cornerRadius: 20))
            .shadow(radius: 10)
            .padding(.horizontal, 30)
            .padding(.bottom, 10)
            .font(.title)
            }
    }
    
    private var newGameButtonComponent: some View {
        Button("New Game"){
        }
        .foregroundColor(.blue)
        .font(.system(size: 18, weight: .semibold))
    }
    
    private var cards: some View {
        AspectVGrid(viewModel.cards, aspectRatio: aspectRatio){ card in
            CardView(card)
                .padding(4)
        }
    }

    struct CardView: View {
        let card: SetGame<SetElement>.Card
        
        init(_ card: SetGame<SetElement>.Card) {
            self.card = card
        }
        

        @ViewBuilder
        func buildCard(for element: SetElement) -> some View {
            duplicateShape(copy: applyShading(to: element.shapeProperty, with: element.colorProperty), for: element.number)
        }
        
        func applyShading(to shape: some Shape, with color: Color) -> AnyView {
            switch card.content.fill {
            case .solid: AnyView(shape.fill(color))
            case .open: AnyView(shape.stroke(color, lineWidth: 4))
            case .semi: AnyView(shape.fill(color.opacity(0.3)))
            }
        }
        
        func duplicateShape(copy view: AnyView, for num: SomeNum) -> AnyView {
            switch num {
            case .one:
                AnyView(VStack { view })
            
            case .two:
                AnyView(VStack {view; view})
            
            case .three:
                AnyView(VStack {view; view; view})
            }
        }
        
        
        var body: some View {
            ZStack {
                let base = RoundedRectangle(cornerRadius: 12)
                Group {
                    base.fill(.white)
                    base.strokeBorder(lineWidth: 2)
                    VStack{
                        buildCard(for: card.content)
                            .aspectRatio(2/3, contentMode: .fit)
                            .foregroundColor(.blue)
                            .padding(2)
                    }
                }
            }
        }
    }
}



#Preview {
    SetCardGameView(viewModel: SetCardGame())
}
