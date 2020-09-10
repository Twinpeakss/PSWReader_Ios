//
//  RegisterPageViewController.swift
//  PSWreader
//
//  Created by dima on 10.09.2020.
//  Copyright © 2020 dima. All rights reserved.
//

import UIKit

class RegisterPageViewController: UIViewController {

    
    @IBOutlet weak var userEmailField: UITextField!
    
    @IBOutlet weak var userPasswordField: UITextField!
    
    @IBOutlet weak var repeatPasswordField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    
    @IBAction func BackToLoginPage(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    

    @IBAction func registerButtonTapped(_ sender: Any) {
        
        let userEmail = userEmailField.text
        let userPassword = userPasswordField.text
        let userRepeatPassword = repeatPasswordField.text
        
        if(userEmail?.isEmpty ?? false || userPassword?.isEmpty ?? false || userRepeatPassword?.isEmpty ?? false)
        {
            ShowAllertMessage("Wszystkie pola muszą być wypełnione")
        }
        
        if(userPassword != userRepeatPassword)
        {
            ShowAllertMessage("Hasła nie są indentyczne")
        }
        
         UserDefaults.standard.set(userEmail, forKey: "userEmail")
         UserDefaults.standard.set(userPassword, forKey: "userPassword")
        
        
        let alert = UIAlertController(title: "Powiadomienie", message: "Udało się zarejestrować", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default) {ACTION in self.dismiss(animated: true, completion: nil)})
        self.present(alert, animated: true, completion: nil)
    }
    
    
    
    func ShowAllertMessage(_ userMessage: String)
    {
        let alert = UIAlertController(title: "Powiadomienie", message: userMessage, preferredStyle: UIAlertController.Style.alert)
        
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
    }

    
    
    

}
