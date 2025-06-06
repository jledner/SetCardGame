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
        VStack {
            cards
        }
        .padding()
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
        func shapeView(for type: SomeShape) -> some View {
            switch type {
            case .circle: applyShading(to: Circle(), with: .blue)
            case .rectangle: applyShading(to: Rectangle(), with: .green)
            case .capsule: applyShading(to: Capsule(), with: .purple)
            }
        }
        
        @ViewBuilder
        func applyShading(to shape: some Shape, with color: Color) -> some View {
            switch card.content.fill {
            case .solid: AnyView(shape.fill(color))
            case .open: AnyView(shape.stroke(color, lineWidth: 4))
            case .semi: AnyView(shape.fill(color.opacity(0.3)))
            }
        }
        
        var body: some View {
            ZStack {
                let base = RoundedRectangle(cornerRadius: 12)
                Group {
                    base.fill(.white)
                    base.strokeBorder(lineWidth: 2)
                    shapeView(for: card.content.shape)
                        .aspectRatio(2/3, contentMode: .fit)
                        .foregroundColor(.blue)
                        .padding(20)
                }
            }
        }
    }
}



#Preview {
    SetCardGameView(viewModel: SetCardGame())
}
