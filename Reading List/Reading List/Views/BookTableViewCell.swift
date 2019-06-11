//
//  BookTableViewCell.swift
//  Reading List
//
//  Created by Sean Acres on 6/11/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

class BookTableViewCell: UITableViewCell {

    @IBOutlet var bookTitle: UILabel!
    @IBOutlet var hasBeenReadButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func hasBeenReadButtonTapped(_ sender: Any) {
    }
    
}
