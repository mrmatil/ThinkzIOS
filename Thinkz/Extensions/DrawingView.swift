//
//  DrawingView.swift
//  Thinkz
//
//  Created by Mateusz Łukasiński on 25/02/2020.
//  Copyright © 2020 Mateusz Łukasiński. All rights reserved.
//

import UIKit

struct movement{
    
    var start:CGPoint
    var end:CGPoint
}

enum TypeOfInput{
    case SmartPen
    case ApplePencil
    case Touch
}

//MARK: Variables & Override stuff
class DrawingView:UIView{
    private var context:CGContext?
    private var color:CGColor = CGColor(srgbRed: 0.0, green: 0.0, blue: 0.0, alpha: 1)
    private var width:CGFloat = 1.0
    private var lastKnownPosition:CGPoint = CGPoint(x: 0, y: 0)
    internal var coordinates = Array<movement>()
    internal var typeOfInput:TypeOfInput = .SmartPen
    
    var lineColor:CGColor{
        get{
            return color
        }
        set{
            color = newValue
            print(">>> COLOR CHANGED TO: \(color)")
        }
    }
    
    var getCoordinates:[movement]{
        get{
            return coordinates
        }
    }
    
    var changeInputType:TypeOfInput{
        get{
            return typeOfInput
        }
        set{
            typeOfInput = newValue
            print(">>> INPUT TYPE CHANGED TO :\(typeOfInput)")
        }
    }
    

    override func draw(_ rect: CGRect) {
        super.draw(rect)
        drawImage()
    }
    
    
}

//MARK: Public Functions
extension DrawingView{
    
    func addNewCoordinates(x:Double,y:Double){
        let move = movement(start: lastKnownPosition,
                            end: CGPoint(x: x, y: y))
        coordinates.append(move)
        
        print(">>> ADDED NEW COORDINATES BY \(typeOfInput),\n LINE: x: \(lastKnownPosition.x)\t y: \(lastKnownPosition.y) =>\n LINE: x: \(x)\t y: \(y)")
        
        lastKnownPosition = CGPoint(x: x,
                                    y: y)
        setNeedsDisplay()
    }
    
    func addNewCoordinatesWithBothValues(startX:Double,startY:Double,endX:Double,endY:Double){
        let move = movement(start: CGPoint(x: startX, y: startY),
                            end: CGPoint(x: endX, y: endY))
        coordinates.append(move)
        
        print(">>> ADDED NEW COORDINATES BY \(typeOfInput),\n LINE: x: \(startX)\t y: \(startY) =>\n LINE: x: \(endX)\t y: \(endY)")
        
        setNeedsDisplay()
    }
    
    func deleteCurrentCoordinates(){
        lastKnownPosition = CGPoint(x: 0, y: 0)
        coordinates = Array<movement>()
        setNeedsDisplay()
        print(">>> CLEARED CURRENT COORDINATES")
    }
    
    func changeSmartPenValuesToAppValues(x:Double,y:Double, viewWidth:Double, viewHeight:Double)->(Double,Double){
        
        let heightMultiply = viewHeight / Double(SmartPenConstants.maxHeight)
        let widthMultiply = viewWidth / Double(SmartPenConstants.maxWidth)
        
        let newX = x * widthMultiply
        let newY = y * heightMultiply

        return (newX,newY)
    }

}

//MARK: Private Functions
private extension DrawingView{
    
    func drawLine(in context:CGContext, pointA:CGPoint, pointB:CGPoint, color: CGColor, width:CGFloat){
        
        context.setLineWidth(width)
        context.setStrokeColor(color)
        context.beginPath()
        context.move(to: pointA)
        context.addLine(to: pointB)
        context.strokePath()
        
    }
    
    func drawImage(){
        var isInitialMove = true
    
        coordinates.forEach { (move) in

            if !isInitialMove{
                context = UIGraphicsGetCurrentContext()
                drawLine(in: context!,
                         pointA: move.start,
                         pointB: move.end,
                         color: color,
                         width: width)
                UIGraphicsEndImageContext()
            } else{
                isInitialMove = false
            }
        }
        
    }
    
}
