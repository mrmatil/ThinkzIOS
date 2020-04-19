//
//  GrammarResponse.swift
//  Thinkz
//
//  Created by Mateusz Łukasiński on 09/03/2020.
//  Copyright © 2020 Mateusz Łukasiński. All rights reserved.
//

import UIKit
import SwiftyJSON

struct GrammarResponseWarnings {
    var sentence:String
    var message:String
    var replacements:[String]
}

class GrammarResponse{
    
    private var jsonData:Data
    
    init(jsonData:Data) {
        self.jsonData = jsonData
    }
    
    func getWarnings() -> [GrammarResponseWarnings]?{
        var warnings:[GrammarResponseWarnings] = [GrammarResponseWarnings]()
        
        do {
            let json = try JSON.init(data: jsonData)
            let matches = json["matches"]
            if matches.count > 0 {
                
                for match in matches{
                    let oneMatchJson = match.1
                    let sentence = oneMatchJson["sentence"].string
                    let message = oneMatchJson["message"].string
                    var repl = Array<String>()
                    
                    for replacements in oneMatchJson["replacements"] {
                        repl.append(replacements.1["value"].string ?? "")
                    }
                    
                    warnings.append(GrammarResponseWarnings.init(sentence: sentence ?? "",
                                                                  message: message ?? "",
                                                                  replacements: repl))
                }
                
            } else {return nil}
            
        }
         catch {
            print(error.localizedDescription)
            return nil
        }
        
        return warnings
    }
    
    func getWarningsForTextGears(text:String) -> [GrammarResponseWarnings]?{
        var warnings:[GrammarResponseWarnings] = [GrammarResponseWarnings]()

        do{
            let json = try JSON.init(data: jsonData)
            let errors = json["errors"]
            
            if errors.count > 0 {
                
                for error in errors{
                    let oneErrorJson = error.1
                    let sentence = String(text.dropFirst())
                    let message = oneErrorJson["type"].string
                    var repl = Array<String>()
                    
                    for replacements in oneErrorJson["better"]{
                        repl.append(replacements.1.string ?? "")
                    }
                    
                    warnings.append(GrammarResponseWarnings.init(sentence: sentence,
                                                                 message: message ?? "",
                                                                 replacements: repl))
                }
                
            }else{
                return nil
            }
            
        }
        catch{
            print(error.localizedDescription)
            return nil
        }
    
        return warnings
    }
    
}
