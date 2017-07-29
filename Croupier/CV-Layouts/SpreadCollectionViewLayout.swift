//
//  SpreadCollectionViewLayout.swift
//  Croupier
//
//  Created by Andy Bell on 26/11/2015.
//  Copyright © 2015 bellovic. All rights reserved.
//

import UIKit

class SpreadCollectionViewLayout: MasterCollectionViewLayout {

    let padding:CGFloat = 100.0
    var spreadX:CGFloat = 50.0 {
        didSet {
            invalidateLayout()
        }
    }
    
    override func prepareLayout() {
        
        attributesList = (0..<self.collectionView!.numberOfItemsInSection(0)).map { (i) ->
            
            CroupierCollectionViewLayoutAttributes in
            
            let attributes = CroupierCollectionViewLayoutAttributes(forCellWithIndexPath: NSIndexPath(forItem: i, inSection: 0))
            
            attributes.size = self.itemSize
            attributes.center = CGPoint(x: ((self.itemWidth - spreadX) * CGFloat(i)) + padding, y: ((self.collectionView?.bounds.height)! / 2))
            
            attributes.zIndex = i
            
            return attributes
            
        }
        
    }
    
    override func collectionViewContentSize() -> CGSize {
        
        return CGSize(width: ((itemWidth - spreadX) * CGFloat(self.collectionView!.numberOfItemsInSection(0)) + (padding * 2)),
            height:CGRectGetHeight(collectionView!.bounds))
        
    }
    
}
