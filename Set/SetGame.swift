//
//  SetGame.swift
//  Set
//
//  Created by Jake Ledner on 6/5/25.
//

import Foundation

struct SetGame<CardContent> {
    private(set) var cards: Array<Card>
    
    init(numberOfCards: Int, cardContentFactory: (Int) -> CardContent) {
        cards = []
        for index in 0..<numberOfCards {
            let content = cardContentFactory(index)
            cards.append(Card(id: index, content: content))
        }
    }
    
    struct Card : Identifiable {
        var id: Int
        var isInSet = false
        let content: CardContent
    }
}
