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

    override func awakeFromNib() {
        backgroundColor = UIColor.clearColor()
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
    var textCol:UIColor?
    var cardNumber:CGFloat? {
        didSet {
            
            cardTxt = "\(Int(cardNumber!))"
            
            setNeedsDisplay()
        }
    }

    
    override func drawRect(rect: CGRect) {
        
        clipsToBounds = false
        
        if(cardTxt == nil){
            cardTxt = "undefined"
        }
        
        if(suiteId == nil){
            suiteId = 1
        }
        
        CroupierStyleKit.drawCard(frame: rect, textCol: textCol!, cardIdTxt: cardTxt!, suiteId: suiteId!)
    }

}
