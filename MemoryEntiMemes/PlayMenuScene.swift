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
    func goToGame(sender: PlayMenuScene, level: Levels)
}

class PlayMenuScene: SKScene, ButtonDelegate {
    
    static let buttonWidth: CGFloat = 150.0
    static let buttonHeight: CGFloat = 50.0
    
    weak var playMenuDelegate: PlayMenuSceneDelegate?
    
    private var label : SKLabelNode?
    
    var easyButton: Button?
    var mediumButton: Button?
    var hardButton: Button?
    
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
        
        backButton.setText(text: "BACK")
        backButton.fillColor = .red
        backButton.isUserInteractionEnabled = true
        backButton.delegate = self
        backButton.position = CGPoint(x: (view.frame.width / 2.0) - (PlayMenuScene.buttonWidth / 2.0), y: 100)
        addChild(backButton)
        
        easyButton = Button(rect: CGRect(x: 0, y:0, width: PlayMenuScene.buttonWidth, height: PlayMenuScene.buttonHeight), cornerRadius:30)
        mediumButton = Button(rect: CGRect(x: 0, y:0, width: PlayMenuScene.buttonWidth, height: PlayMenuScene.buttonHeight), cornerRadius:30)
        
        hardButton = Button(rect: CGRect(x: 0, y:0, width: PlayMenuScene.buttonWidth, height: PlayMenuScene.buttonHeight), cornerRadius:30)
        self.backgroundColor = SKColor(named: "ENTI")! //el ! es per saber si existeix o no. No sap si existeix o no
        //play
        if let easyButton = easyButton{
            easyButton.fillColor = SKColor(named: "BotonPlay")!//.darkGray //SKColor(named: "nombre")
            //playButton.alpha = 0.5
            easyButton.strokeColor = .darkGray
            easyButton.setText(text: "Easy")
            easyButton.isUserInteractionEnabled = true
            easyButton.delegate = self
            easyButton.position = CGPoint(x: view.frame.width / 2.0 - (PlayMenuScene.buttonWidth / 2.0), y: view.frame.height*0.35)
            addChild(easyButton)
        }
        
        //Options
        if let mediumButon = mediumButton{
            mediumButon.fillColor = SKColor(named: "BotonPlay")!//.gray
            mediumButon.strokeColor = .darkGray
            mediumButon.setText(text: "Medium")
            mediumButon.isUserInteractionEnabled = true
            mediumButon.delegate = self
            mediumButon.position = CGPoint(x: view.frame.width/2.0 - PlayMenuScene.buttonWidth/2.0, y: easyButton!.position.y - (PlayMenuScene.buttonHeight + 20))
            addChild(mediumButon)
        }
        //about
        if let hardButtton = hardButton{
            hardButtton.fillColor = SKColor(named: "BotonPlay")!//.gray
            hardButtton.strokeColor = .darkGray
            hardButtton.setText(text: "Hard")
            hardButtton.isUserInteractionEnabled = true
            hardButtton.delegate = self
            hardButtton.position = CGPoint(x: view.frame.width / 2.0 - PlayMenuScene.buttonWidth / 2.0, y: mediumButton!.position.y - (PlayMenuScene.buttonHeight + 20))
            addChild(hardButtton)
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
        else if sender == easyButton{
            if let playMenuDelegate = self.playMenuDelegate {
                playMenuDelegate.goToGame(sender: self, level: Levels.easy)
            }
            print("easyButton")
        }else if sender == mediumButton{
            if let playMenuDelegate = self.playMenuDelegate {
                playMenuDelegate.goToGame(sender: self, level: Levels.medium)
            }
            print("mediumButton")
        }else if sender == hardButton{
            if let playMenuDelegate = self.playMenuDelegate {
                playMenuDelegate.goToGame(sender: self, level: Levels.hard)
            }
            print("hardButton")
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
