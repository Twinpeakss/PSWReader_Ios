import UIKit

class BorrowedBooksController: UIViewController, UITableViewDataSource, UITableViewDelegate{

    var dataSave = UserDefaults.standard
    var rentals: [Rental] = []
    var books: [Book] = []
    
    @IBOutlet weak var rentalsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        rentalsTableView.delegate = self
        rentalsTableView.dataSource = self
        let url = "https://fast-lowlands-95120.herokuapp.com/api/rentals/user/\(dataSave.string(forKey: "userID")!)"
        URLSession.shared.dataTask(with: URL(string: url)!) {(data, response, error) in
            do {
                self.rentals = try JSONDecoder().decode([Rental].self, from: data!)
            } catch { print(error) }
            DispatchQueue.main.async {
                self.rentalsTableView.reloadData()
            }
            }.resume()
        //userLabel.text = "\(dataSave.string(forKey: "userUsername"))'s Rentals:"
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rentals.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewCell
        cell.coverImageView.load(url: URL(string: rentals[indexPath.row].book.cover)!)
        cell.nameLabel.text = rentals[indexPath.row].book.name
        cell.infoLabel.text = "\(String(rentals[indexPath.row].book.published)), \(rentals[indexPath.row].book.author)"
        cell.rentalDateLabel.text = String(rentals[indexPath.row].rental_date.prefix(10))
        cell.returnDateLabel.text = String(rentals[indexPath.row].return_date.prefix(10))
        return cell
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
}

struct Rental: Decodable {
    let user: String
    let book: Book
    let rental_date: String
    let return_date: String
}
