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
    static private let paramsForInkRecoginzer:[String:String] =
        [
        "Content-Type":"application/json",
        "Ocp-Apim-Subscription-Key":HandWritingRecognition.azureCognitiveKey
        ]
    
    case recognizeFromStrokes(language:language,coordinates:Array<movement>)
}

extension HandWritingRecognition:TargetType{
    var baseURL: URL {
        switch self{
        case .recognizeFromStrokes: return URL(string: "https://thinkz.cognitiveservices.azure.com/")!
        }
    }
    
    var path: String {
        switch self{
        case .recognizeFromStrokes: return "/inkrecognizer/v1.0-preview/recognize"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .recognizeFromStrokes: return .put
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self{
        case .recognizeFromStrokes(let language, let coordinates):
            let request = Task.requestJSONEncodable(MakeStrokesFromCoordinates.makeStrokesForAzure(coordinates: coordinates, language: language))
            return request
        }
    }
    
    var headers: [String : String]? {
        switch self{
        case .recognizeFromStrokes:
            return HandWritingRecognition.paramsForInkRecoginzer
        }
    }
    
    
}
