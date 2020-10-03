//
//  NoteLevelScene.swift
//  Chip Catch New
//
//  Created by Andy Li on 2/26/19.
//  Copyright © 2019 Andy Li. All rights reserved.
//

import Foundation
import SpriteKit


class NoteLevelScene: SKScene {
    
    lazy var levelScenes : [String] = {
        return ["LevelScene1",
                "LevelScene2",
                "LevelScene3",
                "LevelScene4",
                "LevelScene5",
                ]
        }()
    
    func getIndex() -> Int {
        switch name {
        case "LevelScene0":
            return 0
        case "LevelScene1":
            return 1
        case "LevelScene2":
            return 2
        case "LevelScene3":
            return 3
        case "LevelScene4":
            return 4
        case "LevelScene5":
            return 5
        default:
            return -1
        }
        
    }

    
    lazy var levelColor : [UIColor] = {
        return [#colorLiteral(red: 0.5281563997, green: 1, blue: 0.1642519534, alpha: 1), #colorLiteral(red: 1, green: 0.1576584578, blue: 0.1061429456, alpha: 1), #colorLiteral(red: 1, green: 0.987981379, blue: 0, alpha: 1), #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1), #colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1), #colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1)]
    }()
    
    
    
    var levels = [SKShapeNode]()
    
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
            } else if name == "toNext" {
                toNext()
            } else if name == "toPrev" {
                toPrev()
            }else if touchedNode?.fillColor != #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1) {
                ChangeScene(subLevel: Int(name)!)
            }
        }
        
    
    }
    
    
    
    func layoutScene() {
        var levelNode: SKShapeNode!
        let path = CGMutablePath()
        path.addRoundedRect(in: CGRect(origin: CGPoint(x: -50, y: -50), size: CGSize(width: 100, height: 100)),
                            cornerWidth: 20,
                            cornerHeight: 20)
        
        var level = getLevel()
        var subLevel = getSubLevel()
        if level == 0 {
            level = 1
        }
        if subLevel == 0 {
            subLevel = 1
        }
        
        
        if getIndex() > level {
            for level in 1...9 {
                levelNode = childNode(withName: String(level)) as? SKShapeNode
                levelNode.fillColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
                levelNode.path = path
                levelNode.physicsBody?.affectedByGravity = false
            }
        } else {
            for level in 1...9 {
                levelNode = childNode(withName: String(level)) as? SKShapeNode
                levelNode.fillColor = levelColor[getIndex()]
                levelNode.path = path
                levelNode.physicsBody?.affectedByGravity = false
            }
        }
        
        
        if getIndex() == level {
            if subLevel + 1 <= 9 {
                for level in (subLevel + 1)...9 {
                   
                    levelNode = childNode(withName: String(level)) as? SKShapeNode
                    levelNode.fillColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
                    levelNode.path = path
                    levelNode.physicsBody?.affectedByGravity = false
                }
            }
        }
     
        
        let toMenu: SKShapeNode!
        let toMenuPath = CGMutablePath()
        toMenu = childNode(withName: "toMenu") as? SKShapeNode
        toMenuPath.addRoundedRect(in: CGRect(origin: CGPoint(x: -50, y: -25), size: CGSize(width: 100, height: 50)),
                                  cornerWidth: 20,
                                  cornerHeight: 20)
        toMenu.fillColor = #colorLiteral(red: 0.8856651187, green: 0.6520748734, blue: 0.9267773032, alpha: 1)
        toMenu.path = toMenuPath
        
        var toNext : SKShapeNode? = nil
        let toNextPath = CGMutablePath()
        toNext = childNode(withName: "toNext") as? SKShapeNode
        toNextPath.addArc(center: CGPoint.zero, radius: 25, startAngle: 0, endAngle: CGFloat.pi * 2, clockwise: true)
        toNext?.fillColor = #colorLiteral(red: 0.9411764741, green: 0.4980392158, blue: 0.3529411852, alpha: 1)
        toNext?.path = toNextPath
        
        var toPrev: SKShapeNode? = nil
        let toPrevPath = CGMutablePath()
        toPrev = childNode(withName: "toPrev") as? SKShapeNode
        toPrevPath.addArc(center: CGPoint.zero, radius: 25, startAngle: 0, endAngle: CGFloat.pi * 2, clockwise: true)
        toPrev?.fillColor = #colorLiteral(red: 0.9411764741, green: 0.4980392158, blue: 0.3529411852, alpha: 1)
        toPrev?.path = toPrevPath
        
        
    }
    
    
    
    func ChangeScene(subLevel: Int) {
        let noteChallangeScene = NoteChallengeScene(fileNamed: "NoteLevelScene.sks")!
        noteChallangeScene.scaleMode = .aspectFill
        noteChallangeScene.subLevel = subLevel
        noteChallangeScene.level = getIndex()
        
        super.view?.presentScene(noteChallangeScene, transition: SKTransition.push(with: SKTransitionDirection.up, duration: 0.5))
    }
    
    private func toMenu() {
        let menuScene = MenuScene(fileNamed: "MenuScene.sks")!
        menuScene.scaleMode = .aspectFill
        super.view?.presentScene(menuScene, transition: SKTransition.push(with: SKTransitionDirection.down, duration: 0.5))
    }
    
    func toNext() {
        let currentSceneIndex = levelScenes.index(of: name!)
        let fileName = levelScenes[currentSceneIndex! + 1] + ".sks"
        let nextScene = NoteLevelScene(fileNamed: fileName)
        nextScene?.scaleMode = .aspectFill
        super.view?.presentScene(nextScene!, transition: SKTransition.push(with: SKTransitionDirection.left, duration: 0.25))
    }
    
    func toPrev() {
        let currentSceneIndex = levelScenes.index(of: name!)
        let fileName = levelScenes[currentSceneIndex! - 1] + ".sks"
        let prevScene = NoteLevelScene(fileNamed: fileName)
        prevScene?.scaleMode = .aspectFill
        super.view?.presentScene(prevScene!, transition: SKTransition.push(with: SKTransitionDirection.right, duration: 0.25))
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
