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
            case .circle: applyShading(to: Circle())
            case .rectangle: applyShading(to: Rectangle())
            case .ellipse: applyShading(to: Ellipse())
            }
        }
        
        @ViewBuilder
        func applyShading(to shape: some Shape) -> some View {
            switch card.content.fill {
            case .solid: shape.fill(Color.blue)
            case .open: shape.stroke(Color.blue, lineWidth: 8)
            case .semi: shape.fill(Color.blue.opacity(0.3))
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
                        .padding(30)
                }
            }
        }
    }
}



#Preview {
    SetCardGameView(viewModel: SetCardGame())
}
