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
            topNavBar
            cards
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
        ZStack{
            Spacer()
            HStack{
                Spacer()
                Text("Score")
                    .bold()
                    .padding(.vertical, 20)
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
            .padding(.bottom, 40)
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
        func shapeView(for type: SomeShape) -> some View {
            switch type {
            case .circle: applyShading(to: Circle(), with: .red)
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
