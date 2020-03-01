//
//  MainViewController.swift
//  Thinkz
//
//  Created by Mateusz Łukasiński on 25/02/2020.
//  Copyright © 2020 Mateusz Łukasiński. All rights reserved.
//

import UIKit

enum PickedProvider {
    case Azure
    case Google
}

//MARK: Variables & Main Functions
class MainViewController: UIViewController {
    
    internal var pickedProvider:PickedProvider!
    
    
    @IBOutlet weak var resultsTableView: UITableView!
    @IBOutlet weak var typeOfInputSegmentedControl: UISegmentedControl!
    @IBOutlet weak var drawingView: DrawingView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        apiChanged(value: .Azure)
        setupTableView()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == SegueysNames.MathToSettings{
            let destination = segue.destination as! MainSettingsViewController
            destination.delegate = self
            destination.setSettingsToCorrespondCurrendValues(currentProvider: pickedProvider)
        }
    }
}

//MARK: UI Actions
extension MainViewController{

    
    @IBAction func clearBtnTapped(_ sender: UIButton) {
        drawingView.deleteCurrentCoordinates()
    }

    @IBAction func SettingsButtonTapped(_ sender: UIButton) {
        performSegue(withIdentifier: SegueysNames.MathToSettings, sender: self)
    }
    

    @IBAction func typeOfInputSegmentedControlValueChanged(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex{
        case 0: drawingView.changeInputType = .SmartPen
        case 1: drawingView.changeInputType = .Touch
        default: return
        }
    }
    
    @IBAction func testBtnTapped(_ sender: UIButton) {
        MoyaResponse()
    }
    
}

//MARK: UITableView setup
extension MainViewController:UITableViewDelegate,UITableViewDataSource{
    
    func setupTableView(){
        resultsTableView.delegate = self
        resultsTableView.dataSource = self
        
        resultsTableView.separatorStyle = .singleLine
        resultsTableView.separatorColor = Colors.lightBlue
        
    }
    
    func setupTableViewCell(row:IndexPath)->UITableViewCell{
        let cell = UITableViewCell(style: .default, reuseIdentifier: "resultCell")
        cell.accessoryType = .none
        cell.textLabel?.text = "Thinkz"
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return setupTableViewCell(row: indexPath)
    }
    
    
    
}

