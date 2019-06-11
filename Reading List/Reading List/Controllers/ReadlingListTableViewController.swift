//
//  ReadlingListTableViewController.swift
//  Reading List
//
//  Created by Sean Acres on 6/11/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

class ReadlingListTableViewController: UITableViewController, BookTableViewCellDelegate {

    let bookController = BookController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return bookController.readBooks.count
        } else {
            return bookController.unreadBooks.count
        }
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "Read Books"
        } else {
            return "Unread Books"
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "BookCell", for: indexPath) as? BookTableViewCell else {
            return UITableViewCell()
        }

        cell.book = bookFor(indexPath: indexPath)
        cell.delegate = self
        return cell
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            bookController.deleteBook(book: bookFor(indexPath: indexPath))
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    func toggleHasBeenRead(for cell: BookTableViewCell) {
        guard let indexPath = tableView.indexPath(for: cell) else { return }
        
        bookController.updateHasBeenRead(for: bookFor(indexPath: indexPath))
        tableView.reloadRows(at: [indexPath], with: .fade)
    }

    func bookFor(indexPath: IndexPath) -> Book {
        if indexPath.section == 0 {
            return bookController.readBooks[indexPath.row]
        } else {
            return bookController.unreadBooks[indexPath.row]
        }
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "addBook" {
            guard let bookDetailVC = segue.destination as? BookDetailViewController else { return }
            bookDetailVC.bookController = bookController
        } else if segue.identifier == "showBook" {
            guard let bookDetailVC = segue.destination as? BookDetailViewController,
                let indexPath = tableView.indexPathForSelectedRow else { return }
            bookDetailVC.bookController = bookController
            bookDetailVC.book = bookFor(indexPath: indexPath)
        }
    }

}
