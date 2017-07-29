//
//  CardView.swift
//  Croupier
//
//  Created by Andy Bell on 15/11/2015.
//  Copyright © 2015 bellovic. All rights reserved.
//

import UIKit

@IBDesignable

class CardView: UIView {

    var card:Card? {
        didSet {
            suiteId = card?.suiteId
            cardNumber = card?.number
        }
    }
    var cardTxt:String?
    var suiteId:CGFloat? {
        didSet {
            if(suiteId == 1 || suiteId == 4){
                textCol = UIColor.blackColor()
            }else{
                textCol = UIColor.redColor()
            }
        }
    }
    
    private var textCol:UIColor?
    private var cardNumber:CGFloat? {
        didSet {
            cardTxt = "\(Int(cardNumber!))"
            setNeedsDisplay()
        }
    }

    
    override func awakeFromNib() {
        backgroundColor = UIColor.clearColor()
    }
    
    override func drawRect(rect: CGRect) {
        
        clipsToBounds = false
        
        if(cardTxt == nil){
            cardTxt = "undefined"
        }
        
        if(suiteId == nil){
            suiteId = 1
        }
        
        let testSize = CGSize(width: rect.width * 0.95, height: rect.height * 0.95)
        
        CroupierStyleKit.drawCard(cardSize: testSize, textCol: textCol!, cardIdTxt: cardTxt!, suiteId: suiteId!)
    
    }

}
