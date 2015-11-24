//
//  CroupierCollectionViewCell.swift
//  CircularCollectionView
//

import UIKit

class CroupierCollectionViewCell: UICollectionViewCell {
  
    @IBOutlet weak var cardView: CardView!
  
  @IBOutlet weak var imageView: UIImageView?
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    contentView.layer.shouldRasterize = true
    contentView.layer.rasterizationScale = UIScreen.mainScreen().scale
    contentView.clipsToBounds = false
    layer.masksToBounds = false
  }
  
  override func applyLayoutAttributes(layoutAttributes: UICollectionViewLayoutAttributes) {
    
      super.applyLayoutAttributes(layoutAttributes)
    
    let croupLayoutAttributes = layoutAttributes as! CroupierCollectionViewLayoutAttributes
    
    //if(croupLayoutAttributes.layoutType == .fan){
        self.layer.anchorPoint = croupLayoutAttributes.anchorpoint
        self.center.y += (croupLayoutAttributes.anchorpoint.y - 0.5) * CGRectGetHeight(self.bounds)
    //}
    
    self.layer.zPosition = CGFloat(croupLayoutAttributes.zIndex)
    
    
  }
  
}
