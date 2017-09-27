//
//  Student.swift
//  FirebaseStudentList
//
//  Created by Mitch Praag on 7/27/17.
//  Copyright © 2017 Mitch Praag. All rights reserved.
//

import Foundation

struct Student {
    let name: String
    let id : String
    
    
}

extension Student {
    
    static let kName = "name"
    
    var jsonRep: [String: Any]? {
        
        return [Student.kName : self.name]
    }

    init?(id: String, json:[String: Any]) {
        guard let name = json[Student.kName] as? String else { return nil }
        
        self.init(name: name, id: id)
    }
    
    var jsonData: Data? {
        
        guard let jsonRep = jsonRep else { return nil }
        
        return try? JSONSerialization.data(withJSONObject: jsonRep, options: [])
    }

}

