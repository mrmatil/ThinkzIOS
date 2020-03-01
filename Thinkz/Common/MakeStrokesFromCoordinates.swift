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

struct writingAreaDimensions{
    var width:Int
    var height:Int
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
    
    static func makeStrokesForGoogle(coordinates:Array<movement>,language:language, areaDimensions:writingAreaDimensions)->JSON{
        var languageID:String = ""
        switch language{
        case .english: languageID = "en"
        case .polish: languageID = "pl"
        }
        
        let dimensionsJSON:JSON =
        [
                "writing_area_height" : areaDimensions.height,
                "writing_area_width" : areaDimensions.width
        ]
        
        let (tempX,tempY,tempZ) = parseCoordinatesForGoogle(coordinates: coordinates)
        
        let strokesJSON:JSON =
        [
            "writing_guide": dimensionsJSON,
            "ink": [ [ tempX,tempY,tempZ ] ],
            "language": languageID
        ]

        
        let returnJSON:JSON =
        [
            "options": "enable_pre_space",
            "requests":[strokesJSON],
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
    
    private static func parseCoordinatesForGoogle(coordinates:Array<movement>)->([Float],[Float],[Float]){
        
        var returnX = Array<Float>()
        var returnY = Array<Float>()
        let returnZ = Array<Float>()
        
        coordinates.forEach { (move) in
            returnX.append(Float(move.end.x))
            returnY.append(Float(move.end.y))
        }
        
        return (returnX,returnY,returnZ)
    }
    
    
}
