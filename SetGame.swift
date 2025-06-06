//
//  SetGame.swift
//  Set
//
//  Created by Jake Ledner on 6/5/25.
//

import Foundation

struct SetGame<CardContent> {
    private(set) var cards: Array<Card>
    
    init(cardContentFactory: (Int) -> CardContent) {
        cards = []
        for index in 0..<5 {
            let content = cardContentFactory(index)
            cards.append(Card(id: index, content: content))
        }
    }
    
    struct Card : Identifiable {
        var id: Int
        var isInSet = false
        let content: CardContent
    }
    
    struct Shape {
        var name: String
        var fill: String
        var numShapes: Int
        var color: String
    }
}
