//
//  ViewController.swift
//  PSWreader
//
//  Created by dima on 06.09.2020.
//  Copyright © 2020 dima. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var LogIn: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        LogIn.layer.cornerRadius = 25
        LogIn.layer.shadowRadius = 9
        LogIn.layer.shadowOpacity = 0.5
        LogIn.layer.shadowColor = 	UIColor.orange.cgColor
        LogIn.layer.shadowOffset = CGSize(width: 0, height: 0)
    }

    
    
    
}

