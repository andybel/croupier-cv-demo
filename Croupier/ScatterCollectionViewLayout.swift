//
//  ScatterCollectionViewLayout.swift
//  Croupier
//
//  Created by Andy Bell on 21/11/2015.
//  Copyright © 2015 bellovic. All rights reserved.
//

import UIKit
import QuartzCore

class ScatterCollectionViewLayout: MasterCollectionViewLayout {
    
    var rotations = [AnyObject]()
    var positions = [AnyObject]()
    
    override func prepareLayout() {
        
        generateRotations()
        generateRandomPositions()
        
        var row = 0
        var col = 0
        let rowLimit = 5
        
        let padding:CGFloat = 25.0
        
        let centerX = collectionView!.contentOffset.x + (CGRectGetWidth(collectionView!.bounds) / 2.0)
        let centerY = collectionView!.contentOffset.y + (CGRectGetHeight(collectionView!.bounds) / 2.0)
        
        attributesList = (0..<self.collectionView!.numberOfItemsInSection(0)).map { (i) ->
            
            CroupierCollectionViewLayoutAttributes in
            
            let attributes = CroupierCollectionViewLayoutAttributes(forCellWithIndexPath: NSIndexPath(forItem: i, inSection: 0))
            
            //let cellOrigin = CGPoint(x: (padding * 2.0) + (CGFloat(row) * (itemSize.width + padding)), y: (padding * 2.0) + (CGFloat(col) * (itemSize.height + padding)))
            //let cellOrigin = CGPoint(x: (CGFloat(row) * (itemSize.width + padding)), y: (CGFloat(col) * (itemSize.height + padding)))
            
            //let cellOrigin = CGPoint(x: CGFloat(arc4random() % UInt32(CGRectGetWidth(collectionView!.bounds))), y: CGFloat(arc4random() % UInt32(CGRectGetHeight(collectionView!.bounds))))
            
            //attributes.frame = CGRect(x: cellOrigin.x, y: cellOrigin.y, width: self.itemSize.width, height: self.itemSize.height)
            
            
            attributes.size = self.itemSize
            attributes.anchorpoint = CGPoint(x: 0.5, y: 0.5)
            //attributes.zIndex = i
            
            let randPos = positions[i] as! NSValue
            attributes.center = randPos.CGPointValue()
            
            let rotTrans = rotations[i] as! NSValue
            attributes.transform3D = rotTrans.CATransform3DValue
            
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
            height: CGRectGetHeight(collectionView!.bounds) * 2)
        
    }
    
    func randomPosition() -> CGPoint {
        
        let randomX = CGFloat(arc4random()) % CGRectGetWidth(collectionView!.bounds)
        let randomY = CGFloat(arc4random()) % CGRectGetHeight(collectionView!.bounds)
            
        return CGPoint(x: randomX, y: randomY)
        
    }
    
    func generateRandomPositions(){
        
        for _ in 0..<self.collectionView!.numberOfItemsInSection(0) {
            
            let scatterPos = randomPosition()
            positions.append(NSValue(CGPoint: scatterPos))
            
        }
        
    }
    
    func randomRotation() -> CATransform3D {
        
        let percentage = (CGFloat(arc4random() % 220) - 0) * 0.01
        let angle = 2.0 * CGFloat(M_PI) * (1.0 + percentage)
        
        return CATransform3DMakeRotation(angle, 0.0, 0.0, 1.0)
        
    }
    
    func generateRotations(){
        
        for _ in 0..<self.collectionView!.numberOfItemsInSection(0) {
            
            let scatterTrans = randomRotation()
            rotations.append(NSValue(CATransform3D: scatterTrans))
            
        }
        
    }
    
}

