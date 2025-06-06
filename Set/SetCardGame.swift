//
//  SetCardGame.swift
//  Set
//
//  Created by Jake Ledner on 6/5/25.
//

import SwiftUI

class SetCardGame: ObservableObject {
    @Published private var model: SetGame<SetElement>
    
    init() {
        model = SetCardGame.createSetCardGame()
        model.deal(12)
    }
    
    private static func createSetCardGame() -> SetGame<SetElement> {
        var shapes: [SetElement] = []
        
        SomeNum.allCases.forEach { number in
            SomeFill.allCases.forEach { fill in
                SomeShape.allCases.forEach { shape in
                    SomeColor.allCases.forEach { color in
                        shapes.append(SetElement(shape: shape, fill: fill, number: number, color: color))
                    }
                }
            }
        }
        
        return SetGame<SetElement>(numberOfCards: shapes.count){
            index in shapes[index]
        }
    }
    
    var cards: [SetGame<SetElement>.Card] {
        return model.cardsInPlay
    }
    
    func choose(with card: SetGame<SetElement>.Card) {
        model.choose(with: card)
    }
    
    func resetGame(){
        model = SetCardGame.createSetCardGame()
        model.deal(12)
    }
    
    // MARK - INTENTS
    func deal() {
        model.deal(3)
    }
}

extension SetElement {
    var colorProperty: Color {
        switch color {
        case .red: Color.red
        case .green: Color.green
        case .purple: Color.purple
        }
    }
}

extension SetElement {
    var shapeProperty: any Shape {
        switch shape {
        case .circle: Circle()
        case .rectangle: Rectangle()
        case .capsule: Capsule()
        }
    }
}
