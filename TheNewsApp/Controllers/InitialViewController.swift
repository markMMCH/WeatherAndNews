//
//  InitialViewController.swift
//  TheNewsApp
//
//  Created by Lyub Chibukhchian on 7/24/19.
//  Copyright © 2019 Lyub Chibukhchian. All rights reserved.
//

import UIKit

class InitialViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func weatherButtonTapped(_ sender: UIButton) {
        performSegue(withIdentifier: "goToWeather", sender: self)
        
    }
    
    @IBAction func newsButtonTapped(_ sender: UIButton) {
    }
    
    
    

  

}