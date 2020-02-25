//
//  TestDataViewController+CBCentralManagerDelegate.swift
//  Thinkz
//
//  Created by Mateusz Łukasiński on 24/02/2020.
//  Copyright © 2020 Mateusz Łukasiński. All rights reserved.
//

import Foundation
import CoreBluetooth


extension TestDataViewController: CBCentralManagerDelegate{
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        centralManager = CBCentralManager(delegate: self, queue: nil)
    }
    
        
    //MARK: Bluetooth functions
    
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        switch central.state{
        case .unknown:
            print("State changed to: unknown")
        case .resetting:
            print("State changed to: resetting")
        case .unsupported:
            print("State changed to: unsupported")
        case .unauthorized:
            print("State changed to: unauthorized")
        case .poweredOff:
            print("State changed to: poweredOff")
        case .poweredOn:
            print("State changed to: poweredOn")
            centralManager.scanForPeripherals(withServices: nil, options: nil)
        @unknown default:
            print("State changed to: default")
        }
    }
    
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
        print(peripheral)
    }
    
    
    
    
}
