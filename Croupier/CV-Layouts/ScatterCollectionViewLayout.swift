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
        
        generateRandomRotations()
        generateRandomPositions()
        
        attributesList = (0..<self.collectionView!.numberOfItemsInSection(0)).map { (i) ->
            
            CroupierCollectionViewLayoutAttributes in
            
            let attributes = CroupierCollectionViewLayoutAttributes(forCellWithIndexPath: NSIndexPath(forItem: i, inSection: 0))
            
            attributes.size = self.itemSize
            
            let randPos = positions[i] as! NSValue
            attributes.center = randPos.CGPointValue()
            
            let rotTrans = rotations[i] as! NSValue
            attributes.transform3D = rotTrans.CATransform3DValue
            
            return attributes
            
        }
        
    }
    
    override func collectionViewContentSize() -> CGSize {
        return collectionView!.bounds.size
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
    
    func generateRandomRotations() {
        
        //var randRotations = [AnyObject]()
        for _ in 0..<self.collectionView!.numberOfItemsInSection(0) {
            let scatterTrans = randomRotation()
            rotations.append(NSValue(CATransform3D: scatterTrans))
        }
        //return randRotations
    }
    
}

