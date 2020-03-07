//
//  StringExtension.swift
//  Thinkz
//
//  Created by Mateusz Łukasiński on 04/03/2020.
//  Copyright © 2020 Mateusz Łukasiński. All rights reserved.
//

import Foundation

extension String {
    
    var bool: Bool? {
        switch self.lowercased() {
        case "i" :
            return true
        case "n" :
            return false
        default:
            return nil
        }
    }
    
}
