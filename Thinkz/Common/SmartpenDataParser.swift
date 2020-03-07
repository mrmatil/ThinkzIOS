//
//  SmartpenDataParser.swift
//  Thinkz
//
//  Created by Mateusz Łukasiński on 04/03/2020.
//  Copyright © 2020 Mateusz Łukasiński. All rights reserved.
//

import Foundation

class SmartpenDataParser{
    
    public static func getDataFromStringData(data:String)->(x:Double,y:Double,isWriting:Bool){
        
        /*
         sample response:
         X:595/Z:495/I:n//
         
         where:
         X => x
         Z => y
         I => n - 'not writing' or i - 'is writing'
         */
        
        var x:Double = 0.0
        var y:Double = 0.0
        var isWriting = false
        
        var tempDataArray = data.split(separator: "/")
        
        if tempDataArray.count != 4 {
            return (0.0,0.0,false)
        }
        
        //Droping last value => last value is always an empty string
        tempDataArray = tempDataArray.dropLast()
        
        if tempDataArray[0].contains("X:"){
            var temp = String(tempDataArray[0])
            temp.removeFirst(2)
            x = Double(temp) ?? 0
        }
        
        if tempDataArray[1].contains("Z:"){
            var temp = String(tempDataArray[1])
            temp.removeFirst(2)
            y = Double(temp) ?? 0
        }
        
        if tempDataArray[2].contains("I:"){
            var temp = String(tempDataArray[2])
            temp.removeFirst(2)
            isWriting = temp.bool ?? false
        }
        
        return (x,y,isWriting)
    }
    
}
