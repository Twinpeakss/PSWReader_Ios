import UIKit

class RegisterPageViewController: UIViewController {

    @IBOutlet weak var userLoginField: UITextField!
    @IBOutlet weak var userEmailField: UITextField!
    @IBOutlet weak var userPasswordField: UITextField!
    @IBOutlet weak var repeatPasswordField: UITextField!
    @IBOutlet weak var userNameField: UITextField!
    @IBOutlet weak var userSurnameField: UITextField!
    @IBOutlet weak var userIndexNumField: UITextField!
    
    let alertService = AlertService()
    let networkingService = NetworkingService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func BackToLoginPage(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }

    @IBAction func registerButtonTapped(_ sender: Any) {
        let username = userLoginField.text
        let name = userNameField.text
        let surname = userSurnameField.text
        let indexNum = userIndexNumField.text
        let email = userEmailField.text
        let password = userPasswordField.text
        let repeatPassword = repeatPasswordField.text
        
        
        
        if(email?.isEmpty ?? false || password?.isEmpty ?? false || repeatPassword?.isEmpty ?? false || username?.isEmpty ?? false || name?.isEmpty ?? false || surname?.isEmpty ?? false || indexNum?.isEmpty ?? false)
        {
            ShowAllertMessage("Wszystkie pola muszą być wypełnione")
        }
            
        else if(repeatPassword != repeatPassword)
        {
            ShowAllertMessage("Hasła nie są indentyczne")
        }
        else{
            jsonRequest(name: name!, surname: surname!, indexNum: indexNum!, username: username!, email: email!, password: password!)
        }
        
        //let alert = UIAlertController(title: "Powiadomienie", message: "Udało się zarejestrować", preferredStyle: UIAlertController.Style.alert)
        //alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default))
        //self.present(alert, animated: true, completion: nil)
    }
    func ShowAllertMessage(_ userMessage: String)
    {
        let alert = UIAlertController(title: "Powiadomienie", message: userMessage, preferredStyle: UIAlertController.Style.alert)
        
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func jsonRequest(name: String, surname: String, indexNum: String, username: String, email: String, password: String) {
        let no = Int(indexNum) ?? 0
        let register = Register(name: name, surname: surname, no: no, username: username, email: email, password: password)
        networkingService.request(endpoint: "/register", registerObj: register) {  [weak self] (result) in
            switch result {
            case .success(let user):
                self!.dismiss(animated: true, completion: nil)
            case .failure(let error):
                guard let alert = self!.alertService.alert(message: error.localizedDescription) else { return }
                self!.present(alert, animated: true)
            }
        }
    }
}

struct Register: Encodable {
    let name: String
    let surname: String
    let no: Int
    let username: String
    let email: String
    let password: String
}
