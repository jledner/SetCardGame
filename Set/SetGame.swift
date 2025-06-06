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
    private(set) var selectedCards: [Card]

    
    init(numberOfCards: Int, cardContentFactory: (Int) -> CardContent) {
        deck = []
        cardsInPlay = []
        selectedCards = []
        for index in 0..<numberOfCards {
            let content = cardContentFactory(index)
            deck.append(Card(id: index, content: content))
        }
    }
    
    mutating func choose(with card: Card){
        if let chosenIndex = cardsInPlay.firstIndex(where: { $0.id == card.id
        }) {
            cardsInPlay[chosenIndex].isSelected.toggle()
            selectedCards.append(cardsInPlay[chosenIndex])
            if selectedCards.count == 3 {
            }
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
        
        var debugDescription: String {
            "\(id) - \(isSelected ? "selected" : "" )"
        }
    }
}

extension SetGame where CardContent == SetElement {
    mutating func choose(with card: Card) {
        if let chosenIndex = cardsInPlay.firstIndex(where: { $0.id == card.id }) {
            cardsInPlay[chosenIndex].isSelected.toggle()
            selectedCards.append(cardsInPlay[chosenIndex])
            if selectedCards.count >= 3 {
                checkForSet(with: selectedCards)
            }
        }
    }

    mutating func checkForSet(with selection: [Card]) {
        print("✅ Specialized checkForSet called")
        let referenceShape = selection[0].content.shape
        for givenCard in selection {
            print(givenCard.content.shape)
            if givenCard.content.shape == referenceShape {
                cardsInPlay.removeAll { $0.id == givenCard.id }
            }
        }
    }
}
