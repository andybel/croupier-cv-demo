//
//  MasterCollectionViewLayout.swift
//  Croupier
//
//  Created by Andy Bell on 20/11/2015.
//  Copyright © 2015 bellovic. All rights reserved.
//

import UIKit

class CroupierCollectionViewLayoutAttributes: UICollectionViewLayoutAttributes {
    
    //  The anchor point is a property of CALayer around which all rotations and scaling transforms take place. The default value of this property is the center
    var anchorpoint = CGPoint(x: 0.5, y: 0.5)
    var angle: CGFloat = 0 {
        didSet {
            zIndex = Int(angle * 1000000)
            transform = CGAffineTransformMakeRotation(angle)
        }
    }
    
    //  Subclasses of UICollectionViewLayoutAttributes need to conform to the NSCopying protocol because the attribute’s objects can be copied internally when the collection view is performing a layout. You override this method to guarantee that both the anchorPoint and angle properties are set when the object is copied.
    override func copyWithZone(zone: NSZone) -> AnyObject {
        
        let copiedAttributes: CroupierCollectionViewLayoutAttributes = super.copyWithZone(zone) as! CroupierCollectionViewLayoutAttributes
        copiedAttributes.anchorpoint = self.anchorpoint
        copiedAttributes.angle = self.angle
        return copiedAttributes
        
    }
    
}

class MasterCollectionViewLayout: UICollectionViewLayout {
    
    var itemWidth:CGFloat = 120.0 {
        didSet {
            self.itemSize.width = itemWidth
            self.itemSize.height = (itemWidth * 1.6666)
            self.invalidateLayout()
        }
    }
    
    var itemSize = CGSize(width: 120, height: 200)
    
    var attributesList = [CroupierCollectionViewLayoutAttributes]()
    
    // This tells the collection view that you’ll be using CroupierCollectionViewLayoutAttributes,
    // and not the default UICollectionViewLayoutAttributes for your layout attributes.
    override class func layoutAttributesClass() -> AnyClass {
        return CroupierCollectionViewLayoutAttributes.self
    }
    
    override func layoutAttributesForElementsInRect(rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        return attributesList
    }
    
    override func layoutAttributesForItemAtIndexPath(indexPath: NSIndexPath) -> UICollectionViewLayoutAttributes? {
        return attributesList[indexPath.row]
    }
    
    override func shouldInvalidateLayoutForBoundsChange(newBounds: CGRect) -> Bool {
        return true
    }
    
}
