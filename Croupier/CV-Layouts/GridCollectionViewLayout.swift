//
//  GridCollectionViewLayout.swift
//  Croupier
//
//  Created by Andy Bell on 20/11/2015.
//  Copyright © 2015 bellovic. All rights reserved.
//

import UIKit

class GridCollectionViewLayout: MasterCollectionViewLayout {
    
//    private var row = 0
    private var col = 0
    private let padding:CGFloat = 25.0
    
    override func prepareLayout() {
        
        var row = 0
        col = 0
        
        let rowLimit = Int((self.collectionView?.frame.width)! / (padding + (itemSize.width + padding)))
        
        attributesList = (0..<self.collectionView!.numberOfItemsInSection(0)).map { (i) ->
            
            CroupierCollectionViewLayoutAttributes in
            
            let attributes = CroupierCollectionViewLayoutAttributes(forCellWithIndexPath: NSIndexPath(forItem: i, inSection: 0))
            
            let cellOrigin = CGPoint(x: padding + (CGFloat(row) * (itemSize.width + padding)), y: (padding * 2.0) + (CGFloat(col) * (itemSize.height + padding)))
            attributes.frame = CGRect(x: cellOrigin.x, y: cellOrigin.y, width: self.itemSize.width, height: self.itemSize.height)
            
            if(row == rowLimit){
                row = 0
                ++col
            }else{
                ++row
            }
            
            return attributes
            
        }
        
    }
    
    override func collectionViewContentSize() -> CGSize {
        
        return CGSize(width: CGRectGetWidth(collectionView!.bounds),
            height: CGFloat((padding + (itemSize.height + padding)) * CGFloat(col + 1)))
        
    }
    
}
