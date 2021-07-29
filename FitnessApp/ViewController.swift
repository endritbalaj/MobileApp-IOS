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
    
    @IBOutlet weak var fullnameTextField: UITextField!
    
    
    @IBOutlet weak var ageTextField: UITextField!
    
    @IBOutlet weak var label: UILabel!
    
    @IBAction func button(_ sender: Any) {
        let fullname = fullnameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        print("\(fullname)")
        if(fullname?.isEmpty)!{
            print("Name is empty")
            return;
        }
        
        
        let age = ageTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        if(age?.isEmpty)!{
            print("Age is empty")
            return;
        }
        
        var stmt: OpaquePointer?
        let insertquery = "INSERT INTO test2 (fullname, age) VALUES (?, ?)"
        
        if sqlite3_prepare(db, insertquery, -1, &stmt, nil) != SQLITE_OK
        {
            print("Errors binding query")
        }
       
    
        if sqlite3_bind_text(stmt, 1, fullname, -1, nil) != SQLITE_OK
        {
            print("Errors binding fullname")
            
        }
        
        if sqlite3_bind_int(stmt, 2, (age! as NSString).intValue) != SQLITE_OK
        {
            print("Errors binding age")
        }
        
        if sqlite3_step(stmt) == SQLITE_DONE
        {
            print("SUCCESSFULLY")
        }
        if sqlite3_finalize(stmt) != SQLITE_OK {
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("error finalizing prepared statement: \(errmsg)")
        }
        
        stmt = nil
        
    }
    
    @IBAction func View(_ sender: Any) {
        var selectStmt: OpaquePointer?
        let selectquery = "select * from test2"
        
        if sqlite3_prepare(db, selectquery, -1, &selectStmt, nil) == SQLITE_OK
        {
            while sqlite3_step(selectStmt) == SQLITE_ROW
            {
                let rowID = sqlite3_column_int(selectStmt, 0)
                
                let rowName = sqlite3_column_text(selectStmt, 1)
                
                let rowAge = sqlite3_column_int(selectStmt, 2)
                
                let rowNameString = String(cString: rowName!)
                
                print("\(rowID) \(rowNameString) \(rowAge)")
            }
        }
        
    }
    @IBAction func deleterows(_ sender: Any) {
        var deleteStmt: OpaquePointer?
        let deletequery = "delete from test2"
        
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
            .appendingPathComponent("test2.sqlite")
        
        // open database
        
        
        guard sqlite3_open(fileURL.path, &db) == SQLITE_OK else {
            print("error opening database")
            sqlite3_close(db)
            db = nil
            return
        }
        
        if sqlite3_exec(db, "create table if not exists test2 (id integer primary key autoincrement, fullname text, age integer)", nil, nil, nil) != SQLITE_OK {
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

