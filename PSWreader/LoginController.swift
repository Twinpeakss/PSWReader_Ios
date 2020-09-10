//
//  LoginController.swift
//  PSWreader
//
//  Created by dima on 09.09.2020.
//  Copyright © 2020 dima. All rights reserved.
//

import UIKit

class LoginController: UIViewController {

    let user_email = "admin"
    let password = "admin"
    
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
        InitiateLoginData()
    }
    
    
    func InitiateLoginData(){
        dataSave.set(user_email, forKey: "email")
        dataSave.set(password, forKey:"password")
    }
    
    
    @IBAction func LoginButtonTaped(_ sender: Any) {
        
        if(dataSave.string(forKey: "email") == Email.text && dataSave.string(forKey: "password") == Password.text)
        {
            
            dataSave.set(true, forKey: "isUserLoggedIn")
            
            //Show Another ViewController
        }
        else
        {
            ShowAllertMessage()
        }
        
        
    }
    
    
    func ShowAllertMessage()
    {
        let alert = UIAlertController(title: "Powiadomienie", message: "Nie poprawne dane", preferredStyle: UIAlertController.Style.alert)
        
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
    }

}
