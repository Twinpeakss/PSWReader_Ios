//
//  SearchController.swift
//  PSWreader
//
//  Created by dima on 07.09.2020.
//  Copyright © 2020 dima. All rights reserved.
//

import UIKit

class SearchController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate, UITableViewDataSource, UITableViewDelegate, UITableViewDataSourcePrefetching{

    var books: [Book] = []
    
    @IBOutlet weak var showFiltersButton: UIButton!
    
    @IBOutlet weak var searchButton: UIButton!
    
    @IBOutlet weak var tfAvailability: UITextField!
    
    @IBOutlet weak var tfType: UITextField!
    
    @IBOutlet weak var tfLang: UITextField!
    
    @IBOutlet weak var searchItems: UIStackView!
    
    
    @IBOutlet weak var booksTableView: UITableView!
    
    var availabilityPickerView = UIPickerView()
    var typePickerView = UIPickerView()
    var langPickerView = UIPickerView()
    
    let availability = ["Dostępna", "Wypożyczona"]
    let bookType = ["Książka", "Publikacja fachowa", "Poradnik","Przewodnik", "Publikacja naukowa", "Publikacja dydaktyczna", "Czasopismo"]
    let languages = ["Polski", "Angielski", "Rosyjski"]
    override func viewDidLoad() {
        searchItems.isHidden = true
        super.viewDidLoad()
        
        showFiltersButton.layer.cornerRadius = 12
        showFiltersButton.layer.shadowRadius = 5
        showFiltersButton.layer.shadowOpacity = 0.5
        showFiltersButton.layer.shadowColor =   UIColor.orange.cgColor
        showFiltersButton.layer.shadowOffset = CGSize(width: 0, height: 0)
        searchButton.layer.cornerRadius = 12
        searchButton.layer.shadowRadius = 5
        searchButton.layer.shadowOpacity = 0.5
        searchButton.layer.shadowColor =   UIColor.orange.cgColor
        searchButton.layer.shadowOffset = CGSize(width: 0, height: 0)
        
        booksTableView.delegate = self
        booksTableView.dataSource = self
        booksTableView.prefetchDataSource = self
        availabilityPickerView.delegate = self
        availabilityPickerView.dataSource = self
        typePickerView.delegate = self
        typePickerView.dataSource = self
        langPickerView.delegate = self
        langPickerView.dataSource = self
        
        tfAvailability.inputView = availabilityPickerView
        tfType.inputView = typePickerView
        tfLang.inputView = langPickerView
        
        tfAvailability.placeholder = "wybierz dostępność"
        tfType.placeholder = "wybierz typ"
        tfLang.placeholder = "wybierz język książki"
        
        availabilityPickerView.tag = 1
        typePickerView.tag = 2
        langPickerView.tag = 3
        
        let url = "https://still-depths-12733.herokuapp.com/"
        URLSession.shared.dataTask(with: URL(string: url)!) {(data, response, error) in
            do {
                self.books = try JSONDecoder().decode([Book].self, from: data!)
            } catch { print(error) }
            DispatchQueue.main.async {
                self.booksTableView.reloadData()
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
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch pickerView.tag {
        case 1:
            return availability.count
        case 2:
            return bookType.count
        case 3:
            return languages.count
        default:
            return 1
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch pickerView.tag {
        case 1:
            return availability[row]
        case 2:
            return bookType[row]
        case 3:
            return languages[row]
        default:
            return "error"
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch pickerView.tag {
        case 1:
            tfAvailability.text = availability[row]
            tfAvailability.resignFirstResponder()
        case 2:
            tfType.text = bookType[row]
            tfType.resignFirstResponder()
        case 3:
            tfLang.text = languages[row]
            tfLang.resignFirstResponder()
        default:
            return
        }
    }
    
    @IBAction func userLoggedOut(_ sender: Any) {
        UserDefaults.standard.set(false, forKey: "isUserLoggedIn")
        performSegue(withIdentifier: "LoginViewSegue", sender: self)
    }
    

    @IBAction func showFilters(_ sender: Any) {
        if(searchItems.isHidden == true){
            searchItems.isHidden = false
        }
        else {
            searchItems.isHidden = true
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //UserDefaults.standard.removeObject(forKey: "isUserLoggedIn")
        
        let isLogin = UserDefaults.standard.bool(forKey: "isUserLoggedIn")
        if(isLogin != true)
        {
            performSegue(withIdentifier: "LoginViewSegue", sender: self)
        }
    }
}
struct Book: Decodable {
    let name: String
    let author: String
    let published: String
    let cover: String
    let desc: String
}

extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}

