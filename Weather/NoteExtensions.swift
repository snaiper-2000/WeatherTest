//
//  NoteExtensions.swift
//  Weather
//
//  Created by Admin on 23/06/2019.
//  Copyright © 2019 Admin. All rights reserved.
//

import Foundation

extension Note {
    var json: [String: Any]
    
    static func parse(json: [String: Any]) -> Note?{
        if json["uid"] !=  nil {
            self.uid = json["uid"]
        }
    }
}
