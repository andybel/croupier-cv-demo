//
//  ViewController.swift
//  Croupier
//
//  Created by Andy Bell on 15/11/2015.
//  Copyright © 2015 bellovic. All rights reserved.
//

import UIKit

enum CroupierLayoutType {
    case grid, deck, fan, scatter
}

let reuseIdentifier = "CardCell"

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {

    var selectIdx:Int = 999
    var currentLayoutType:CroupierLayoutType = .grid
    
    @IBOutlet var collectionView:UICollectionView?
    
    let cardStrings = ["hearts", "clubs", "spades", "diamonds"]
    var cards:[NSDictionary]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cards = shuffledCardsArray()
        
        collectionView!.registerNib(UINib(nibName: "CroupierCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: reuseIdentifier)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func shuffledCardsArray() -> Array<NSDictionary> {
    
        var straightCards = [NSDictionary]()
        
        for cardStr in cardStrings {
            
            for i in 1...10 {
                
                let cardData = ["cardNum": i, "cardSuite":getSuiteIdForCardStr(cardStr)]
                straightCards.append(cardData)
                
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
    
    private func getCustomLayoutForType(layoutType: CroupierLayoutType) -> UICollectionViewLayout {
        
        switch(layoutType){
        case .grid:
            return GridCollectionViewLayout()
        case .deck:
            return DeckCollectionViewLayout()
        case .fan:
            return CircularCollectionViewLayout()
        case .scatter:
            return ScatterCollectionViewLayout()
        }
        
    }
    
    private func switchToLayoutOfType(layoutType: CroupierLayoutType){
        
        self.currentLayoutType = layoutType
        let croupierLayout = getCustomLayoutForType(layoutType)
        
        self.collectionView?.reloadData()
        self.collectionView?.performBatchUpdates({ () -> Void in
            
            self.collectionView?.collectionViewLayout.invalidateLayout()
            self.collectionView?.setCollectionViewLayout(croupierLayout, animated: true)
            
            }, completion: { (finished) -> Void in
                print("done - layoutset for type: \(layoutType)")
        })
        
    }

    @IBAction func switchLayoutToGridAction(sender: AnyObject) {
        
        switchToLayoutOfType(.grid)
        
    }
    
    @IBAction func switchLayoutToDeckAction(sender: AnyObject) {
        switchToLayoutOfType(.deck)
    }
    
    @IBAction func switchLayoutToFanAction(sender: AnyObject) {
        
        switchToLayoutOfType(.fan)
        
    }
    
    @IBAction func switchLayoutToScatterAction(sender: AnyObject) {
        
        switchToLayoutOfType(.scatter)
        
    }

}

extension ViewController {
    
    // MARK: UICollectionViewDataSource
    
    func collectionView(collectionView: UICollectionView,
        numberOfItemsInSection section: Int) -> Int {
            return cards!.count
    }
    
    func collectionView(collectionView: UICollectionView,
        cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
            
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! CroupierCollectionViewCell
            
            let cardData = cards![indexPath.row]
            
            cell.cardView.suiteId = cardData["cardSuite"] as? CGFloat
            cell.cardView.cardNumber = cardData["cardNum"] as? CGFloat
            
            cell.contentView.backgroundColor = UIColor.clearColor()
            
//            if(currentLayoutType == .scatter){
//             
//                let percentage = (CGFloat(arc4random() % 220) - 0) * 0.01
//                let angle = 2.0 * CGFloat(M_PI) * (1.0 + percentage)
//                let transRot = CATransform3DMakeRotation(angle, 0.0, 0.0, 1.0)
//                cell.layer.transform = transRot
//                
//            }
            
            return cell
    
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        self.selectIdx = indexPath.row
        
        switchLayoutToFanAction(self)
        
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
    /// Shuffle the elements of `self` in-place.
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


