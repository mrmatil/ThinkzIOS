//
//  SmartPenConstants .swift
//  Thinkz
//
//  Created by Mateusz Łukasiński on 25/02/2020.
//  Copyright © 2020 Mateusz Łukasiński. All rights reserved.
//

import UIKit
import CoreBluetooth

class SmartPenConstants{
    
    static let maxWidth:CGFloat  = 860.0
    static let maxHeight:CGFloat = 860.0
    
    static let SMARTPEN_NAME = "Smartpen by Thinkz"
    static let SMARTPEN_UUID =
      UUID(uuidString: "00002A05-0000-1000-8000-00805F9B34FB")
    
    static let SMARTPEN_CBUUID = CBUUID(string: "FFE0")
    static let SMARTPEN_CHARACTERISTIC_CBUUID = CBUUID(string: "FFE1")
}
