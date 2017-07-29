//
//  DeckCollectionViewLayout.swift
//  Croupier
//
//  Created by Andy Bell on 20/11/2015.
//  Copyright © 2015 bellovic. All rights reserved.
//

import UIKit

class DeckCollectionViewLayout: MasterCollectionViewLayout {
    
    override func prepareLayout() {
        
        let padding:CGFloat = 5.0
        
        attributesList = (0..<self.collectionView!.numberOfItemsInSection(0)).map { (i) ->
            
            CroupierCollectionViewLayoutAttributes in
            
            let attributes = CroupierCollectionViewLayoutAttributes(forCellWithIndexPath: NSIndexPath(forItem: i, inSection: 0))
            
            let xOffset = (self.collectionView!.center.x - (CGFloat(self.collectionView!.numberOfItemsInSection(0)) * (padding / 2.0)))
            let centerX = (xOffset - (self.itemSize.width / 2))
            
            let yOffset = (self.collectionView!.center.y - (CGFloat(self.collectionView!.numberOfItemsInSection(0)) * (padding / 4.0)))
            let centerY = (yOffset - (self.itemSize.height / 2))
            
            let cellOrigin = CGPoint(x: centerX + (CGFloat(i) * padding), y: centerY + (CGFloat(i) * (padding / 2.0)))
            
            attributes.frame = CGRect(x: cellOrigin.x, y: cellOrigin.y, width: self.itemSize.width, height: self.itemSize.height)
            
            attributes.zIndex = i
            
            return attributes
            
        }
        
    }
    
    override func collectionViewContentSize() -> CGSize {
        
        return (self.collectionView?.bounds.size)!//CGSize(width: CGFloat(collectionView!.numberOfItemsInSection(0)) * itemSize.width, height: CGRectGetHeight(collectionView!.bounds))
        
    }
    
}
