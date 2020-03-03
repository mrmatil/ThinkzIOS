//
//  MainViewController+CoreBluetooth.swift
//  Thinkz
//
//  Created by Mateusz Łukasiński on 03/03/2020.
//  Copyright © 2020 Mateusz Łukasiński. All rights reserved.
//

import Foundation
import CoreBluetooth

extension MainViewController:CBCentralManagerDelegate,CBPeripheralDelegate{
    
    //MARK: Functions
    
    func initializeBlueToothConnection(){
        manager = CBCentralManager(delegate: self, queue: nil)
    }

    
    //MARK: Delegate Functions
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        if central.state == .poweredOn {
            central.scanForPeripherals(withServices: nil, options: nil)
        } else {
          print(">>> BLUETOOTH NOT AVAILABLE")
        }
    }
    
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
        
        if peripheral.identifier == SmartPenConstants.SMARTPEN_UUID{
            self.manager.stopScan()
            self.peripheral = peripheral
            self.peripheral.delegate = self
            
            manager.connect(peripheral, options: nil)
            print(">>> SMARTPEN FOUND")
        }
    }
    
    func peripheral(_ peripheral: CBPeripheral, didUpdateValueFor characteristic: CBCharacteristic, error: Error?) {
        var data = characteristic.value
        print(data)
    }

    
}
