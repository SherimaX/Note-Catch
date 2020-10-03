//
//  MenuScene.swift
//  Chip Catch New
//
//  Created by Andy Li on 2/26/19.
//  Copyright © 2019 Andy Li. All rights reserved.
//

import Foundation
import SpriteKit

class MenuScene: SKScene {
    
    
    override func didMove(to view: SKView) {
        backgroundColor = #colorLiteral(red: 0.9542122483, green: 0.9485396743, blue: 0.9585725665, alpha: 1)
        layoutScene()
    }
    
    
    private func layoutScene() {
        var button_1: SKShapeNode!
        let buttonPath_1 = CGMutablePath()
        button_1 = childNode(withName: "toNote") as? SKShapeNode
        buttonPath_1.addRoundedRect(in: CGRect(origin: CGPoint(x: -100, y: -50), size: CGSize(width: 200, height: 100)), cornerWidth: 25, cornerHeight: 25)
        button_1.path = buttonPath_1
        button_1.fillColor = #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
        button_1.physicsBody?.affectedByGravity = false
        
        var button_2: SKShapeNode!
        let buttonPath_2 = CGMutablePath()
        button_2 = childNode(withName: "toNoteRandom") as? SKShapeNode
        buttonPath_2.addRoundedRect(in: CGRect(origin: CGPoint(x: -100, y: -50), size: CGSize(width: 200, height: 100)), cornerWidth: 25, cornerHeight: 25)
        button_2.path = buttonPath_2
        button_2.fillColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
        button_2.physicsBody?.affectedByGravity = false
        
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first
        let positionInScene = touch?.location(in: self)
        if let touchedNode = self.atPoint(positionInScene!) as? SKShapeNode {
            runAnimation(node: touchedNode)
        }
        
        
    }
    

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        let touch = touches.first
        let positionInScene = touch?.location(in: self)
        let touchedNode = self.atPoint(positionInScene!)
        if let name = touchedNode.name {
            if name == "toNote" {
                let noteScene = NoteLevelScene(fileNamed: "LevelScene1.sks")!
                noteScene.scaleMode = .aspectFill
                super.view?.presentScene(noteScene, transition: SKTransition.push(with: SKTransitionDirection.up, duration: 0.5))
                
            } else if name == "toNoteRandom" {
                let noteScene = RandomScene(fileNamed: "RandomModeScene.sks")!
                noteScene.scaleMode = .aspectFill
                super.view?.presentScene(noteScene, transition: SKTransition.push(with: SKTransitionDirection.up, duration: 0.5))
            }
        }
    }
    
    
    
}
