//
//  CroupierCollectionViewCell.swift
//  CircularCollectionView
//

import UIKit

class CroupierCollectionViewCell: UICollectionViewCell {
  
    @IBOutlet weak var cardView: CardView!
    
    var moving:Bool = false {
        didSet {
            let alpha: CGFloat = moving ? 0.0 : 1.0
            self.cardView.alpha = alpha
        }
    }
    
    var snapshot: UIView {
        get {
            let ss = snapshotViewAfterScreenUpdates(true)
            let layer = ss.layer
            layer.masksToBounds = false
            layer.shadowOffset = CGSize(width: -0.5, height: 0.0)
            layer.shadowRadius = 5.0
            layer.shadowOpacity = 0.4
            return ss
        }
    }

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

        self.layer.anchorPoint = croupLayoutAttributes.anchorpoint
        self.center.y += (croupLayoutAttributes.anchorpoint.y - 0.5) * CGRectGetHeight(self.bounds)

        self.layer.zPosition = CGFloat(croupLayoutAttributes.zIndex)

    }
  
}
