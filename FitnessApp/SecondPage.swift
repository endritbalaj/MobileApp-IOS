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
    var db: OpaquePointer?
    
    
    @IBOutlet weak var table: UITableView!

    @IBAction func showdata(_ sender: Any) {
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
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = UITableViewCell(style:UITableViewCell.CellStyle.default, reuseIdentifier: "cell")
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int{
        
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
    
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    


}
