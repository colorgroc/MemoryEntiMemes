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

class PlayMenuScene: SKScene, ButtonDelegate, ImageButtonDelegate {
    
    static let buttonWidth: CGFloat = 150.0
    static let buttonHeight: CGFloat = 50.0
    
    weak var playMenuDelegate: PlayMenuSceneDelegate?
    
    private var label : SKLabelNode?
    
    var easyButton: Button?
    var mediumButton: Button?
    var hardButton: Button?
    var tableScoreTitle: String = NSLocalizedString("ScoreBoard", comment: "")
    var typeScore: String = NSLocalizedString("typeEasy", comment: "")
    var scoreTypeTitle: SKLabelNode?
    var bla: SKLabelNode?
    var counterTab: Int = 0
    //var
    //swipes
    var swipeRight = UISwipeGestureRecognizer()
    var swipeLeft = UISwipeGestureRecognizer()
    var swipeUp = UISwipeGestureRecognizer()
    var swipeDown = UISwipeGestureRecognizer()
    
    private var backButton = ImageButton(imageNamed: "back_50")
    //private var backButton = Button(rect: CGRect(x: 0, y: 0, width: buttonWidth, height: buttonHeight), cornerRadius: 10)
    var screenResBackH: CGFloat = 0.0
    var screenResBackW: CGFloat = 0.0
    
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
        
        //print("modelo: " + MenuScene.modelIdentifier())
        /*if MenuScene.modelIdentifier() == "iPhone11,8"{
            screenResBackW = 0.09
            screenResBackH = 0.92
        }*/
        //else {
            screenResBackW = 0.06
            screenResBackH = 0.95
        //}
        
        backButton.isUserInteractionEnabled = true
        backButton.delegate = self
        backButton.position = CGPoint(x: view.frame.width * screenResBackW, y: view.frame.height * screenResBackH)
        /*if MenuScene.modelIdentifier() == "iPhone11,8"{
            backButton.size = CGSize(width: backButton.size.width*1.2, height: backButton.size.height*1.2)
        }*/
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
            easyButton.setText(text: NSLocalizedString("Easy", comment: ""))
            easyButton.isUserInteractionEnabled = true
            easyButton.delegate = self
            easyButton.position = CGPoint(x: view.frame.width / 2.0 - (PlayMenuScene.buttonWidth / 2.0), y: view.frame.height*0.35)
            addChild(easyButton)
        }
        
        //Options
        if let mediumButon = mediumButton{
            mediumButon.fillColor = SKColor(named: "BotonPlay")!//.gray
            mediumButon.strokeColor = .darkGray
            mediumButon.setText(text: NSLocalizedString("Medium", comment: ""))
            mediumButon.isUserInteractionEnabled = true
            mediumButon.delegate = self
            mediumButon.position = CGPoint(x: view.frame.width/2.0 - PlayMenuScene.buttonWidth/2.0, y: easyButton!.position.y - (PlayMenuScene.buttonHeight + 20))
            addChild(mediumButon)
        }
        //about
        if let hardButtton = hardButton{
            hardButtton.fillColor = SKColor(named: "BotonPlay")!//.gray
            hardButtton.strokeColor = .darkGray
            hardButtton.setText(text: NSLocalizedString("Hard", comment: ""))
            hardButtton.isUserInteractionEnabled = true
            hardButtton.delegate = self
            hardButtton.position = CGPoint(x: view.frame.width / 2.0 - PlayMenuScene.buttonWidth / 2.0, y: mediumButton!.position.y - (PlayMenuScene.buttonHeight + 20))
            addChild(hardButtton)
        }
        
        
        self.label = SKLabelNode(text: tableScoreTitle)
        if let label = self.label {
            
            label.fontName = "ArialRoundedMTBold"
            label.fontSize = 20
            label.fontColor = .black
            label.position = CGPoint(x: view.frame.width / 2.0, y: view.frame.height * 0.85)
            addChild(label)
            
        }
       /* self.label = SKLabelNode(text: scoreTypeTitle)
        if let label = self.label {
            
            label.fontName = "ArialRoundedMTBold"
            label.fontColor = .white
            label.fontSize = 17
            label.position = CGPoint(x: view.frame.width / 2.0, y: view.frame.height * 0.8)
            addChild(label)
            
        }*/
        self.scoreTypeTitle = SKLabelNode(text: typeScore)
        if let label = self.scoreTypeTitle{
            label.fontName = "ArialRoundedMTBold"
            label.fontColor = .white
            label.fontSize = 17
            label.position = CGPoint(x: view.frame.width / 2.0, y: view.frame.height * 0.8)
            addChild(label)
        }
        self.bla = SKLabelNode(text: "newScore")
        if let label = self.bla{
            label.fontName = "ArialRoundedMTBold"
            label.fontColor = .gray
            label.fontSize = 17
            label.position = CGPoint(x: view.frame.width / 2.0, y: scoreTypeTitle!.position.y - view.frame.height * 0.03)
            addChild(label)
        }
        
    }
    
    func onTap(sender: Button) {
        /*if sender == backButton {
            playMenuDelegate?.back(sender: self)
        }*/
         if sender == easyButton{
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
    func onTap(sender: ImageButton) {
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
        counterTab -= 1
        if counterTab <= 0{
            counterTab = 0
        }
        if counterTab == 0{
            self.scoreTypeTitle?.text = NSLocalizedString("typeEasy", comment: "")
        }
        else if counterTab == 1 {
            self.scoreTypeTitle?.text = NSLocalizedString("typeMedium", comment: "")
        }
        print(counterTab)
    }
    @objc func SwipeLeft(sender: UISwipeGestureRecognizer){
        print("swipeLeft")
        counterTab += 1
        if counterTab >= 2{
            counterTab = 2
        }
        if counterTab == 1 {
            self.scoreTypeTitle?.text = NSLocalizedString("typeMedium", comment: "")
        }
        else if counterTab == 2 {
            self.scoreTypeTitle?.text = NSLocalizedString("typeHard", comment: "")
        }
        
        print(counterTab)
    }
    @objc func SwipeUp(sender: UISwipeGestureRecognizer){
        print("swipeUp")
    }
    @objc func SwipeDown(sender: UISwipeGestureRecognizer){
        print("swipeDown")
    }
    
}
