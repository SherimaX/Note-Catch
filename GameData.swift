//
//  GameData.swift
//  Note Catch
//
//  Created by Andy Li on 2/28/19.
//  Copyright © 2019 Andy Li. All rights reserved.
//

import Foundation


struct GameData: Codable {
    var highScore: Int
    
    var json: Data? {
        return try? JSONEncoder().encode(self)
    }
    init(highScore: Int) {
        self.highScore = highScore
    }
}
    

