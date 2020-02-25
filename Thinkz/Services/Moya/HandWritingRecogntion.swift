//
//  HandWritingRecogntion.swift
//  Thinkz
//
//  Created by Mateusz Łukasiński on 26/02/2020.
//  Copyright © 2020 Mateusz Łukasiński. All rights reserved.
//

import Foundation
import Moya

enum HandWritingRecognition{
    
    static private let azureCognitiveKey = "1760afa8d0644d8683521c509332140f"
    
    case recognizeFromStrokes
}

extension HandWritingRecognition:TargetType{
    var baseURL: URL {
        switch self{
        case .recognizeFromStrokes: return URL(string: "https://thinkz.cognitiveservices.azure.com/")!
        }
    }
    
    var path: String {
        <#code#>
    }
    
    var method: Moya.Method {
        <#code#>
    }
    
    var sampleData: Data {
        <#code#>
    }
    
    var task: Task {
        <#code#>
    }
    
    var headers: [String : String]? {
        <#code#>
    }
    
    
}
