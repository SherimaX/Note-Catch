//
//  GameScene.swift
//  Chip Catch
//
//  Created by Andy Li on 2/22/19.
//  Copyright © 2019 Andy Li. All rights reserved.
//

import SpriteKit
import GameplayKit
import CoreMotion
import os.log

class NodeRandomScene: SKScene {
    
    var chips = [ChipNode]()
    var label : SKLabelNode?
    var status : SKLabelNode?
    var sound: [SKAction] = []
    var scoreLabel: SKLabelNode?
    var lifeLabel: SKLabelNode?
    var quizAnswer : [String] = []
    var userAnswer : [String] = []
    var isSolved = false
    var numNotes = 1
    var mode = 1
    var touchCount = 0
    var score = 0
    var highScore = 0
    var life = 3
    var gameData : GameData?
    
    override func didMove(to view: SKView) {
        layoutScene()
        (quizAnswer, sound) = setQuiz(numNotes: numNotes)
        run(.sequence([SKAction.wait(forDuration: 0.5)] + sound), withKey: "sound")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first
        let positionInScene = touch?.location(in: self)
        let touchedNode = self.atPoint(positionInScene!)
        if let name = touchedNode.name {
                runAnimation(node: touchedNode)
                processTouch(name: name)
        }
    }
    
    func layoutScene() {
        backgroundColor = #colorLiteral(red: 0.9542122483, green: 0.9485396743, blue: 0.9585725665, alpha: 1)
        setChips()
        setup()
        
        
    }
    
    
    private func setup() {
        var button: SKShapeNode!
        var toMenu: SKLabelNode!
        let buttonPath = CGMutablePath()
    
        
        button = childNode(withName: "reset") as? SKShapeNode
        
        buttonPath.addRoundedRect(in: CGRect(origin: CGPoint(x: -80, y: -25), size: CGSize(width: 160, height: 50)), cornerWidth: 25, cornerHeight: 25)
        button.path = buttonPath
        button.fillColor = #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
        button.physicsBody?.affectedByGravity = false
        
        
        label = childNode(withName: "label") as? SKLabelNode
        label?.text = ""
        label?.fontSize = 100
        
        scoreLabel = childNode(withName: "score") as? SKLabelNode
        scoreLabel?.fontSize = 50
        
        lifeLabel = childNode(withName: "life") as? SKLabelNode
        lifeLabel?.fontSize = 50
        
        status = childNode(withName: "status") as? SKLabelNode
        status?.text = ""
        status?.fontSize = 50
        
        
        toMenu = childNode(withName: "toMenu") as? SKLabelNode
        toMenu.fontSize = 50
        
        
        
        
    }
    
    
    

    
    

    
    
    private func setChips() {
        var chip: ChipNode!
        var chipSet = ChipSet().allChips()
        
        let path = CGMutablePath()
        path.addArc(center: CGPoint.zero,
                    radius: 50,
                    startAngle: 0,
                    endAngle: CGFloat.pi * 2,
                    clockwise: true)
        
        
        for index in 0..<8 {
            chip = childNode(withName: "chip_" + String(index)) as? ChipNode
            chip.path = path
            chip.fillColor = chipSet[index].attribute.2.color
            chip.physicsBody = SKPhysicsBody(circleOfRadius: 50)
            chip.physicsBody?.affectedByGravity = false
            chips.append(chip)
            
        chip = childNode(withName: "mid") as? ChipNode
            chip.fillColor = #colorLiteral(red: 1, green: 0.3131226003, blue: 0.9356933832, alpha: 1)
            chip.path = path
            chip.physicsBody = SKPhysicsBody(circleOfRadius: 50)
            chip.physicsBody?.affectedByGravity = false
            
        }
        
    }
    

    

    func processTouch (name: String) {
        if let chip = childNode(withName: name) as? ChipNode, life > 0 {
            if name == "mid" {
                self.removeAction(forKey: "sound")
                chip.run(.sequence(sound), withKey: "sound")
                userAnswer = []
                touchCount = 0
                label?.text = ""
                status?.text = ""
            } else {
                let sound = chipSound(name: chip.name!)
                touchCount += 1
                userAnswer.append(chip.name!)
                chip.run(sound)
                
                isSolved = checkAnswer(count: &touchCount)
                printStatus()
                
            }
        } else if let _ = childNode(withName: name) as? SKShapeNode, life > 0 {
            if name == "reset" {
                userAnswer = []
                touchCount = 0
                label?.text = ""
                status?.text = ""
            }
        } else if let _ = childNode(withName: name) as? SKLabelNode {
            if name == "toMenu" {
                let menuScene = RandomScene(fileNamed: "RandomModeScene.sks")!
                menuScene.scaleMode = .aspectFill
                super.view?.presentScene(menuScene, transition: SKTransition.push(with: SKTransitionDirection.down, duration: 0.5))
            }
        }

    
    }
    
    
    
    private func printStatus() {
        var dots : String = ""
        if touchCount == 0 {
            status?.text = ""
        } else {
            for _ in 0..<touchCount - 1 {
                dots += "• "
            }
            dots += "•"
            status?.text = dots
            
            
        }
        
    }
    
    private func checkAnswer( count: inout Int ) -> Bool {
        
        if count == numNotes {
            if userAnswer == quizAnswer {
                label?.text = "Correct!"
                count = 0
                updateScore()
                save(Mode: mode)
                (quizAnswer, sound) = setQuiz(numNotes: numNotes)
                run(.sequence([SKAction.wait(forDuration: 1.0)] + sound), withKey: "sound")
                userAnswer = []
                return true
                
            } else {
                updateLife()
                if life == 0 {
                    label?.text = "Game Over!"
                    save(Mode: mode)
                } else {
                    label?.text = "Wrong!"
                    (quizAnswer, sound) = setQuiz(numNotes: numNotes)
                    run(.sequence([SKAction.wait(forDuration: 1.0)] + sound), withKey: "sound")
                }
                count = 0
                userAnswer = []
                return false
            }
            
        }
        label?.text = ""
        return false
    }
    
    private func updateScore() {
        score += 1
        let text = String(score)
        scoreLabel?.text = text
    }
    
    private func updateLife() {
        life -= 1
        var text = ""
        
        if life > 0 {
            for _ in 0..<life - 1 {
                text += "• "
            }
            text += "•"
        }
        
        lifeLabel?.text = text
    }
    
    
    private func save(Mode: Int) {
        switch Mode {
        case 1: saveEasy()
        case 2: saveNormal()
        case 3: saveHard()
        default: return
        }
    }
    
    
    
    private func saveEasy() {
        let savedInt = score
        if score > getHighScoreEasy() {
            let userDefaults = Foundation.UserDefaults.standard
            userDefaults.set(savedInt, forKey: "Easy")
        }
    }
            
    private func getHighScoreEasy() -> Int {
        let userDefaults = Foundation.UserDefaults.standard
        let value = userDefaults.integer(forKey: "Easy")
        return value
    }
    
    private func saveNormal() {
        let savedInt = score
        if score > getHighScoreNormal() {
            let userDefaults = Foundation.UserDefaults.standard
            userDefaults.set(savedInt, forKey: "Normal")
        }
    }
    
    private func getHighScoreNormal() -> Int {
        let userDefaults = Foundation.UserDefaults.standard
        let value = userDefaults.integer(forKey: "Normal")
        return value
    }
    
    private func saveHard() {
        let savedInt = score
        if score > getHighScoreHard() {
            let userDefaults = Foundation.UserDefaults.standard
            userDefaults.set(savedInt, forKey: "Hard")
        }
    }
    
    private func getHighScoreHard() -> Int {
        let userDefaults = Foundation.UserDefaults.standard
        let value = userDefaults.integer(forKey: "Hard")
        return value
    }
    
    
}




