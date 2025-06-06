//
//  SetCardGame.swift
//  Set
//
//  Created by Jake Ledner on 6/5/25.
//

import SwiftUI

class SetCardGame: ObservableObject {
    @Published private var model: SetGame<SomeShape>
    private(set) var shapes = [SomeShape.circle, SomeShape.rectangle, SomeShape.circle, SomeShape.rectangle, SomeShape.ellipse]
    
    
    init() {
        model = SetCardGame.createSetCardGame(for: shapes)
    }
    
    private static func createSetCardGame(for shapes: [SomeShape]) -> SetGame<SomeShape> {
        SetGame<SomeShape>(){
            index in shapes[index]
        }
    }
    
    var cards: Array<SetGame<SomeShape>.Card> {
        return model.cards
    }
}
