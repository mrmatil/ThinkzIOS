//
//  MainViewController.swift
//  Thinkz
//
//  Created by Mateusz Łukasiński on 25/02/2020.
//  Copyright © 2020 Mateusz Łukasiński. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    @IBOutlet weak var resultsTableView: UITableView!
    @IBOutlet weak var typeOfInputSegmentedControl: UISegmentedControl!
    @IBOutlet weak var drawingView: DrawingView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    var temp:Double = 10
    @IBAction func testBtnTapped(_ sender: UIButton) {
        let width = Double(drawingView.frame.width)
        let height = Double(drawingView.frame.height)
        
        let (x,y) = drawingView.changeSmartPenValuesToAppValues(x: temp, y: temp+3, viewWidth: width, viewHeight: height)
        
        drawingView.addNewCoordinates(x: x,
                                      y: y)
        temp+=5
    }
    

}
