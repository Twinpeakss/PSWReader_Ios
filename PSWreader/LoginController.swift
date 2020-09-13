//
//  LoginController.swift
//  PSWreader
//
//  Created by dima on 09.09.2020.
//  Copyright © 2020 dima. All rights reserved.
//

import UIKit

class LoginController: UIViewController {

    @IBOutlet weak var logInButton: UIButton!
    
    @IBOutlet weak var Email: UITextField!
    
    @IBOutlet weak var Password: UITextField!
    
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
        
        if(dataSave.string(forKey: "userEmail") == Email.text && dataSave.string(forKey: "userPassword") == Password.text)
        {
            
            dataSave.set(true, forKey: "isUserLoggedIn")
            
            self.dismiss(animated: true, completion: nil)
            //Show Another ViewController
        }
        else
        {
            ShowAllertMessage("Wprowadzone nie poprawne dane")
        }
        
        
    }
    
    
    func ShowAllertMessage(_ userMessage: String)
    {
        let alert = UIAlertController(title: "Powiadomienie", message: userMessage, preferredStyle: UIAlertController.Style.alert)
        
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
    }

}
