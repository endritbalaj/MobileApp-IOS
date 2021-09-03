//
//  DBHelper.swift
//  FitnessApp
//
//  Created by endrit balaj on 30/07/2021.
//  Copyright © 2021 endrit balaj. All rights reserved.
//

import UIKit
import SQLite3

public class DBHelper {

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
    
    func read() -> [People] {
        let queryStatementString = "select id, fullname, age from test2"
        var queryStatement: OpaquePointer? = nil
        var psns : [People] = []
        if sqlite3_prepare_v2(db, queryStatementString, -1, &queryStatement, nil) == SQLITE_OK {
            while sqlite3_step(queryStatement) == SQLITE_ROW {
                let id = sqlite3_column_int(queryStatement, 0)
                let name = String(describing: String(cString: sqlite3_column_text(queryStatement, 1)))
                let age = sqlite3_column_int(queryStatement, 2)
                
                psns.append(People(id: Int(id), fullname: name, age:Int(age)))
                print("Query Result:")
                print("\(id) | \(name) \(age)")
            }
        } else {
            print("SELECT statement could not be prepared")
        }
        sqlite3_finalize(queryStatement)
        return psns
    }
    
    func deleteRecord(id:Int) {
        let deleteStatementStirng = "DELETE FROM test2 WHERE Id = ?;"
        var deleteStatement: OpaquePointer? = nil
        if sqlite3_prepare_v2(db, deleteStatementStirng, -1, &deleteStatement, nil) == SQLITE_OK {
            sqlite3_bind_int(deleteStatement, 1, Int32(id))
            if sqlite3_step(deleteStatement) == SQLITE_DONE {
                print("Successfully deleted row.")
            } else {
                print("Could not delete row.")
            }
        } else {
            print("DELETE statement could not be prepared")
        }
        sqlite3_finalize(deleteStatement)
    }
    

}
