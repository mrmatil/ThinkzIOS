//
//  DrawingView+Touch.swift
//  Thinkz
//
//  Created by Mateusz Łukasiński on 25/02/2020.
//  Copyright © 2020 Mateusz Łukasiński. All rights reserved.
//

import UIKit

extension DrawingView{
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if typeOfInput == .Touch{
            print(">>> USER TOUCHES STARTED BEING REGISTERED")
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if typeOfInput == .Touch{
            touches.forEach { (touch) in
                let x = Double(touch.previousLocation(in: self).x)
                let y = Double(touch.previousLocation(in: self).y)
                let endX = Double(touch.location(in: self).x)
                let endY = Double(touch.location(in: self).y)
                addNewCoordinatesWithBothValues(startX: x, startY: y, endX: endX, endY: endY)
            }
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if typeOfInput == .Touch{
            print(">>> USER TOUCHES STOPPED BEING REGISTERED")
        }
        
        
    }
}
