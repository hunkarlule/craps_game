//
//  BetButton.swift
//  SevenEleven
//
//  Created by hunkar lule on 2018-11-26.
//  Copyright © 2018 hunkar lule. All rights reserved.
//

import UIKit

@IBDesignable
class BetButton: UIButton {
    
    private struct Constants {
        static let plusButtonScale: CGFloat = 0.6
        
    }
    
    private var halfWidth: CGFloat {
        return bounds.width / 2
    }
    
    private var halfHeight: CGFloat {
        return bounds.height / 2
    }
    
    @IBInspectable var fillColor: UIColor = UIColor.green
    
    override func draw(_ rect: CGRect) {
        let path = UIBezierPath(ovalIn: rect)
        fillColor.setFill()
        path.fill()
        clipsToBounds = true
        
    }
}
