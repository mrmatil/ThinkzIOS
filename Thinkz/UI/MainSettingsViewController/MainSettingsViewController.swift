//
//  MainSettingsViewController.swift
//  Thinkz
//
//  Created by Mateusz Łukasiński on 01/03/2020.
//  Copyright © 2020 Mateusz Łukasiński. All rights reserved.
//

import UIKit

protocol MainSettingsProtocol {
    func apiChanged(value:PickedProvider)
}

class MainSettingsViewController: UIViewController {
    
    var delegate:MainSettingsProtocol?
    var apiSelectedIndex:Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        apiSegmentedControl.selectedSegmentIndex = apiSelectedIndex
    }
    
    func setSettingsToCorrespondCurrendValues(currentProvider:PickedProvider){
        
        switch currentProvider{
        case .Azure:  apiSelectedIndex = 0
        case .Google: apiSelectedIndex = 1
        }
        
    }
    
    @IBOutlet weak var apiSegmentedControl: UISegmentedControl!
    
    @IBAction func apiSegmentedControlChanged(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            delegate?.apiChanged(value: .Azure)
        case 1:
            delegate?.apiChanged(value: .Google)
        default:
            return
        }
    }
    
}
