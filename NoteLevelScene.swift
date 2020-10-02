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

class NoteChallengeScene: SKScene {
    
    var chips = [ChipNode]()
    var result : SKLabelNode?
    var status : SKLabelNode?
    var level = 1
    var sound: [SKAction] = []
    var quizAnswer : [String] = []
    var userAnswer : [String] = []
    var touchCount = 0
    var isSolved = false
    var subLevel = 1
    var toNext: SKLabelNode!
    
    override func didMove(to view: SKView) {
        layoutScene()
        (quizAnswer, sound) = setQuiz(level: level, subLevel: subLevel)
        run(.sequence([SKAction.wait(forDuration: 0.5)] + sound), withKey: "sound")
    }
    

    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        let touch = touches.first
        let positionInScene = touch?.location(in: self)
        let touchedNode = self.atPoint(positionInScene!)
        if let name = touchedNode.name {
            processTouch(name: name)
        }
    }
    
    func layoutScene() {
        backgroundColor = #colorLiteral(red: 0.9542122483, green: 0.9485396743, blue: 0.9585725665, alpha: 1)
        setChips()
        setup()
        
    }
    
    
    private func setup() {
        var reset: SKShapeNode!
        var toMenu: SKLabelNode!
        let resetPath = CGMutablePath()
        
        
        
        result = childNode(withName: "label") as? SKLabelNode
        result?.text = ""
        result?.fontSize = 100
        
        status = childNode(withName: "status") as? SKLabelNode
        status?.text = ""
        status?.fontSize = 50
        
        reset = childNode(withName: "reset") as? SKShapeNode
        
        resetPath.addRoundedRect(in: CGRect(origin: CGPoint(x: -80, y: -25), size: CGSize(width: 160, height: 50)), cornerWidth: 25, cornerHeight: 25)
        
        reset.path = resetPath
        reset.fillColor = #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
        reset.physicsBody?.affectedByGravity = false
        
        toMenu = childNode(withName: "toMenu") as? SKLabelNode
        toMenu.fontSize = 50
        
        toNext = childNode(withName: "toNext") as? SKLabelNode
        toNext.fontSize = 50
        toNext.isHidden = true

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
        if let chip = childNode(withName: name) as? ChipNode {
            runAnimation(node: chip)
            
            if name == "mid" {
                self.removeAction(forKey: "sound")
                chip.run(.sequence(sound), withKey: "sound")
                userAnswer = []
                touchCount = 0
                result?.text = ""
                status?.text = ""
            } else {
                let sound = chipSound(name: chip.name!)
                touchCount += 1
                userAnswer.append(chip.name!)
                chip.run(sound)
                if !isSolved {
                    isSolved = checkAnswer(count: &touchCount, numNotes: quizAnswer.count)
                } else {
                    touchCount = 0
                }
                printStatus()
                
            }
        } else if let button = childNode(withName: name) as? SKShapeNode {
            runAnimation(node: button)
            if name == "reset" {
                userAnswer = []
                touchCount = 0
                result?.text = ""
                status?.text = ""
            }
        } else if let label = childNode(withName: name) as? SKLabelNode {
            runAnimation(node: label)
            if name == "toMenu" {
                let fileName = "LevelScene" + String(level) + ".sks"
                let menuScene = NoteLevelScene(fileNamed: fileName)!
                menuScene.scaleMode = .aspectFill
                super.view?.presentScene(menuScene, transition: SKTransition.push(with: SKTransitionDirection.down, duration: 0.5))
            } else if name == "toNext" {
                (quizAnswer, sound) = setQuiz(level: level, subLevel: subLevel)
                run(.sequence([SKAction.wait(forDuration: 0.5)] + sound), withKey: "sound")
                result?.text = ""
                isSolved = false
                label.isHidden = true
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
    
    private func checkAnswer( count: inout Int, numNotes: Int ) -> Bool {
        
        if count == numNotes {
            if userAnswer == quizAnswer {
                result?.text = "Correct!"
                count = 0
                updateLevel()
                save()
                toNext?.isHidden = false
                userAnswer = []
                return true
                
            } else {
                result?.text = "Wrong!"
                count = 0
                userAnswer = []
                return false
            }
            
        }
        result?.text = ""
        return false
    }
    
    private func updateLevel() {
        
        if level <= 5 {
            if subLevel < 9 {
                subLevel += 1
            } else if level != 5 {
                subLevel = 1
                level += 1
            }
            
        }
        
    }
    
    private func save() {
        
        
        if level > getLevel() || (level == getLevel() && subLevel > getSubLevel()) {
            let userDefaults = Foundation.UserDefaults.standard
            userDefaults.set(level, forKey: "Level")
            userDefaults.set(subLevel, forKey: "SubLevel")
        }
        
        
    }
    
    
    private func getLevel() -> Int {
        let userDefaults = Foundation.UserDefaults.standard
        let value = userDefaults.integer(forKey: "Level")
        return value
    }
    
    private func getSubLevel() -> Int {
        let userDefaults = Foundation.UserDefaults.standard
        let value = userDefaults.integer(forKey: "SubLevel")
        return value
    }
}



