//
//  ViewController.swift
//  Thinkz
//
//  Created by Mateusz Łukasiński on 23/02/2020.
//  Copyright © 2020 Mateusz Łukasiński. All rights reserved.
//

import UIKit


class InitialViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    enum typeOfSeguey{
        case mathModule
        case testData
    }

    @IBAction func mathModuleTapped(_ sender: UIButton) {
        makeSeguey(type: .mathModule)
    }
    
    @IBAction func testDataTapped(_ sender: UIButton) {
        makeSeguey(type: .testData)
    }
    
    func makeSeguey(type:typeOfSeguey){
        switch type{
        case .mathModule:
            performSegue(withIdentifier: SegueysNames.initialToMath, sender: self)
        case .testData:
            performSegue(withIdentifier: SegueysNames.initialToTest, sender: self)
        }
    }
    
}

