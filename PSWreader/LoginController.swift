import UIKit

class LoginController: UIViewController {

    @IBOutlet weak var logInButton: UIButton!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    let alertService = AlertService()
    let networkingService = NetworkingService()
    
    var dataSave = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        logInButton.layer.cornerRadius = 25
        logInButton.layer.shadowRadius = 9
        logInButton.layer.shadowOpacity = 0.5
        logInButton.layer.shadowColor =   UIColor.orange.cgColor
        logInButton.layer.shadowOffset = CGSize(width: 0, height: 0)
    
    }
    
    @IBAction func LoginButtonTaped(_ sender: Any) {
        
        guard let username = usernameTextField.text else { return }
        guard let password = passwordTextField.text else { return }
        jsonRequest(username: username, password: password)
    }
    
    func jsonRequest(username: String, password: String) {
        let login = Login(username: username, password: password)
        networkingService.request(endpoint: "/login", loginObj: login) {  [weak self] (result) in
            switch result {
            case .success(let user):
                self!.dataSave.set(true, forKey: "isUserLoggedIn")
                UserDefaults.standard.set(user.id, forKey: "userID")
                UserDefaults.standard.set(user.username, forKey: "userUsername")
                self!.dismiss(animated: true, completion: nil)
            case .failure(let error):
                guard let alert = self!.alertService.alert(message: error.localizedDescription) else { return }
                self!.present(alert, animated: true)
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? SearchController, let user = sender as? User {
            vc.user = user
        }
    }
}

struct User: Decodable {
    let id: String
    let username: String
}

struct Login: Encodable {
    let username: String
    let password: String
}

struct ErrorResponse: Decodable, LocalizedError {
    let message: String
    var errorDescription: String? { return message }
}
