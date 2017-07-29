//
//  CroupierControlPanel.swift
//  Croupier
//
//  Created by Andy Bell on 26/11/2015.
//  Copyright © 2015 bellovic. All rights reserved.
//

import UIKit

class CroupierControlPanel: UIView {

    @IBOutlet weak var gridBtn: UIButton!
    @IBOutlet weak var spreadBtn: UIButton!
    @IBOutlet weak var deckBtn: UIButton!
    @IBOutlet weak var scatterBtn: UIButton!
    @IBOutlet weak var fanBtn: UIButton!
    @IBOutlet weak var paramSlider: UISlider!
    @IBOutlet weak var paramLabel: UILabel!
    @IBOutlet weak var sizeSlider: UISlider!
    @IBOutlet weak var sizeLabel: UILabel!
    
    var isOpen = false
    
    func selectBtnStateForLayoutType(layoutType: CroupierLayoutType){
        
        setupParamSliderForLayoutType(layoutType)
        
        let btnsArray = [gridBtn, spreadBtn, deckBtn, scatterBtn, fanBtn]
        
        for btn in btnsArray {
            
            var btnBgCol:UIColor?
            
            switch(layoutType){
            case .grid:
                btnBgCol = (btn == gridBtn) ? UIColor.darkGrayColor()
                : UIColor.clearColor()
            case .deck:
                btnBgCol = (btn == deckBtn) ? UIColor.darkGrayColor()
                    : UIColor.clearColor()
            case .fan:
                btnBgCol = (btn == fanBtn) ? UIColor.darkGrayColor()
                    : UIColor.clearColor()
            case .scatter:
                btnBgCol = (btn == scatterBtn) ? UIColor.darkGrayColor()
                    : UIColor.clearColor()
            case .spread:
                btnBgCol = (btn == spreadBtn) ? UIColor.darkGrayColor()
                    : UIColor.clearColor()
            }
            
            btn.backgroundColor = btnBgCol!
            
        }
        
    }
    
    func setupParamSliderForLayoutType(layoutType: CroupierLayoutType){
        
        switch(layoutType){
        case .grid:
            self.paramSlider.hidden = true
            self.paramLabel.hidden = true
            self.sizeSlider.hidden = false
            self.sizeLabel.hidden = false
        case .deck, .scatter:
            self.paramSlider.hidden = true
            self.paramLabel.hidden = true
            self.sizeSlider.hidden = true
            self.sizeLabel.hidden = true
        case .spread:
            self.paramSlider.minimumValue = 0.0
            self.paramSlider.maximumValue = 100.0
            self.paramSlider.value = 50.0
            self.paramSlider.hidden = false
            self.paramLabel.hidden = false
            self.sizeSlider.hidden = false
            self.sizeLabel.hidden = false
        case .fan:
            self.paramSlider.minimumValue = 700.0
            self.paramSlider.maximumValue = 3000.0
            self.paramSlider.value = 2000.0
            self.paramSlider.hidden = false
            self.paramLabel.hidden = false
            self.sizeSlider.hidden = false
            self.sizeLabel.hidden = false
        }
        
    }
    
}
