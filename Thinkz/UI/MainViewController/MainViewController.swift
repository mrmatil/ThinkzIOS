//
//  MainViewController.swift
//  Thinkz
//
//  Created by Mateusz Łukasiński on 25/02/2020.
//  Copyright © 2020 Mateusz Łukasiński. All rights reserved.
//

import UIKit
import CoreBluetooth

enum PickedProvider {
    case Azure
    case Google
}

enum PickedGrammarRecignizer {
    case textGears
    case grammarbot
}

struct Results {
    var stringResult:String
    var warings:[GrammarResponseWarnings]?
}

//MARK: Variables & Main Functions
class MainViewController: UIViewController {
    
    internal var pickedProvider:PickedProvider!
    internal var pickedGrammarRecignizer:PickedGrammarRecignizer = .textGears
    internal var results:[Results] = [Results(stringResult: "", warings: nil)]
    
    internal var manager:CBCentralManager!
    internal var peripheral:CBPeripheral!
    internal var tempCoordinatesBluetooth:String = ""
    
    @IBOutlet weak var temporaryResultTextField: UITextField!
    @IBOutlet weak var resultsTableView: UITableView!
    @IBOutlet weak var typeOfInputSegmentedControl: UISegmentedControl!
    @IBOutlet weak var drawingView: DrawingView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        drawingView.delegate = self
        apiChanged(value: .Google)
        grammarChanged(value: .grammarbot)
        changeTemporaryResultTextFieldText(text: "")
        setupTableView()
        initializeBlueToothConnection()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == SegueysNames.MathToSettings{
            let destination = segue.destination as! MainSettingsViewController
            destination.delegate = self
            destination.setSettingsToCorrespondCurrendValues(currentProvider: pickedProvider, currentGrammar: pickedGrammarRecignizer)
        }
    }
}

//MARK: UI Actions
extension MainViewController{

    
    @IBAction func clearBtnTapped(_ sender: UIButton) {
        drawingView.deleteCurrentCoordinates()
        changeTemporaryResultTextFieldText(text: "")
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
    
    @IBAction func newLineBtnTapped(_ sender: UIButton) {
        MoyaGrammarCheck(text: results[results.count-1].stringResult, numberOfRow: results.count-1)
        results.append(Results(stringResult: "", warings: nil))
        drawingView.deleteCurrentCoordinates()
        changeTemporaryResultTextFieldText(text: "")
        resultsTableView.reloadData()
        print(">>> NEW LINE BUTTON TAPPED")
    }
    
    @IBAction func nextBtnTapped(_ sender: UIButton) {
        results[results.count-1].stringResult += " \(temporaryResultTextField.text ?? "")"
        drawingView.deleteCurrentCoordinates()
        changeTemporaryResultTextFieldText(text: "")
        resultsTableView.reloadData()
    }

    func changeTemporaryResultTextFieldText(text:String){
        temporaryResultTextField.text = text
        temporaryResultTextField.placeholder = "Results"
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
    
    func setupTableViewCell(indexPath:IndexPath)->UITableViewCell{
        let cell = UITableViewCell(style: .default, reuseIdentifier: "resultCell")
        cell.accessoryType = .none
        cell.textLabel?.text = results[indexPath.row].stringResult
        if results[indexPath.row].warings != nil {
            cell.accessoryType = .detailDisclosureButton
            print(results[indexPath.row])
        }
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return results.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return setupTableViewCell(indexPath: indexPath)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if results[indexPath.row].warings != nil {
            
            let resultsVC = GrammarMistakesViewController()
            resultsVC.modalPresentationStyle = .formSheet
            resultsVC.warnings = results[indexPath.row].warings!
            self.present(resultsVC, animated: true, completion: nil)
        }

        resultsTableView.deselectRow(at: indexPath, animated: false)
    }
    
    
}

