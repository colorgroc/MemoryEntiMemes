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

class GameViewController: UIViewController, MenuSceneDelegate, SettingsSceneDelegate, AboutSceneDelegate, PlayMenuSceneDelegate {
 

    override func viewDidLoad() {
        super.viewDidLoad()
        
        /*let swipeRight = UISwipeGestureRecognizer(target: self , action: #selector(PlayMenuScene.HandleSwipe(sender:)))
        swipeRight.direction = .right
        
        let swipeLeft = UISwipeGestureRecognizer(target: self , action: #selector(PlayMenuScene.HandleSwipe(sender:)))
        swipeLeft.direction = .left
        
        let swipeUp = UISwipeGestureRecognizer(target: self , action: #selector(PlayMenuScene.HandleSwipe(sender:)))
        swipeUp.direction = .up
        
        let swipeDown = UISwipeGestureRecognizer(target: self , action: #selector(PlayMenuScene.HandleSwipe(sender:)))
        swipeLeft.direction = .down
        
        view.addGestureRecognizer(swipeRight)
        view.addGestureRecognizer(swipeLeft)
        view.addGestureRecognizer(swipeUp)
        view.addGestureRecognizer(swipeDown)*/
        
        
        if let view = self.view as! SKView? {
            // Load the SKScene from 'GameScene.sks'
            let scene = MenuScene(size: view.frame.size)
            scene.menuDelegate = self
            // Set the scale mode to scale to fit the window
            scene.scaleMode = .aspectFill
            
            // Present the scene
            view.presentScene(scene)
            
            view.showsFPS = true
            view.showsNodeCount = true
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
    
    func goToGame(sender: MenuScene) {
        if let view = self.view as? SKView {
            let scene = PlayMenuScene(size: view.frame.size)
            scene.playMenuDelegate = self
            // Set the scale mode to scale to fit the window
            scene.scaleMode = .aspectFill
            
            // Present the scene
            view.presentScene(scene, transition: .crossFade(withDuration: 0.2))
        }
    }
    
    func goToSettings(sender: MenuScene) {
        if let view = self.view as? SKView {
            let scene = SettingsScene(size: view.frame.size)
            scene.settingsDelegate = self
            // Set the scale mode to scale to fit the window
            scene.scaleMode = .aspectFill
            
            // Present the scene
            view.presentScene(scene, transition: .crossFade(withDuration: 0.2))
        }
    }
    
    func back(sender: SettingsScene) {
        if let view = self.view as? SKView {
            let scene = MenuScene(size: view.frame.size)
            scene.menuDelegate = self
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
    
    override var shouldAutorotate: Bool {
        return true
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
