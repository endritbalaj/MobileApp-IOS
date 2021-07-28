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

    var db: OpaquePointer?
    
    @IBOutlet weak var nameTextField: UITextField!
    
    @IBOutlet weak var surnameTextField: UITextField!
    
    @IBOutlet weak var ageTextField: UITextField!
    
    @IBOutlet weak var label: UILabel!
    
    @IBAction func button(_ sender: Any) {
        let name = nameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        if(name?.isEmpty)!{
            print("Name is empty")
            return;
        }
        
        let surname = surnameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        if(surname?.isEmpty)!{
            print("Surname is empty")
            return;
        }
        
        let age = ageTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        if(age?.isEmpty)!{
            print("Age is empty")
            return;
        }
        
        var stmt: OpaquePointer?
        let insertquery = "INSERT INTO test1 (name, surname, age) VALUES (?, ?, ?)"
        
        if sqlite3_prepare(db, insertquery, -1, &stmt, nil) != SQLITE_OK
        {
            print("Errors binding query")
        }
        if sqlite3_bind_text(stmt, 1, name, -1, nil) != SQLITE_OK
        {
            print("Errors binding name")
            
        }
    
        if sqlite3_bind_text(stmt, 2, surname, -1, nil) != SQLITE_OK
        {
            print("Errors binding surname")
            
        }
        
        if sqlite3_bind_int(stmt, 3, (age! as NSString).intValue) != SQLITE_OK
        {
            print("Errors binding age")
        }
        
        if sqlite3_step(stmt) == SQLITE_DONE
        {
            print("SUCCESSFULLY")
        }
        
    }
    
    @IBAction func View(_ sender: Any) {
        var selectStmt: OpaquePointer?
        let selectquery = "select * from test1"
        
        if sqlite3_prepare(db, selectquery, -1, &selectStmt, nil) == SQLITE_OK
        {
            while sqlite3_step(selectStmt) == SQLITE_ROW
            {
                let rowID = sqlite3_column_int(selectStmt, 0)
                
                let rowName = sqlite3_column_text(selectStmt, 1)
                
                let rowSurname = sqlite3_column_text(selectStmt, 2)
                
                let rowAge = sqlite3_column_int(selectStmt, 3)
                
                let rowNameString = String(cString: rowName!)
                let rowSurnameString = String(cString: rowSurname!)
                
                print("\(rowID) \(rowNameString) \(rowSurnameString) \(rowAge)")
            }
        }
        
    }
    @IBAction func deleterows(_ sender: Any) {
        var deleteStmt: OpaquePointer?
        let deletequery = "delete from test1"
        
        if sqlite3_prepare(db, deletequery, -1, &deleteStmt, nil) != SQLITE_OK
        {
            print("Errors delete query")
        }
        if sqlite3_step(deleteStmt) == SQLITE_DONE
        {
            print("SUCCESSFULLY deleted")
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let fileURL = try! FileManager.default
            .url(for: .applicationSupportDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
            .appendingPathComponent("test1.sqlite")
        
        // open database
        
        
        guard sqlite3_open(fileURL.path, &db) == SQLITE_OK else {
            print("error opening database")
            sqlite3_close(db)
            db = nil
            return
        }
        
        if sqlite3_exec(db, "create table if not exists test1 (id integer primary key autoincrement, name text, surname text, age integer)", nil, nil, nil) != SQLITE_OK {
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("error creating table: \(errmsg)")
        }
        
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

