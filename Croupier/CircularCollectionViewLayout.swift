//
//  CircularCollectionViewLayout.swift
//  CircularCollectionView
//
//  Created by Andy Bell on 06/11/2015.
//  Copyright © 2015 Rounak Jain. All rights reserved.
//

import UIKit

class CircularCollectionViewLayout: MasterCollectionViewLayout {

  var angleAtExtreme: CGFloat {
      return collectionView!.numberOfItemsInSection(0) > 0 ? -CGFloat(collectionView!.numberOfItemsInSection(0) - 1) * anglePerItem : 0
  }
  
  var angle: CGFloat {
      return angleAtExtreme * collectionView!.contentOffset.x / (collectionViewContentSize().width - CGRectGetWidth(collectionView!.bounds))
  }
  
    var radius: CGFloat = 2000 {
      didSet {
        invalidateLayout()
      }
    }
    var anglePerItem: CGFloat {
      return atan(itemSize.width / radius)
    }
  
  override func collectionViewContentSize() -> CGSize {
    
    return CGSize(width: CGFloat(collectionView!.numberOfItemsInSection(0)) * itemSize.width,
      height: CGRectGetHeight(collectionView!.bounds))
    
  }
  
  override func prepareLayout() {
    
        super.prepareLayout()
    
        self.itemSize = CGSizeMake(240, 360)
    
        let centerX = collectionView!.contentOffset.x + (CGRectGetWidth(collectionView!.bounds) / 2.0)
    
        let anchorPointY = ((itemSize.height / 2.0) + radius) / itemSize.height
    
        attributesList = (0..<self.collectionView!.numberOfItemsInSection(0)).map { (i) -> CroupierCollectionViewLayoutAttributes in
      
            let attributes = CroupierCollectionViewLayoutAttributes(forCellWithIndexPath: NSIndexPath(forItem: i, inSection: 0))
            attributes.size = self.itemSize
            attributes.center = CGPoint(x: centerX, y: CGRectGetMidY(self.collectionView!.bounds))
            attributes.angle = self.angle + (self.anglePerItem * CGFloat(i))
            attributes.anchorpoint = CGPoint(x: 0.5, y: anchorPointY)
            attributes.layoutType = .fan
            
            return attributes
        
        }
    
  }
    
    override func shouldInvalidateLayoutForBoundsChange(newBounds: CGRect) -> Bool {
        return true
    }
  
  override func targetContentOffsetForProposedContentOffset(proposedContentOffset: CGPoint, withScrollingVelocity velocity: CGPoint) -> CGPoint {
    
    var finalContentOffset = proposedContentOffset
    let factor = -angleAtExtreme/(collectionViewContentSize().width -
      CGRectGetWidth(collectionView!.bounds))
    let proposedAngle = proposedContentOffset.x*factor
    let ratio = proposedAngle/anglePerItem
    var multiplier: CGFloat
    if (velocity.x > 0) {
      multiplier = ceil(ratio)
    } else if (velocity.x < 0) {
      multiplier = floor(ratio)
    } else {
      multiplier = round(ratio)
    }
    finalContentOffset.x = multiplier*anglePerItem/factor
    return finalContentOffset
    
  }
  
}
