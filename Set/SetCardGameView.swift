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
        let card: SetGame<SomeShape>.Card
        
        init(_ card: SetGame<SomeShape>.Card) {
            self.card = card
        }
        
        @ViewBuilder
        func shapeView(for type: SomeShape) -> some View {
            switch type {
            case .circle: Circle()
            case .rectangle: Rectangle()
            case .ellipse: Ellipse()
            }
        }
        
        var body: some View {
            ZStack {
                let base = RoundedRectangle(cornerRadius: 12)
                Group {
                    base.fill(.white)
                    base.strokeBorder(lineWidth: 2)
                    shapeView(for: card.content)
                        .minimumScaleFactor(0.01)
                        .aspectRatio(1/2, contentMode: .fit)
                        .foregroundColor(.blue)
                }
            }
        }
    }
}



#Preview {
    SetCardGameView(viewModel: SetCardGame())
}
