//
//  CharactersTableViewCell.swift
//  MarvelApp
//
//  Created by Renan Trapp on 09/01/18.
//  Copyright © 2018 Renan Trapp. All rights reserved.
//

import UIKit

class CharactersTableViewCell: UITableViewCell {
    
    @IBOutlet weak var imageCharacter: UIImageView!
    @IBOutlet weak var name: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
