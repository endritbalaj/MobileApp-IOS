//
//  ViewController.swift
//  FitnessApp
//
//  Created by endrit balaj on 18/07/2021.
//  Copyright © 2021 endrit balaj. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var label: UILabel!
    
    @IBAction func button(_ sender: Any) {
        label.text = "success"
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

