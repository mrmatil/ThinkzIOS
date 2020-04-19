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
    func grammarChanged(value:PickedGrammarRecignizer)
}

class MainSettingsViewController: UIViewController {
    
    var delegate:MainSettingsProtocol?
    var apiSelectedIndex:Int = 0
    var grammarSelectedIndex:Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        apiSegmentedControl.selectedSegmentIndex = apiSelectedIndex
        grammarSegmentedControl.selectedSegmentIndex = grammarSelectedIndex
    }
    
    func setSettingsToCorrespondCurrendValues(currentProvider:PickedProvider, currentGrammar:PickedGrammarRecignizer){
        
        switch currentProvider{
        case .Azure:  apiSelectedIndex = 0
        case .Google: apiSelectedIndex = 1
        }
        
        switch currentGrammar{
        case .grammarbot: grammarSelectedIndex = 1
        case .textGears: grammarSelectedIndex = 0
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
    
    @IBOutlet weak var grammarSegmentedControl: UISegmentedControl!
    
    @IBAction func grammarSegmentedControlChanged(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            delegate?.grammarChanged(value: .textGears)
        case 1:
            delegate?.grammarChanged(value: .grammarbot)
        default:
            return
        }
    }
    
    
}
