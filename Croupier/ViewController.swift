//
//  ViewController.swift
//  Croupier
//
//  Created by Andy Bell on 15/11/2015.
//  Copyright © 2015 bellovic. All rights reserved.
//

import UIKit
import QuartzCore

enum CroupierLayoutType {
    case grid, deck, fan, scatter, spread
}

let reuseIdentifier = "CardCell"

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {

    @IBOutlet var collectionView:UICollectionView?
    @IBOutlet weak var selectionCollView: UICollectionView!
    @IBOutlet weak var controlPanelBottomLayoutConstraint: NSLayoutConstraint!
    @IBOutlet weak var controlPanel: CroupierControlPanel!
    @IBOutlet weak var selectCollViewHeightLayoutConstraint: NSLayoutConstraint!
    @IBOutlet weak var togglePanelBtn: UIButton!
    
    private var cardsDataSource = CardsDataSource()
    private var currentLayoutType:CroupierLayoutType = .grid
    private var snapshot: UIView?
    private var sourceIndexPath: NSIndexPath?
    private var storedItemWidth:CGFloat = 120.0 {
        didSet {
            let currentLayout = collectionView?.collectionViewLayout as? MasterCollectionViewLayout
            currentLayout?.itemWidth = storedItemWidth
            
            if self.currentLayoutType == .grid {
                collectionView?.performBatchUpdates({ () -> Void in
                    self.collectionView?.collectionViewLayout.invalidateLayout()
                    }, completion: nil)
            }else{
                self.collectionView?.collectionViewLayout.invalidateLayout()
            }
        }
    }
    private var selectCollViewIsOpen = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let longPressRecogniser = UILongPressGestureRecognizer(target: self, action: "handleLongPress:")
        collectionView!.addGestureRecognizer(longPressRecogniser)
        
        collectionView!.registerNib(UINib(nibName: "CroupierCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: reuseIdentifier)
        selectionCollView!.registerNib(UINib(nibName: "CroupierCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: reuseIdentifier)
        
        selectionCollView?.backgroundColor = UIColor.clearColor()
        
        let selectLayout = selectionCollView.collectionViewLayout as? MasterCollectionViewLayout
        selectLayout?.itemSize = CGSize(width: 60, height: 100)
        
        setupElements()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func setupElements(){
        self.selectCollViewHeightLayoutConstraint.constant = 0.0
        self.controlPanelBottomLayoutConstraint.constant = -100
        self.view.layoutIfNeeded()
    }
    
    @IBAction func sizeSliderChanged(sender: UISlider) {
        self.storedItemWidth = CGFloat(sender.value)
    }
    
    @IBAction func paramSliderChanged(sender: UISlider) {
    
        if let fanLayout = collectionView?.collectionViewLayout as? CircularCollectionViewLayout {
            fanLayout.radius = CGFloat(sender.value)
        }else if let spreadLayout = collectionView?.collectionViewLayout as? SpreadCollectionViewLayout {
            spreadLayout.spreadX = CGFloat(sender.value)
        }
        
    }
    
    
    @IBAction func toggleControlPanel(sender: AnyObject) {
        if self.controlPanel.isOpen {
            self.closePanel()
        }else{
            self.openPanel()
        }
    }
    
    private func openPanel(){
        self.controlPanelBottomLayoutConstraint.constant = 0.0
        UIView.animateWithDuration(0.3, animations: { () -> Void in
            self.controlPanel.layoutIfNeeded()
            self.togglePanelBtn.layoutIfNeeded()
            }) { (finished) -> Void in
                self.togglePanelBtn.setTitle("close", forState: .Normal)
                self.controlPanel.isOpen = true
        }
    }
    
    private func closePanel(){
        self.controlPanelBottomLayoutConstraint.constant = -100.0
        UIView.animateWithDuration(0.3, animations: { () -> Void in
            self.controlPanel.layoutIfNeeded()
            self.togglePanelBtn.layoutIfNeeded()
            }) { (finished) -> Void in
                self.togglePanelBtn.setTitle("open", forState: .Normal)
                self.controlPanel.isOpen = false
        }
    }
    
    private func updateSnapshotView(center: CGPoint, transfrom: CGAffineTransform, alpha: CGFloat){
        if let snapshot = snapshot {
            snapshot.center = center
            snapshot.transform = transfrom
            snapshot.alpha = alpha
        }
    }
    
    private func findCellIndexPathUnderLocation(location: CGPoint) -> NSIndexPath? {
        
        var matchedIdxPath:NSIndexPath?
        let visibleIndexPaths = self.collectionView?.indexPathsForVisibleItems()
        for idxPath in visibleIndexPaths! {
            let cellToCheck = collectionView?.cellForItemAtIndexPath(idxPath)
            if( CGRectContainsPoint(cellToCheck!.frame, location) ){
                matchedIdxPath = idxPath
                break
            }
        }
        return matchedIdxPath
        
    }
    
    private func touchBeganForCellAtIndexPath(indexPath: NSIndexPath){
        
        self.sourceIndexPath = indexPath
        
        let cell = collectionView?.cellForItemAtIndexPath(indexPath) as? CroupierCollectionViewCell
        
        self.snapshot = cell?.snapshot
        
        updateSnapshotView(cell!.center, transfrom: CGAffineTransformIdentity, alpha: 0.0)
        
        self.collectionView!.addSubview(snapshot!)
        
        UIView.animateWithDuration(0.25, animations: { () -> Void in
            self.updateSnapshotView((cell?.center)!, transfrom: CGAffineTransformMakeScale(1.25, 1.25), alpha: 1.0)
            cell?.moving = true
        })
        
    }

    private func touchChangedForCellAtIndexPath(indexPath: NSIndexPath, withTouchLocation location: CGPoint, andSuperLocation superLocation: CGPoint){
        
        if(superLocation.y < 100.0){
            toggleSelectViewWithLocation(location)
        }else if(self.selectCollViewHeightLayoutConstraint.constant == 100.0){
            animateSelectViewOut()
        }
        
        self.snapshot!.center = location
        self.cardsDataSource.moveCardAtIndexPath(sourceIndexPath!, toIndexPath: indexPath)
        collectionView!.moveItemAtIndexPath(sourceIndexPath!, toIndexPath: indexPath)
        sourceIndexPath = indexPath
        
    }
    
    private func touchEndedForCellAtIndexPath(indexPath: NSIndexPath, andSuperLocation superLocation: CGPoint){
        
        if( CGRectContainsPoint(selectionCollView.frame, superLocation) ){
            
            self.cardsDataSource.moveCardToSelectionAtIndexPath(sourceIndexPath!)
            self.collectionView?.deleteItemsAtIndexPaths([sourceIndexPath!])
            
            self.selectionCollView.insertItemsAtIndexPaths([NSIndexPath(forRow: (self.cardsDataSource.selectedCards.count - 1), inSection: 0)])
            
        }
        
        let cell = collectionView?.cellForItemAtIndexPath(sourceIndexPath!) as? CroupierCollectionViewCell
        UIView.animateWithDuration(0.15, animations: { () -> Void in
            self.updateSnapshotView((cell?.center)!, transfrom: CGAffineTransformIdentity, alpha: 1.0)
            cell?.moving = false
            }, completion: { (finihsed: Bool) -> Void in
                self.snapshot!.removeFromSuperview()
                self.snapshot = nil
        })

        
    }
    
    // todo: reduce this monster!
    func handleLongPress(recogniser: UILongPressGestureRecognizer){
        
        if editing {
            return
        }
        
        let superLocation = recogniser.locationInView(self.view)
        let location = recogniser.locationInView(collectionView)
        let indexPath = indexPathForLocation(location)
        
        switch recogniser.state {
        case .Began:
            
            if let indexPath = indexPath {
                touchBeganForCellAtIndexPath(indexPath)
            }
            
        case .Changed:
            
            if(self.snapshot == nil){
                return
            }
            
            if let indexPath = indexPath {
                touchChangedForCellAtIndexPath(indexPath, withTouchLocation: location, andSuperLocation: superLocation)
            }
            
        case .Ended:

            if( CGRectContainsPoint(selectionCollView.frame, superLocation) ){
                
                self.cardsDataSource.moveCardToSelectionAtIndexPath(sourceIndexPath!)
                self.collectionView?.deleteItemsAtIndexPaths([sourceIndexPath!])
                
                self.selectionCollView.insertItemsAtIndexPaths([NSIndexPath(forRow: (self.cardsDataSource.selectedCards.count - 1), inSection: 0)])
                
            }
            
            let cell = collectionView?.cellForItemAtIndexPath(sourceIndexPath!) as? CroupierCollectionViewCell
            UIView.animateWithDuration(0.15, animations: { () -> Void in
                self.updateSnapshotView((cell?.center)!, transfrom: CGAffineTransformIdentity, alpha: 1.0)
                cell?.moving = false
                }, completion: { (finihsed: Bool) -> Void in
                    self.snapshot!.removeFromSuperview()
                    self.snapshot = nil
            })
            
//            if let indexPath = indexPath {
//                touchEndedForCellAtIndexPath(indexPath, andSuperLocation: superLocation)
//            }
         
        default:
            print("default")
            
        }
        
    }

    private func indexPathForLocation(location: CGPoint) -> NSIndexPath? {
        if self.currentLayoutType == .fan {
            return findCellIndexPathUnderLocation(location)
        }else{
            return collectionView!.indexPathForItemAtPoint(location)
        }
    }
    
    private func toggleSelectViewWithLocation(location: CGPoint){
        
        print("toggle: \(location.y), select height: \(self.selectCollViewHeightLayoutConstraint.constant)")
        
        if(self.selectCollViewHeightLayoutConstraint.constant == 0.0){
            animateSelectViewIn()
            print("IN")
        }
    
    }
    
    private func animateSelectViewIn(){
        self.selectCollViewHeightLayoutConstraint.constant = 100.0
        UIView.animateWithDuration(0.7,
            delay: 0.0,
            usingSpringWithDamping: 0.5,
            initialSpringVelocity: 0.5,
            options: .CurveEaseIn,
            animations: { () -> Void in
                self.view.layoutIfNeeded()
            }, completion: nil)
    }
    
    private func animateSelectViewOut(){
        self.selectCollViewHeightLayoutConstraint.constant = 0.0
        UIView.animateWithDuration(0.3, animations: { () -> Void in
            self.view.layoutIfNeeded()
            }, completion: nil)
    }
    
    private func getCustomLayoutForType(layoutType: CroupierLayoutType) -> MasterCollectionViewLayout {
        
        switch(layoutType){
        case .grid:
            return GridCollectionViewLayout()
        case .deck:
            return DeckCollectionViewLayout()
        case .fan:
            return CircularCollectionViewLayout()
        case .scatter:
            return ScatterCollectionViewLayout()
        case .spread:
            return SpreadCollectionViewLayout()
        }
        
    }
    
    private func switchToLayoutOfType(layoutType: CroupierLayoutType){
        
        self.controlPanel.selectBtnStateForLayoutType(layoutType)
        
        self.currentLayoutType = layoutType
        let croupierLayout = getCustomLayoutForType(layoutType)
        
        croupierLayout.itemWidth = self.storedItemWidth
        
        self.collectionView?.performBatchUpdates({ () -> Void in
            
            self.collectionView?.setCollectionViewLayout(croupierLayout, animated: true)
            
            }, completion: { (finished) -> Void in
                print("done - layoutset for type: \(layoutType)")
        })
        
    }
    
    // MARK: @IBActions

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
    
    @IBAction func switchLayoutToSpreadAction(sender: AnyObject) {
        switchToLayoutOfType(.spread)
    }
    
    @IBAction func insertCardAction(sender: AnyObject) {
        
        let card = Card(number: 1, suiteId: 1)
        self.cardsDataSource.cards.insert(card, atIndex: 2)
        self.collectionView?.insertItemsAtIndexPaths([NSIndexPath(forRow: 2, inSection: 0)])
        
    }
    
    @IBAction func removeCardAction(sender: AnyObject) {
        
        self.cardsDataSource.cards.removeAtIndex(2)
        self.collectionView?.deleteItemsAtIndexPaths([NSIndexPath(forRow: 2, inSection: 0)])
        
    }


}

extension ViewController {
    
    // MARK: UICollectionViewDataSource
    
    func collectionView(collectionView: UICollectionView,
        numberOfItemsInSection section: Int) -> Int {
            if collectionView == self.collectionView {
                return cardsDataSource.cards.count
            }else{
                return cardsDataSource.selectedCards.count
            }
            
    }
    
    func collectionView(collectionView: UICollectionView,
        cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
            
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! CroupierCollectionViewCell
            
            cell.cardView.card = (collectionView == self.collectionView) ? cardsDataSource.cards[indexPath.row] : cardsDataSource.selectedCards[indexPath.row]
            
            cell.layer.zPosition = CGFloat(indexPath.row)
            
            if self.currentLayoutType == .spread {
                let translationPoint = collectionView.panGestureRecognizer.translationInView(self.view)
                self.animateInCell(cell, fromRight: (translationPoint.x > 0))
            }
            
            return cell
    
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        //let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! CroupierCollectionViewCell
        
    }
    
    func animateInCell(cell: CroupierCollectionViewCell, fromRight: Bool){
        if fromRight {
            slideInCell(cell)
        }else{
            rotateInCell(cell)
        }
    }
    
    func slideInCell(cell: CroupierCollectionViewCell){
        
        let finalFrame = cell.frame
        cell.frame = CGRect(x: finalFrame.origin.x - 100.0, y: finalFrame.origin.y, width: finalFrame.size.width, height: finalFrame.size.height)
        
        UIView.animateWithDuration(0.7) { () -> Void in
            cell.frame = finalFrame
        }
        
    }
    
    func rotateInCell(cell: CroupierCollectionViewCell){
        
        let rotStart:CGFloat = 90
        let rotEnd:CGFloat = 270
        
        var rotation = CATransform3DIdentity;
        rotation.m34 = 1.0 / -1800;
        rotation = CATransform3DRotate(rotation, rotStart * CGFloat(M_PI) / 180.0, 0, 1, 0);
        cell.layer.transform = rotation;
        
        rotation = CATransform3DRotate(rotation, rotEnd * CGFloat(M_PI) / 180.0, 0, 1, 0);
        
        UIView.animateWithDuration(0.7) { () -> Void in
            cell.layer.transform = rotation
        }
        
    }
    
}