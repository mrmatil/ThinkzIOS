//
//  GrammarChecking.swift
//  Thinkz
//
//  Created by Mateusz Łukasiński on 09/03/2020.
//  Copyright © 2020 Mateusz Łukasiński. All rights reserved.
//

import Foundation
import Moya

enum GrammarChecking{
    
    static private let grammarBotApiKey = "KS9C5N3Y"
    
    case grammarbot(text:String)
}

extension GrammarChecking:TargetType{
    
    var baseURL: URL {
        switch self {
        case .grammarbot:
            return URL(string: "https://api.grammarbot.io/v2/check")!
        }
    }
    
    var path: String {
        return ""
    }
    
    var method: Moya.Method {
        switch self{
        case .grammarbot:
            return .post
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self{
        case .grammarbot(let text):
            let request = Task.requestParameters(
                parameters:
                [
                    "api_key":GrammarChecking.grammarBotApiKey,
                    "language":"en-US",
                    "text":text
                ],
                encoding: URLEncoding.queryString)
//            print(request)
            return request
        }
    }
    
    var headers: [String : String]? {
        switch self{
        case .grammarbot:
            return ["Content-Type":"application/json"]

        }
    }
    
    
}
