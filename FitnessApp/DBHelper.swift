//
//  DBHelper.swift
//  FitnessApp
//
//  Created by endrit balaj on 30/07/2021.
//  Copyright © 2021 endrit balaj. All rights reserved.
//

import UIKit
import SQLite3

class DBHelper {
    
    init()
    {
        db = openDatabase()
        createTable()
    }

    var db : OpaquePointer?

    func openDatabase() -> OpaquePointer?
    {
        let fileURL = try! FileManager.default
            .url(for: .applicationSupportDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
            .appendingPathComponent("test2.sqlite")
        
        // open database
        
        
        guard sqlite3_open(fileURL.path, &db) == SQLITE_OK else {
            print("error opening database")
            sqlite3_close(db)
            db = nil
            return nil
        }
        return db
    }
    
    
    func createTable()
    {
        if sqlite3_exec(db, "create table if not exists test2 (id integer primary key autoincrement, fullname text, age integer)", nil, nil, nil) != SQLITE_OK {
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("error creating table: \(errmsg)")
        }
    }
    
    func insertRecord(fullname: String, age: Int)
    {
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
        
        if sqlite3_bind_int(stmt, 2, Int32(age)) != SQLITE_OK
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
    
    func deleteRecord()
    {
        
    }

}
