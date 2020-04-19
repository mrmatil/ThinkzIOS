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
    static private let textGearsApiKey = "RH3epqpmEkzW7E0w"
    
    case grammarbot(text:String)
    case textGears(text:String)
}

extension GrammarChecking:TargetType{
    
    var baseURL: URL {
        switch self {
        case .grammarbot:
            return URL(string: "https://api.grammarbot.io/v2/check")!
        case .textGears:
            return URL(string: "https://api.textgears.com/check.php")!
        }
    }
    
    var path: String {
        return ""
    }
    
    var method: Moya.Method {
        switch self{
        case .grammarbot:
            return .post
        case .textGears:
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
        
        case .textGears(let text):
            let request = Task.requestParameters(
                parameters:
                [
                    "key":GrammarChecking.textGearsApiKey,
                    "text":text
                ],
                encoding: URLEncoding.queryString)
            //         print(request)
            return request
        }
    }
    
    var headers: [String : String]? {
        switch self{
        case .grammarbot:
            return ["Content-Type":"application/json"]
        case .textGears:
            return ["Content-Type":"application/json"]
        }
    }
    
    
}
