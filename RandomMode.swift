//
//  RandomMode.swift
//  Chip Catch New
//
//  Created by Andy Li on 2/28/19.
//  Copyright © 2019 Andy Li. All rights reserved.
//

import Foundation
import SpriteKit

class RandomScene: SKScene {
    
    

    var levels = [SKShapeNode]()

    let numNotes = [3, 5, 7]
    
    override func didMove(to view: SKView) {
        backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        layoutScene()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first
        let positionInScene = touch?.location(in: self)
        
        
        
        
        let touchedNode = self.atPoint(positionInScene!) as? SKShapeNode
        if let name = touchedNode?.name {
            if name == "toMenu" {
                toMenu()
            }else{
                ChangeScene(level: name)
            }
        }
        
        
    }
    
    
    
    func layoutScene() {
        
        
        var levelNode: SKShapeNode!
        let path = CGMutablePath()
        path.addRoundedRect(in: CGRect(origin: CGPoint(x: -50, y: -50), size: CGSize(width: 100, height: 100)),
                            cornerWidth: 20,
                            cornerHeight: 20)
        
        
        for level in 1...3 {
            levelNode = childNode(withName: String(level)) as? SKShapeNode
            levelNode.fillColor = #colorLiteral(red: 0.9607843137, green: 0.1921568627, blue: 0.1490196078, alpha: 1)
            levelNode.path = path
            levelNode.physicsBody?.affectedByGravity = false
        }
        
        let toMenu: SKShapeNode!
        let toMenuPath = CGMutablePath()
        toMenu = childNode(withName: "toMenu") as? SKShapeNode
        toMenuPath.addRoundedRect(in: CGRect(origin: CGPoint(x: -50, y: -25), size: CGSize(width: 100, height: 50)),
                                  cornerWidth: 20,
                                  cornerHeight: 20)
        toMenu.fillColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        toMenu.path = toMenuPath
        
        
        let userDefaults = Foundation.UserDefaults.standard
        var value: Int
        
        var highScoreEasyLabel: SKLabelNode!
        highScoreEasyLabel = childNode(withName: "HighScoreEasy") as? SKLabelNode
        value = userDefaults.integer(forKey: "Easy")
        highScoreEasyLabel.text = String(value)
        
        var highScoreNormalLabel: SKLabelNode!
        highScoreNormalLabel = childNode(withName: "HighScoreNormal") as? SKLabelNode
        value = userDefaults.integer(forKey: "Normal")
        highScoreNormalLabel.text = String(value)
        
        var highScoreHardLabel: SKLabelNode!
        highScoreHardLabel = childNode(withName: "HighScoreHard") as? SKLabelNode
        value = userDefaults.integer(forKey: "Hard")
        highScoreHardLabel.text = String(value)
        
    }
    
    
    
    private func ChangeScene(level: String) {
        let randomScene = NodeRandomScene(fileNamed: "ChipNoteScene.sks")!
        randomScene.scaleMode = .aspectFill
        randomScene.numNotes = numNotes[Int(level)! - 1]
        randomScene.mode = Int(level)!
        
        super.view?.presentScene(randomScene, transition: SKTransition.push(with: SKTransitionDirection.up, duration: 0.5))
    }
    
    private func toMenu() {
        let menuScene = MenuScene(fileNamed: "MenuScene.sks")!
        menuScene.scaleMode = .aspectFill
        super.view?.presentScene(menuScene, transition: SKTransition.push(with: SKTransitionDirection.down, duration: 0.5))
    }
    
    
    
}
