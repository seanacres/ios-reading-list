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
    weak var delegate: BookTableViewCellDelegate?
    
    var book: Book? {
        didSet {
            updateViews()
        }
    }
    
    @IBAction func hasBeenReadButtonTapped(_ sender: Any) {
        self.delegate?.toggleHasBeenRead(for: self)
    }
    
    func updateViews() {
        guard let book = book else { return }
        bookTitle.text = book.title
        if book.hasBeenRead {
            hasBeenReadButton.isSelected = true
        } else {
            hasBeenReadButton.isSelected = false
        }
    }
}
