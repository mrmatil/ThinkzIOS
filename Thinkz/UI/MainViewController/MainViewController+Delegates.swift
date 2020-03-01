//
//  MainViewController+Delegates.swift
//  Thinkz
//
//  Created by Mateusz Łukasiński on 01/03/2020.
//  Copyright © 2020 Mateusz Łukasiński. All rights reserved.
//

import Foundation

//MARK: Settings Protocol
extension MainViewController:MainSettingsProtocol{
    
    func apiChanged(value: PickedProvider) {
        print(">>> API PROVIDER CHANGED TO \(value)")
        self.pickedProvider = value
    }
    
    
}
