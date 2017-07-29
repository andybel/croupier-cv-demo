//
//  CardsDataSource.swift
//  Croupier
//
//  Created by Andy Bell on 26/11/2015.
//  Copyright © 2015 bellovic. All rights reserved.
//

import UIKit

class Card {
    var number: CGFloat?
    var suiteId: CGFloat?
    
    init(number: CGFloat, suiteId: CGFloat){
        self.number = number
        self.suiteId = suiteId
    }
    
}

class CardsDataSource {
    
    var cards: [Card] = []
    var selectedCards: [Card] = []
    
    private let cardStrings = ["hearts", "clubs", "spades", "diamonds"]
    
    init(){
        self.cards = shuffledCardsArray()
    }

    private func shuffledCardsArray() -> Array<Card> {
        
        var straightCards = [Card]()
        for cardStr in cardStrings {
            for i in 1...10 {
                let card = Card(number: CGFloat(i), suiteId: getSuiteIdForCardStr(cardStr))
                straightCards.append(card)
            }
        }
        return straightCards.shuffle()
        
    }
    
    private func getSuiteIdForCardStr(cardStr: String) -> CGFloat {
        
        switch(cardStr){
        case "hearts":
            return 2
        case "clubs":
            return 1
        case "diamonds":
            return 3
        case "spades":
            return 4
        default:
            return 0
        }
        
    }
    
    func moveCardAtIndexPath(indexPath: NSIndexPath, toIndexPath newIndexPath: NSIndexPath) {
        if indexPath == newIndexPath {
            return
        }
        let index = indexPath.row
        let card = cards[index]
        let newIndex = newIndexPath.row
        cards.removeAtIndex(index)
        cards.insert(card, atIndex: newIndex)
    }
    
    func moveCardToSelectionAtIndexPath(indexPath: NSIndexPath) {
        
        let index = indexPath.row//absoluteIndexForIndexPath(indexPath)
        let card = cards[index]
        
        cards.removeAtIndex(index)
        selectedCards.append(card)
        
    }
    
}

extension CollectionType {
    func shuffle() -> [Generator.Element] {
        var list = Array(self)
        list.shuffleInPlace()
        return list
    }
}

extension MutableCollectionType where Index == Int {
   
    mutating func shuffleInPlace() {
        // empty and single-element collections don't shuffle
        if count < 2 { return }
        
        for i in 0..<count - 1 {
            let j = Int(arc4random_uniform(UInt32(count - i))) + i
            guard i != j else { continue }
            swap(&self[i], &self[j])
        }
    }
}
