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
        
        return SetGame<SetElement>(numberOfCards: 20){
            index in shapes[index]
        }
    }
    
    var cards: Array<SetGame<SetElement>.Card> {
        return model.cards
    }
}
