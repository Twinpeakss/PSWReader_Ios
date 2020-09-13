//
//  BorrowedBooksController.swift
//  PSWreader
//
//  Created by dima on 07.09.2020.
//  Copyright © 2020 dima. All rights reserved.
//

import UIKit

class BorrowedBooksController: UIViewController, UITableViewDataSource, UITableViewDelegate, UITableViewDataSourcePrefetching {

    var books: [Book] = []
    
    @IBOutlet weak var rentalsTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        rentalsTableView.delegate = self
        rentalsTableView.dataSource = self
        //booksTableView.prefetchDataSource = self
        let url = "https://still-depths-12733.herokuapp.com/"
        URLSession.shared.dataTask(with: URL(string: url)!) {(data, response, error) in
            do {
                self.books = try JSONDecoder().decode([Book].self, from: data!)
            } catch { print(error) }
            DispatchQueue.main.async {
                self.rentalsTableView.reloadData()
            }
            }.resume()
        
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return books.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewCell
        cell.coverImageView.load(url: URL(string: books[indexPath.row].cover)!)
        cell.nameLabel.text = books[indexPath.row].name
        cell.infoLabel.text = "\(books[indexPath.row].published), \(books[indexPath.row].author)"
        cell.descLabel.text = books[indexPath.row].desc
        return cell
    }
    
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
}
