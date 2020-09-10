//
//  SearchController.swift
//  PSWreader
//
//  Created by dima on 07.09.2020.
//  Copyright © 2020 dima. All rights reserved.
//

import UIKit

class SearchController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
    
    @IBAction func userLoggedOut(_ sender: Any) {
        UserDefaults.standard.set(false, forKey: "isUserLoggedIn")
        performSegue(withIdentifier: "LoginViewSegue", sender: self)
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
