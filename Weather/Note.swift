//
//  Note.swift
//  Weather
//
//  Created by Admin on 22/06/2019.
//  Copyright © 2019 Admin. All rights reserved.
//

import Foundation
import UIKit

enum ImportanceNote {
    case unimportant
    case ordinary
    case important
}

struct Note2{
    let uid: String
    let title: String
    let content: String
    let color: UIColor
    let importance: ImportanceNote
    let selfDestructionDate: Date?
    
    //only mandatory fields
    init(title: String, content: String, importance: ImportanceNote){
        self.title = title
        self.content = content
        self.importance = importance
        self.uid = UUID().uuidString
        self.color = UIColor.init(ciColor: CIColor.white)
    }
    
    //mandatory fields + uid
    init(uid: String, title: String, content: String, importance: ImportanceNote){
        self.uid = uid
        self.title = title
        self.content = content
        self.importance = importance
        self.color = UIColor.init(ciColor: CIColor.white)
    }
    
    //mandatory fields + color
    init(title: String, content: String, color: UIColor, importance: ImportanceNote){
        self.title = title
        self.content = content
        self.importance = importance
        self.uid = UUID().uuidString
        self.color = color
    }
    
    //full fields
    init(uid: String, title: String, content: String, color: UIColor, importance: ImportanceNote, selfDestructionDate: Date){
        self.uid = uid
        self.title = title
        self.content = content
        self.color = color
        self.importance = importance
        self.selfDestructionDate = selfDestructionDate
    }
}

extension String {
    
    static func random(length: Int) -> String {
        
        if length != 0 {
            let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
            return String((0..<length).map { _ in letters.randomElement()! })
        } else {
            return "length is 0"
        }
    }
}

let testS = String.random(length: 10)
//print(testS)

