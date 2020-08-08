//
//  Note.swift
//  JotItDown
//
//  Created by Kyle on 8/8/20.
//  Copyright © 2020 Kyle. All rights reserved.
//

import UIKit

class Note: NSObject, Codable {
    
    var title: String
    var dateCreated: Date
    var body: String
    
    init(title:String, body:String) {
        self.title = title
        self.body = body
        self.dateCreated = Date()
    }
    
    func formatDate() -> String{
        let formatter = DateFormatter()
        formatter.dateFormat = "M/dd/yyyy"
        return formatter.string(from:dateCreated)
    }
}
