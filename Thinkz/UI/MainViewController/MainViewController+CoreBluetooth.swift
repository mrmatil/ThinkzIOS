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
    
    //MARK: - Functions
    
    func initializeBlueToothConnection(){
        manager = CBCentralManager(delegate: self, queue: nil)
    }
    
    func sendDataToDrawingView(unParsedData:String){
        let (x,y,isWriting) = SmartpenDataParser.getDataFromStringData(data: unParsedData)
        if isWriting && drawingView.changeInputType == .SmartPen{
            let (a,b) = drawingView.changeCoordinatesForSmartpen(x: x, y: y)
            drawingView.addNewCoordinates(x: a, y: b)
        } else{
            drawingView.stoppedWriting()
            MoyaResponse()
        }
    }

    
    //MARK: - Delegate Functions
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        if central.state == .poweredOn {
            central.scanForPeripherals(withServices: [SmartPenConstants.SMARTPEN_CBUUID], options: nil)
        } else {
          print(">>> BLUETOOTH NOT AVAILABLE")
        }
    }
    
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {

        print(peripheral.identifier)
        self.manager.stopScan()
        self.peripheral = peripheral
        self.peripheral.delegate = self

        manager.connect(peripheral, options: nil)
        print(">>> SMARTPEN FOUND")
        
    }
    
    func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
        peripheral.delegate = self
        peripheral.discoverServices([SmartPenConstants.SMARTPEN_CBUUID])
    }
    
    func peripheral(_ peripheral: CBPeripheral, didDiscoverServices error: Error?) {
        for service in peripheral.services! {
            peripheral.discoverCharacteristics([SmartPenConstants.SMARTPEN_CHARACTERISTIC_CBUUID], for: service)
        }
    }
    
    func peripheral(_ peripheral: CBPeripheral, didDiscoverCharacteristicsFor service: CBService, error: Error?) {
       for characteristic in service.characteristics! {
            peripheral.setNotifyValue(true, for: characteristic)
        }
    }
    
    
    func peripheral(_ peripheral: CBPeripheral, didUpdateValueFor characteristic: CBCharacteristic, error: Error?) {
        
        let data = characteristic.value
        
        if let str = String(data: data!, encoding: .ascii) {
            let strArray = str.components(separatedBy: "\r\n")
            
            if tempCoordinatesBluetooth == "" {
                tempCoordinatesBluetooth = strArray[1]
            }
            else {
                var x = tempCoordinatesBluetooth + strArray[0]
                tempCoordinatesBluetooth = strArray[1]
                
                if x.contains("\r"){
                    x = x.components(separatedBy: "\r")[0]
                }
                
//                print(x)
                sendDataToDrawingView(unParsedData: x)
            }
        } else {
            //print("Received an invalid string!") uncomment for debugging
        }
        
        
//        print(dataInString)
//        sendDataToDrawingView(unParsedData: dataInString)
    }

    
    
}
