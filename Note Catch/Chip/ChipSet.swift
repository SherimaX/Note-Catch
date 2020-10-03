//
//  ChipSet.swift
//  Chip Catch
//
//  Created by Andy Li on 2/20/19.
//  Copyright © 2019 Andy Li. All rights reserved.
//

import Foundation


struct ChipSet {
    private(set) var chips = [Chip]()
    
    init() {
        for attribute in Chip.all {
            chips.append(Chip(attribute: attribute))
        }
    }
    
    mutating func draw() -> Chip? {
        if chips.count > 0 {
            return chips.remove(at: chips.count.arc4random)
        } else {
            return nil
        }
    }
    
    func allChips() -> [Chip] {
        return chips
    }
}


extension Int {
    var arc4random: Int {
        if self > 0 {
            return Int(arc4random_uniform(UInt32(self)))
        } else if self < 0 {
            return Int(arc4random_uniform(UInt32(self)))
        } else {
            return 0
        }
    }
}
    

