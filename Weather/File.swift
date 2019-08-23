//
//  File.swift
//  Weather
//
//  Created by Admin on 21/06/2019.
//  Copyright © 2019 Admin. All rights reserved.
//

import Foundation

extension Array{
    
    //var arrayResult = Array<Int>()
    
    //возвращаем новый массив
    func myShuffled() -> Array{
        var arrayResult = [Element]()
        for (index, element) in self.enumerated() {
            for randomIndex  in 0..<self.count{
                //arrayResult.insert(element, at: randomIndex)
                return arrayResult
            }
        }
        return arrayResult
    }
}

let arr1 = [1, 2, 3].myShuffled()

func calcLetters(str: String) -> [String: Int] {
    var xdict = [String: Int]()
    xdict[str] = str.count
    return xdict
}

var testD = calcLetters(str: "Hello")
