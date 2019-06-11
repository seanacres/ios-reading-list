//
//  BookDetailViewController.swift
//  Reading List
//
//  Created by Sean Acres on 6/11/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

class BookDetailViewController: UIViewController {

    @IBOutlet var bookTitleTextField: UITextField!
    @IBOutlet var reasonToReadTextView: UITextView!
    
    var bookController: BookController?
    var book: Book?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateViews()
    }
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        guard let bookController = bookController,
            let title = bookTitleTextField.text else { return }
        if book == nil {
            bookController.createBook(title: title, reasonToRead: reasonToReadTextView.text)
        } else if book != nil {
            bookController.updateBookDetails(for: book!, newTitle: title, newReasonToRead: reasonToReadTextView.text)
        }
    }
    
    func updateViews() {
        guard let book = book else { return }
        bookTitleTextField.text = book.title
        reasonToReadTextView.text = book.reasonToRead
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
