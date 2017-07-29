//
//  SelectedCardsCollectionViewLayout.swift
//  Croupier
//
//  Created by Andy Bell on 26/11/2015.
//  Copyright © 2015 bellovic. All rights reserved.
//

import UIKit

class SelectedCardsCollectionViewLayout: MasterCollectionViewLayout {

    let padding:CGFloat = 5.0
    
    override func prepareLayout() {
        
        self.itemWidth = 50.0
        
        attributesList = (0..<self.collectionView!.numberOfItemsInSection(0)).map { (i) ->
            
            CroupierCollectionViewLayoutAttributes in
            
            let attributes = CroupierCollectionViewLayoutAttributes(forCellWithIndexPath: NSIndexPath(forItem: i, inSection: 0))
            
            // we want all card to appear centered in the coll view
            // calculate total width of cards
            let totalCardsWidth = ((itemWidth + padding) * CGFloat(self.collectionView!.numberOfItemsInSection(0)))
            
            // calculate "startX" - x pos of card #1
            let cardsXPadding = (CGRectGetWidth(self.collectionView!.bounds) - totalCardsWidth) / 2.0

            attributes.frame = CGRect(x: ((itemWidth + padding) * CGFloat(i)) + cardsXPadding, y: 5.0, width: self.itemSize.width, height: self.itemSize.height)
            
            return attributes
            
        }
        
    }
    
    override func collectionViewContentSize() -> CGSize {
        
        return CGSize(width: ((itemWidth + padding) * CGFloat(self.collectionView!.numberOfItemsInSection(0))),
            height:CGRectGetHeight(collectionView!.bounds))
        
    }
    
}
