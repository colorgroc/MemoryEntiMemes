//
//  GameViewController.swift
//  MemoryEntiMemes
//
//  Created by Anna Ponce Llerda on 07/03/2019.
//  Copyright © 2019 cat.enti. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit
import FirebaseAnalytics

class GameViewController: UIViewController, MenuSceneDelegate, ResultSceneDelegate, AboutSceneDelegate, PlayMenuSceneDelegate, GameSceneDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        Analytics.logEvent("app_start", parameters:[:])
        
        if let view = self.view as! SKView? {
            // Load the SKScene from 'GameScene.sks'
            let scene = MenuScene(size: view.frame.size)
            scene.menuDelegate = self
            // Set the scale mode to scale to fit the window
            scene.scaleMode = .aspectFill
            
            // Present the scene
            view.presentScene(scene)
            
        }
    }
    
    func goToAbout(sender: MenuScene) {
        if let view = self.view as? SKView {
            let scene = AboutScene(size: view.frame.size)
            scene.aboutDelegate = self
            // Set the scale mode to scale to fit the window
            scene.scaleMode = .aspectFill
            
            // Present the scene
            view.presentScene(scene, transition: .crossFade(withDuration: 0.2))
        }
    }
    
    func goToGameSelector(sender: MenuScene) {
        if let view = self.view as? SKView {
            let scene = PlayMenuScene(size: view.frame.size)
            scene.playMenuDelegate = self
            // Set the scale mode to scale to fit the window
            scene.scaleMode = .aspectFill
            
            // Present the scene
            view.presentScene(scene, transition: .crossFade(withDuration: 0.2))
        }
    }
    
    func goToResult(sender: GameScene, won: Bool, scoreGot: Int, timeGot: String) {
        if let view = self.view as? SKView {
            let scene = ResultScene(size: view.frame.size)
            scene.timeGot = timeGot
            scene.won = won
            scene.scoreGot = scoreGot
            scene.resultDelegate = self
            // Set the scale mode to scale to fit the window
            scene.scaleMode = .aspectFill
            
            // Present the scene
            view.presentScene(scene, transition: .crossFade(withDuration: 0.2))
        }
    }
    func goToGame(sender: PlayMenuScene, level: Levels) {
        if let view = self.view as? SKView {
            let scene = GameScene(size: view.frame.size)
            scene.level = level
            scene.gameSceneDelegate = self
            // Set the scale mode to scale to fit the window
            scene.scaleMode = .aspectFill
            
            // Present the scene
            view.presentScene(scene, transition: .crossFade(withDuration: 0.2))
        }
    }
    
    func back(sender: ResultScene) {
        if let view = self.view as? SKView {
            let scene = PlayMenuScene(size: view.frame.size)
            scene.playMenuDelegate = self
            // Set the scale mode to scale to fit the window
            scene.scaleMode = .aspectFill
            
            // Present the scene
            view.presentScene(scene, transition: .crossFade(withDuration: 0.2))
        }
    }
    
    func back(sender: AboutScene) {
        if let view = self.view as? SKView {
            let scene = MenuScene(size: view.frame.size)
            scene.menuDelegate = self
            // Set the scale mode to scale to fit the window
            scene.scaleMode = .aspectFill
            
            // Present the scene
            view.presentScene(scene, transition: .crossFade(withDuration: 0.2))
        }
    }
    func back(sender: PlayMenuScene) {
        if let view = self.view as? SKView {
            let scene = MenuScene(size: view.frame.size)
            scene.menuDelegate = self
            // Set the scale mode to scale to fit the window
            scene.scaleMode = .aspectFill
            
            // Present the scene
            view.presentScene(scene, transition: .crossFade(withDuration: 0.2))
        }
    }
    
    func back(sender: GameScene) {
        if let view = self.view as? SKView {
            let scene = PlayMenuScene(size: view.frame.size)
            scene.playMenuDelegate = self
            // Set the scale mode to scale to fit the window
            scene.scaleMode = .aspectFill
            
            // Present the scene
            view.presentScene(scene, transition: .crossFade(withDuration: 0.2))
        }
    }
    
    override var shouldAutorotate: Bool {
        return false //true
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
}
