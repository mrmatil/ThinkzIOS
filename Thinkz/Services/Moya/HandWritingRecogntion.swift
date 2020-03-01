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
    static private let paramsForGoogle:[String:String] =
    [
        "Content-Type":"application/json",
        "User-Agent":"PostmanRuntime/7.22.0"
    ]
    
    case recognizeFromStrokesAzure(language:language,coordinates:Array<movement>)
    case recognizeFromStrokesGoogle(language:language, coordinates:Array<movement>, area:writingAreaDimensions)
    
}

extension HandWritingRecognition:TargetType{
    var baseURL: URL {
        switch self{
        case .recognizeFromStrokesAzure: return URL(string: "https://thinkz.cognitiveservices.azure.com/")!
        case .recognizeFromStrokesGoogle: return URL(string: "https://www.google.com/inputtools/request?ime=handwriting")!
        }
    }
    
    var path: String {
        switch self{
        case .recognizeFromStrokesAzure: return "/inkrecognizer/v1.0-preview/recognize"
        case .recognizeFromStrokesGoogle: return ""

        }
    }
    
    var method: Moya.Method {
        switch self {
        case .recognizeFromStrokesAzure: return .put
        case .recognizeFromStrokesGoogle: return .post
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self{
        case .recognizeFromStrokesAzure(let language, let coordinates):
            let request = Task.requestJSONEncodable(MakeStrokesFromCoordinates.makeStrokesForAzure(coordinates: coordinates,
                                                                                                   language: language))
            return request
        case .recognizeFromStrokesGoogle(let language, let coordinates, let area):
            let request = Task.requestJSONEncodable(MakeStrokesFromCoordinates.makeStrokesForGoogle(coordinates: coordinates,
                                                                                                    language: language,
                                                                                                    areaDimensions: area))
//            print(request)
            return request
        }
    }
    
    var headers: [String : String]? {
        switch self{
        case .recognizeFromStrokesAzure:
            return HandWritingRecognition.paramsForInkRecoginzer
        case .recognizeFromStrokesGoogle:
            return HandWritingRecognition.paramsForGoogle
        }
    }
    
    
}
