//
//  Dice.swift
//  DiceDrawing
//
//  Created by hunkar lule on 2018-11-05.
//  Copyright © 2018 hunkar lule. All rights reserved.
//

import UIKit

@IBDesignable class DiceView: UIView {
    
    private var diceSize: CGFloat {
        return min(bounds.size.width, bounds.size.height)
    }
    
    private var diceUpperLeftCorner: CGPoint {
        return CGPoint(x: bounds.midX - diceSize / 2, y: bounds.midY - diceSize / 2)
    }
    
    var pimpRadius: CGFloat {
        return diceSize / CGFloat(pimpScale)
    }
    
    
    var pimpOffset: CGFloat {
        return diceSize  / CGFloat(pimpScale)
    }
    
    @IBInspectable
    var pimpScale: Double = 10.0
    
    @IBInspectable
    var faceValue:Int = 1 {
        didSet {
            
            setNeedsLayout()
            setNeedsDisplay()
        }
    }
    
    @IBInspectable
    var pimpColor: UIColor = UIColor.black
    
    @IBInspectable
    var diceColor: UIColor = UIColor.red
    
    
    var pimps: [Int: CGPoint]  {
        return [
            1: CGPoint(x: bounds.midX - diceSize / 2 + pimpOffset + pimpRadius, y: bounds.midY - diceSize / 2 + pimpOffset + pimpRadius),
            2: CGPoint(x: bounds.midX + diceSize / 2 - (pimpOffset + pimpRadius), y: bounds.midY - diceSize / 2 + pimpOffset + pimpRadius),
            3: CGPoint(x: bounds.midX - diceSize / 2 + pimpOffset + pimpRadius, y: bounds.midY),
            4: CGPoint(x: bounds.midX, y: bounds.midY),
            5: CGPoint(x: bounds.midX + diceSize / 2 - (pimpOffset + pimpRadius), y: bounds.midY),
            6: CGPoint(x: bounds.midX - diceSize / 2 + pimpOffset + pimpRadius, y: bounds.midY + diceSize / 2 - (pimpOffset + pimpRadius)),
            7: CGPoint(x: bounds.midX + diceSize / 2 - (pimpOffset + pimpRadius), y: bounds.midY + diceSize / 2 - (pimpOffset + pimpRadius)),
        ]
    }
    func givePimps(faceValue: Int) -> [CGPoint] {
        switch faceValue {
        case 1: return [pimps[4]!]
        case 2: return [pimps[1]!, pimps[7]!]
        case 3: return [pimps[1]!, pimps[4]!, pimps[7]!]
        case 4: return [pimps[1]!, pimps[2]!, pimps[6]!, pimps[7]!]
        case 5: return[pimps[1]!, pimps[2]!, pimps[4]!, pimps[6]!, pimps[7]!]
        case 6: return[pimps[1]!, pimps[2]!, pimps[3]!, pimps[5]!, pimps[6]!, pimps[7]!]
        default: return[]
        }
    }
    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        drawDiceRectangle()
        drawPimps(faceValue: faceValue)
    }
    
    func drawDiceRectangle() {
        let path1 = UIBezierPath(roundedRect: CGRect(x: diceUpperLeftCorner.x , y: diceUpperLeftCorner.y, width: diceSize, height: diceSize), cornerRadius: 5.0)
        //        let path = UIBezierPath(rect: CGRect(x: diceUpperLeftCorner.x , y: diceUpperLeftCorner.y, width: diceSize, height: diceSize))
        diceColor.setFill()
        path1.fill()
    }
    
    func drawPimps(faceValue: Int) {
        let pimps = givePimps(faceValue: faceValue)
        for pimp in pimps {
            let path = UIBezierPath(
                arcCenter: pimp,
                radius: pimpRadius,
                startAngle: 0,
                endAngle: 2 * CGFloat.pi,
                clockwise: true
            )
            
            pimpColor.setFill()
            path.fill()
        }
    }
    
}

