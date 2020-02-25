//
//  ResultsResponseApiModel.swift
//  Thinkz
//
//  Created by Mateusz Łukasiński on 26/02/2020.
//  Copyright © 2020 Mateusz Łukasiński. All rights reserved.
//

import Foundation

enum ResultsResponseType{
    case correct
    case warning
    case mistake
}

struct ResultsResponseApiModel {
    
    var typeOfResponse:ResultsResponseType
    var responseHeader:String?
    var responseBody:String?
    
}
