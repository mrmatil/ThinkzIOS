//
//  GrammarMistakesTableViewCell.swift
//  Thinkz
//
//  Created by Mateusz Łukasiński on 09/03/2020.
//  Copyright © 2020 Mateusz Łukasiński. All rights reserved.
//

import UIKit

class GrammarMistakesTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBOutlet weak var sentenceLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var replacementsLabel: UILabel!
    
    
}
