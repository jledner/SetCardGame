//
//  SetCardGame.swift
//  Set
//
//  Created by Jake Ledner on 6/5/25.
//

import SwiftUI

class SetCardGame: ObservableObject {
    @Published private var model: SetGame<SetElement>
    
    
    private(set) var shapes = [ SetElement(shape: .circle, fill: .semi, number: .three, color: .red), SetElement(shape: .rectangle, fill: .open, number: .three, color: .red), SetElement(shape: .ellipse, fill: .solid, number: .three, color: .red) ]
    
    
    init() {
        model = SetCardGame.createSetCardGame(for: shapes)
    }
    
    private static func createSetCardGame(for shapes: [SetElement]) -> SetGame<SetElement> {
        SetGame<SetElement>(numberOfCards: shapes.count){
            index in shapes[index]
        }
    }
    
    var cards: Array<SetGame<SetElement>.Card> {
        return model.cards
    }
}
