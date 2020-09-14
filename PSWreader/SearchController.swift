import UIKit

class SearchController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate, UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate{

    var user: User!
    var books: [Book] = []
    
    @IBOutlet weak var showFiltersButton: UIButton!
    @IBOutlet weak var searchButton: UIButton!
    
    
    @IBOutlet weak var titleSearchBar: UISearchBar!
    @IBOutlet weak var authorTextField: UITextField!
    @IBOutlet weak var dateFromTextField: UITextField!
    @IBOutlet weak var dateToTextField: UITextField!
    @IBOutlet weak var availabilityTextField: UITextField!
    @IBOutlet weak var typeTextField: UITextField!
    @IBOutlet weak var languageTextField: UITextField!
    
    @IBOutlet weak var filtersStackView: UIStackView!
    
    @IBOutlet weak var booksTableView: UITableView!
    
    var availabilityPickerView = UIPickerView()
    var typePickerView = UIPickerView()
    var langPickerView = UIPickerView()
    
    let availability = ["","Dostępna", "Wypożyczona"]
    let bookType = ["","Książka", "Publikacja fachowa", "Poradnik","Przewodnik", "Publikacja naukowa", "Publikacja dydaktyczna", "Czasopismo"]
    let languages = ["","Polski", "Angielski", "Rosyjski"]
    var bookAvailability = ["Dostępna": "1",
                     "Wypożyczona": "0"]
    override func viewDidLoad() {
        filtersStackView.isHidden = true
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
        //booksTableView.prefetchDataSource = self
        availabilityPickerView.delegate = self
        availabilityPickerView.dataSource = self
        typePickerView.delegate = self
        typePickerView.dataSource = self
        langPickerView.delegate = self
        langPickerView.dataSource = self
        dateToTextField.delegate = self
        dateFromTextField.delegate = self
        
        availabilityTextField.inputView = availabilityPickerView
        typeTextField.inputView = typePickerView
        languageTextField.inputView = langPickerView
        
        availabilityTextField.placeholder = "wybierz dostępność"
        typeTextField.placeholder = "wybierz typ"
        languageTextField.placeholder = "wybierz język książki"
        
        availabilityPickerView.tag = 1
        typePickerView.tag = 2
        langPickerView.tag = 3
        
        let url = "https://fast-lowlands-95120.herokuapp.com/api/books"
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
            availabilityTextField.text = availability[row]
            availabilityTextField.resignFirstResponder()
        case 2:
            typeTextField.text = bookType[row]
            typeTextField.resignFirstResponder()
        case 3:
            languageTextField.text = languages[row]
            languageTextField.resignFirstResponder()
        default:
            return
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let allowedCharacters = "1234567890"
        let allowedCharacterSet = CharacterSet(charactersIn: allowedCharacters)
        let typedCharacterSet = CharacterSet(charactersIn: string)
        return allowedCharacterSet.isSuperset(of: typedCharacterSet)
    }
    
    @IBAction func userLoggedOut(_ sender: Any) {
        UserDefaults.standard.set(false, forKey: "isUserLoggedIn")
        let url = URL(string: "https://fast-lowlands-95120.herokuapp.com/api/logout")
        guard let requestUrl = url else { fatalError() }
        var request = URLRequest(url: requestUrl)
        request.httpMethod = "GET"
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if error != nil {
                print("Error took place (error)")
                return
            }
            if (response as? HTTPURLResponse) != nil {
                print("Response HTTP Status code: (response.statusCode)")
            }
            if let data = data, let _ = String(data: data, encoding: .utf8) {
                print("Response data string:\n (dataString)")
            }
        }
        task.resume()
        performSegue(withIdentifier: "LoginViewSegue", sender: self)
    }
    
    @IBAction func searchBooks(_ sender: Any) {
        var title : String = ""
        var author : String = ""
        var dateFrom : String = ""
        var dateTo : String = ""
        var availability : String = ""
        var type : String = ""
        var language : String = ""
        
        if(titleSearchBar.text?.isEmpty == false){
            title = titleSearchBar.text!
        }
        
        if(authorTextField.text?.isEmpty == false){
            author = authorTextField.text!
        }
        if(dateFromTextField.text?.isEmpty == false){
            dateFrom = dateFromTextField.text!
        }
        if (dateToTextField.text?.isEmpty == false){
            dateTo = dateToTextField.text!
        }
        if(availabilityTextField.text?.isEmpty == false){
            availability = bookAvailability[availabilityTextField.text!]!
        }
        if(typeTextField.text?.isEmpty == false){
            type = typeTextField.text!
        }
        if(languageTextField.text?.isEmpty == false){
            language = languageTextField.text!
        }
        let url = "https://fast-lowlands-95120.herokuapp.com/api/books/search?name=\(title)&author=\(author)&dateFrom=\(dateFrom)&dateTo=\(dateTo)&availability=\(availability)&type=\(type)&lang=\(language)"
        let urlString = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        print(urlString!)
        URLSession.shared.dataTask(with: URL(string: urlString!)!) {(data, response, error) in
            do {
                self.books = try JSONDecoder().decode([Book].self, from: data!)
            } catch { print(error) }
            DispatchQueue.main.async {
                self.booksTableView.reloadData()
            }
            }.resume()
        DispatchQueue.main.async { self.booksTableView.reloadData() }
    }
    
    @IBAction func showFilters(_ sender: Any) {
        if(filtersStackView.isHidden == true){
            filtersStackView.isHidden = false
        }
        else {
            filtersStackView.isHidden = true
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
}
