//
//  ViewController.swift
//  FitnessApp
//
//  Created by endrit balaj on 18/07/2021.
//  Copyright © 2021 endrit balaj. All rights reserved.
//

import UIKit
import SQLite3

class ViewController: UIViewController {

    var db:DBHelper = DBHelper()
    
    @IBOutlet weak var fullnameTextField: UITextField!
    
    
    @IBOutlet weak var ageTextField: UITextField!
    
    @IBOutlet weak var label: UILabel!
    
    @IBAction func button(_ sender: Any) {
        let fullname = fullnameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        if(fullname?.isEmpty)!{
            print("Name is empty")
            return;
        }
        
        
        let age = ageTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        if(age?.isEmpty)!{
            print("Age is empty")
            return;
        }
        let ageInt:Int? = Int(age!)
        
        db.insertRecord(fullname: fullname!, age: ageInt!)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

