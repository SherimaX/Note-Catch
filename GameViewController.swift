//
//  GameViewController.swift
//  Chip Catch
//
//  Created by Andy Li on 2/22/19.
//  Copyright © 2019 Andy Li. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit
class GameViewController: UIViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        
        if let view = self.view as! SKView? {
            
            let menuScene = MenuScene(fileNamed: "MenuScene.sks")!
            
                menuScene.scaleMode = .aspectFill
            
                view.presentScene(menuScene)
            
            NotificationCenter.default.addObserver(self, selector: #selector(pauseGameScene), name: Notification.Name("PauseGameScene"), object: nil)
            NotificationCenter.default.addObserver(self, selector: #selector(resumeGameScene), name: Notification.Name("ResumeGameScene"), object: nil)
            view.ignoresSiblingOrder = true
            
//            view.showsFPS = true
//            view.showsNodeCount = true
        }
    }
    
    
    @objc private func pauseGameScene() {
        if let view = self.view as! SKView? {
            view.scene?.isPaused = true
        }
            
    }
    
    @objc private func resumeGameScene() {
        if let view = self.view as! SKView? {
            view.scene?.isPaused = false
        }
    }
}
