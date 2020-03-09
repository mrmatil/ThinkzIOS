//
//  GrammarMistakesViewController.swift
//  Thinkz
//
//  Created by Mateusz Łukasiński on 09/03/2020.
//  Copyright © 2020 Mateusz Łukasiński. All rights reserved.
//

import UIKit

class GrammarMistakesViewController: UIViewController {
    
    //Variables
    public var warnings:[GrammarResponseWarnings]!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var mistakesTableView: UITableView!
    
    
    @IBAction func exitBtnTapped(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        setTitleLabel()
        initializeTableView()
        // Do any additional setup after loading the view.
    }
    
    func setTitleLabel(){
        titleLabel.text = "You've made \(warnings.count) mistakes"
    }

}
extension GrammarMistakesViewController :UITableViewDelegate,UITableViewDataSource{
    
    func initializeTableView(){
        mistakesTableView.delegate = self
        mistakesTableView.dataSource = self
        mistakesTableView.separatorColor = Colors.lightBlue
        mistakesTableView.register(UINib(nibName: "GrammarMistakesTableViewCell", bundle: nil), forCellReuseIdentifier: "GrammarMistakesTableViewCell")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return warnings.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GrammarMistakesTableViewCell", for: indexPath) as! GrammarMistakesTableViewCell
        cell.messageLabel.text = warnings[indexPath.row].message
        cell.sentenceLabel.text = warnings[indexPath.row].sentence
        
        var replacements:String = ""
        
        if warnings[indexPath.row].replacements.count > 5{
            
            for x in 0...5{
                replacements.append(warnings[indexPath.row].replacements[x])
                replacements.append(" ")
            }
            
        } else {
            for x in warnings[indexPath.row].replacements {
                replacements.append(x)
                replacements.append(" ")
            }
        }
        
        if replacements.count>=1{
            replacements = String(replacements.dropLast())
        }
        
        cell.replacementsLabel.text = replacements
        
        return cell
    }
    
    
}
