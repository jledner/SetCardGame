//
//  SetGame.swift
//  Set
//
//  Created by Jake Ledner on 6/5/25.
//

import Foundation

struct SetGame<CardContent> {
    private(set) var deck: Array<Card>
    private(set) var cardsInPlay: [Card] // currently dealt cards

    
    init(numberOfCards: Int, cardContentFactory: (Int) -> CardContent) {
        deck = []
        cardsInPlay = []
        
        for index in 0..<numberOfCards {
            let content = cardContentFactory(index)
            deck.append(Card(id: index, content: content))
        }
    }
    
    mutating func choose(with card: Card){
        if let chosenIndex = cardsInPlay.firstIndex(where: { $0.id == card.id
        }) {
            cardsInPlay[chosenIndex].isSelected.toggle()
        }
    }
    
    mutating func deal(_ count: Int){
        let next = deck.prefix(count)
        cardsInPlay.append(contentsOf: next)
        deck.removeFirst(min(count, deck.count))
    }
    
    struct Card : Identifiable {
        var id: Int
        var isSelected = false
        let content: CardContent
    }
}
