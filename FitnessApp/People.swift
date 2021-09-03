//
//  People.swift
//  FitnessApp
//
//  Created by endrit balaj on 30/07/2021.
//  Copyright © 2021 endrit balaj. All rights reserved.
//

import Foundation

public class People {
    var id: Int = 0
    var fullname: String = ""
    var age: Int = 0
    
    init(id: Int, fullname:String, age:Int) {
        self.id = id
        self.fullname = fullname
        self.age = age
        
    }
}
