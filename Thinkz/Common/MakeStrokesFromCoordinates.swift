//
//  MakeStrokesFromCoordinates.swift
//  Thinkz
//
//  Created by Mateusz Łukasiński on 26/02/2020.
//  Copyright © 2020 Mateusz Łukasiński. All rights reserved.
//

import Foundation
import SwiftyJSON

enum language{
    case english
    case polish
}

class MakeStrokesFromCoordinates{
    
    static func makeStrokesForAzure(coordinates:Array<movement>,language:language)->JSON{
        var languageID:String = ""
        switch language{
        case .english: languageID = "en-US"
        case .polish: languageID = "pl-PL"
        }
        
        let strokesJSON: JSON =
        [
            "id":183,
            "points":parseCoordinates(coordinates: coordinates),
            "language": languageID
        ]
        
        let returnJSON: JSON =
        [
            "version":1,
            "language": languageID,
            "unit":"mm",
            "strokes": [strokesJSON]
            
        ]
        
        return returnJSON
    }
    
    private static func parseCoordinates(coordinates:Array<movement>)->String{
        
        var returnCoordinates:String = ""
        
        coordinates.forEach { (move) in
            let temp = "\(move.end.x),\(move.end.y),"
            returnCoordinates.append(temp)
        }
        
        _=returnCoordinates.popLast()
        
        return returnCoordinates
    }
    
    
}
