//
//  TestDataViewController.swift
//  Thinkz
//
//  Created by Mateusz Łukasiński on 24/02/2020.
//  Copyright © 2020 Mateusz Łukasiński. All rights reserved.
//

import UIKit
import CoreBluetooth


class TestDataViewController: UIViewController {
    
    
    //MARK: Outlets
    
    @IBOutlet weak var testDataTextView: UITextView!
    
    //MARK: Variables
    
    var centralManager:CBCentralManager!

    
}
