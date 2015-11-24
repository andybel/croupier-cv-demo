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
        
        self.itemSize = CGSizeMake(240, 360)
        
        attributesList = (0..<self.collectionView!.numberOfItemsInSection(0)).map { (i) ->
            
            CroupierCollectionViewLayoutAttributes in
            
            let attributes = CroupierCollectionViewLayoutAttributes(forCellWithIndexPath: NSIndexPath(forItem: i, inSection: 0))
            
            let centerX = ((self.collectionView?.center.x)! - (self.itemSize.width / 2))
            let centerY = ((self.collectionView?.center.y)! - (self.itemSize.height / 2))
            
            let cellOrigin = CGPoint(x: centerX + (CGFloat(i) * 5.0), y: centerY + (CGFloat(i) * 5.0))
            
            attributes.frame = CGRect(x: cellOrigin.x, y: cellOrigin.y, width: self.itemSize.width, height: self.itemSize.height)
            
            attributes.angle = 0
            attributes.anchorpoint = CGPoint(x: 0.5, y: 0.5)
            attributes.zIndex = i
            
            return attributes
            
        }
        
    }
    
    override func collectionViewContentSize() -> CGSize {
        
        return CGSize(width: CGFloat(collectionView!.numberOfItemsInSection(0)) * itemSize.width,
            height: CGRectGetHeight(collectionView!.bounds))
        
    }
    
}
