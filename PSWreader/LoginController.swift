//
//  LoginController.swift
//  PSWreader
//
//  Created by dima on 09.09.2020.
//  Copyright © 2020 dima. All rights reserved.
//

import UIKit

class LoginController: UIViewController {

    @IBOutlet weak var LogIn: UIButton!
    
    @IBOutlet weak var Email: UITextField!
    
    @IBOutlet weak var Password: UITextField!
    
    var dataSave = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        LogIn.layer.cornerRadius = 25
        LogIn.layer.shadowRadius = 9
        LogIn.layer.shadowOpacity = 0.5
        LogIn.layer.shadowColor =   UIColor.orange.cgColor
        LogIn.layer.shadowOffset = CGSize(width: 0, height: 0)
    
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
