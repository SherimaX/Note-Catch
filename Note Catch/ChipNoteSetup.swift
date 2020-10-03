//
//  ChipNoteSetup.swift
//  Chip Catch New
//
//  Created by Andy Li on 2/26/19.
//  Copyright © 2019 Andy Li. All rights reserved.
//

import Foundation
import SpriteKit

func setQuiz() -> ([String], [SKAction]) {
    var quizAnswer = [String]()
    var sound = [SKAction]()
    for _ in 0..<5 {
        let name = "chip_" + String(8.arc4random)
        
        quizAnswer.append(name)
        sound.append(chipSound(name: name))
        sound.append(SKAction.wait(forDuration: 0.5))
    }
    return (quizAnswer, sound)
}

func setQuiz(numNotes: Int) -> ([String], [SKAction]) {
    var quizAnswer = [String]()
    var sound = [SKAction]()
    for _ in 0..<numNotes {
        let name = "chip_" + String(8.arc4random)
        
        quizAnswer.append(name)
        sound.append(chipSound(name: name))
        sound.append(SKAction.wait(forDuration: 0.5))
    }
    return (quizAnswer, sound)
}

func setQuiz(level: Int, subLevel: Int) -> ([String], [SKAction]) {
    var quizAnswer = [String]()
    var sound = [SKAction]()
    let currentQuiz = quiz[level][subLevel - 1]
    for index in 0..<currentQuiz.count {
        
        
        let name = "chip_" + String(currentQuiz[index] - 1)
        if currentQuiz[index] != 0 {
        quizAnswer.append(name)
        sound.append(chipSound(name: name))
        sound.append(SKAction.wait(forDuration: 0.20))
        } else {
            sound.append(chipSound(name: name))
        }
        
    }
    return (quizAnswer, sound)
}




func chipSound(name: String) -> SKAction {
    
    var soundFileName: String!
    
    
    switch name {
    case "chip_0": soundFileName = "C.wav"
    case "chip_1": soundFileName = "D.wav"
    case "chip_2": soundFileName = "E.wav"
    case "chip_3": soundFileName = "F.wav"
    case "chip_4": soundFileName = "G.wav"
    case "chip_5": soundFileName = "A.wav"
    case "chip_6": soundFileName = "B.wav"
    case "chip_7": soundFileName = "HiC.wav"
    default: return SKAction.wait(forDuration: 0.25)
    }
    let sound = SKAction.playSoundFileNamed(soundFileName, waitForCompletion: false)
    return sound
}


func runAnimation(node: SKNode) {
    node.run(.sequence([SKAction.scale(to: 1.5, duration: 0.2),
                        SKAction.scale(to: 1.0, duration: 0.2)
        ]))
}




