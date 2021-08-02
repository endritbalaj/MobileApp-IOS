//
//  SecondPage.swift
//  FitnessApp
//
//  Created by endrit balaj on 20/07/2021.
//  Copyright © 2021 endrit balaj. All rights reserved.
//

import UIKit
import SQLite3


class SecondPage: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var people:[People] = []
    var peopleid = 0
    var db:DBHelper = DBHelper()
    
    @IBOutlet weak var table: UITableView!
    
    @IBAction func showdata(_ sender: Any) {
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return people.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = UITableViewCell()
        cell.textLabel?.text = "ID: " + String(people[indexPath.row].id) + " , Name: " + people[indexPath.row].fullname + " , Age: " + String(people[indexPath.row].age)
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCellEditingStyle.delete{
            db.deleteRecord(id: people[indexPath.row].id)
            people = db.read()
            table.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        peopleid = people[indexPath.row].id
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        people = db.read()
        self.table.reloadData()
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    


}
