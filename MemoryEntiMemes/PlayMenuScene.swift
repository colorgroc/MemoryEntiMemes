//
//  PlayMenuScene.swift
//  MemoryEntiMemes
//
//  Created by Anna Ponce Llerda on 15/03/2019.
//  Copyright © 2019 cat.enti. All rights reserved.
//

import SpriteKit
//import UIKit

protocol PlayMenuSceneDelegate: class {
    func back(sender: PlayMenuScene)
}

class PlayMenuScene: SKScene, ButtonDelegate {
    
    static let buttonWidth: CGFloat = 200.0
    static let buttonHeight: CGFloat = 50.0
    
    weak var playMenuDelegate: PlayMenuSceneDelegate?
    
    private var label : SKLabelNode?
    
    var playButton: Button?
    var settingsButton: Button?
    var aboutButton: Button?
    
    //swipes
    var swipeRight = UISwipeGestureRecognizer()
    var swipeLeft = UISwipeGestureRecognizer()
    var swipeUp = UISwipeGestureRecognizer()
    var swipeDown = UISwipeGestureRecognizer()
    
    private var backButton = Button(rect: CGRect(x: 0, y: 0, width: buttonWidth, height: buttonHeight), cornerRadius: 10)
    
    //entrar escena
    override func didMove(to view: SKView) {
        //swipes
        swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(SwipeRight(sender:)))
        swipeRight.direction = .right
        view.addGestureRecognizer(swipeRight)
        
        swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(SwipeLeft(sender:)))
        swipeLeft.direction = .left
        view.addGestureRecognizer(swipeLeft)
        
        swipeUp = UISwipeGestureRecognizer(target: self, action: #selector(SwipeUp(sender:)))
        swipeUp.direction = .up
        view.addGestureRecognizer(swipeUp)
        
        swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(SwipeDown(sender:)))
        swipeDown.direction = .down
        view.addGestureRecognizer(swipeDown)
        
       /* backButton.setText(text: "BACK")
        backButton.fillColor = .red
        backButton.isUserInteractionEnabled = true
        backButton.delegate = self
        backButton.position = CGPoint(x: (view.frame.width / 2.0) - (PlayMenuScene.buttonWidth / 2.0), y: 100)
        addChild(backButton)*/
        
        playButton = Button(rect: CGRect(x: 0, y:0, width: MenuScene.widthButton_MainMenu * 1.1, height: MenuScene.heightButton_MainMenu*1.1), cornerRadius:30)
        settingsButton = Button(rect: CGRect(x: 0, y:0, width: MenuScene.widthButton_MainMenu, height: MenuScene.heightButton_MainMenu), cornerRadius:30)
        
        aboutButton = Button(rect: CGRect(x: 0, y:0, width: MenuScene.widthButton_MainMenu, height: MenuScene.heightButton_MainMenu), cornerRadius:30)
        self.backgroundColor = SKColor(named: "ENTI")! //el ! es per saber si existeix o no. No sap si existeix o no
        //play
        if let playButton = playButton{
            playButton.fillColor = SKColor(named: "BotonPlay")!//.darkGray //SKColor(named: "nombre")
            //playButton.alpha = 0.5
            playButton.strokeColor = .darkGray
            playButton.setText(text: "Easy")
            playButton.isUserInteractionEnabled = true
            playButton.delegate = self
            playButton.position = CGPoint(x: view.frame.width / 2.0 - (MenuScene.widthButton_MainMenu*1.1 / 2.0), y: view.frame.height*0.35)
            addChild(playButton)
        }
        
        //Options
        if let settingsButton = settingsButton{
            settingsButton.fillColor = SKColor(named: "BotonOption")!//.gray
            settingsButton.strokeColor = .white
            settingsButton.setText(text: "Medium")
            settingsButton.isUserInteractionEnabled = true
            settingsButton.delegate = self
            settingsButton.position = CGPoint(x: view.frame.width/2.0 - MenuScene.widthButton_MainMenu/2.0, y: playButton!.position.y - (MenuScene.heightButton_MainMenu + 20))
            addChild(settingsButton)
        }
        //about
        if let aboutButton = aboutButton{
            aboutButton.fillColor = SKColor(named: "BotonOption")!//.gray
            aboutButton.strokeColor = .white
            aboutButton.setText(text: "Hard")
            aboutButton.isUserInteractionEnabled = true
            aboutButton.delegate = self
            aboutButton.position = CGPoint(x: view.frame.width / 2.0 - MenuScene.widthButton_MainMenu / 2.0, y: settingsButton!.position.y - (MenuScene.heightButton_MainMenu + 20))
            addChild(aboutButton)
        }
        
        /*let logo = SKSpriteNode(imageNamed: "logo_enti")
        logo.position = view.center
        addChild(logo)
        
        // Get label node from scene and store it for use later
        self.label = SKLabelNode(text: "Hello, World")
        if let label = self.label {
            addChild(label)
            label.color = .white
            label.position = logo.position.applying(CGAffineTransform(translationX: 0, y: -100))
            label.alpha = 0.0
            label.run(SKAction.fadeIn(withDuration: 2.0))
        }*/
    }
    
    func onTap(sender: Button) {
        if sender == backButton {
            playMenuDelegate?.back(sender: self)
        }
    }
    
    //salir escena
    override func willMove(from view: SKView){
        view.removeGestureRecognizer(swipeRight)
        view.removeGestureRecognizer(swipeLeft)
        view.removeGestureRecognizer(swipeUp)
         view.removeGestureRecognizer(swipeDown)
    }
    
    @objc func SwipeRight(sender: UISwipeGestureRecognizer){
        print("swipeRight")
    }
    @objc func SwipeLeft(sender: UISwipeGestureRecognizer){
        print("swipeLeft")
    }
    @objc func SwipeUp(sender: UISwipeGestureRecognizer){
        print("swipeUp")
    }
    @objc func SwipeDown(sender: UISwipeGestureRecognizer){
        print("swipeDown")
    }
    
}
