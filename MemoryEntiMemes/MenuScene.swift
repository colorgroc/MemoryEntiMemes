//
//  MenuScene.swift
//  MemoryEntiMemes
//
//  Created by Anna Ponce Llerda on 14/03/2019.
//  Copyright © 2019 cat.enti. All rights reserved.
//

import SpriteKit
import GameplayKit

protocol MenuSceneDelegate: class {
    func goToGameSelector(sender: MenuScene)
    func goToAbout(sender: MenuScene)
}


class MenuScene: SKScene, ButtonDelegate, ImageButtonDelegate {

    static let widthButton_MainMenu: CGFloat = 150
    static let heightButton_MainMenu: CGFloat = 50
    
    var playButton: Button?
    //var settingsButton: Button?
    var aboutButton: Button?
    var soundButton = ImageButton(imageNamed: "audio_on")
    
    weak var menuDelegate: MenuSceneDelegate?
    
    private var label : SKLabelNode?
    private var spinnyNode : SKShapeNode?
    
    override func didMove(to view: SKView) {
        
        Audio.shared.PLAY()
        
        playButton = Button(rect: CGRect(x: 0, y:0, width: MenuScene.widthButton_MainMenu * 1.1, height: MenuScene.heightButton_MainMenu*1.1), cornerRadius:30)
        aboutButton = Button(rect: CGRect(x: 0, y:0, width: MenuScene.widthButton_MainMenu, height: MenuScene.heightButton_MainMenu), cornerRadius:30)
        self.backgroundColor = SKColor(named: "lightGray")!
        
        //play
        if let playButton = playButton{
        
            playButton.fillColor = SKColor(named: "BotonPlay")!//.darkGray //SKColor(named: "nombre")
            //playButton.alpha = 0.5
            playButton.strokeColor = .darkGray
            playButton.setText(text: NSLocalizedString("Play", comment: ""))
            playButton.isUserInteractionEnabled = true
            playButton.delegate = self
            playButton.position = CGPoint(x: view.frame.width / 2.0 - (MenuScene.widthButton_MainMenu*1.1 / 2.0), y: view.frame.height*0.35)
            addChild(playButton)
        }
        
            soundButton.isUserInteractionEnabled = true
            soundButton.delegate = self
            soundButton.setScale(1.5)
            soundButton.position = CGPoint(x: view.frame.width * 0.9, y: view.frame.height * 0.95)
            addChild(soundButton)
        
        //about
        if let aboutButton = aboutButton{
            aboutButton.fillColor = SKColor(named: "BotonOption")!//.gray
            aboutButton.strokeColor = .lightGray
            aboutButton.setText(text: NSLocalizedString("About", comment: ""))
            aboutButton.isUserInteractionEnabled = true
            aboutButton.delegate = self
            aboutButton.position = CGPoint(x: view.frame.width / 2.0 - MenuScene.widthButton_MainMenu / 2.0, y: playButton!.position.y - (MenuScene.heightButton_MainMenu + 20))
            addChild(aboutButton)
        }
        //logo enti
        let logo = SKSpriteNode(imageNamed: "enti-png-2")
        logo.position = CGPoint(x: view.frame.width * 0.25, y: view.frame.height * 0.03)
        addChild(logo)
        logo.setScale(0.3)
        
        //huge image
        let gameImage = SKSpriteNode(imageNamed: "Logo_Enti")
        gameImage.position = CGPoint(x: view.frame.width / 2.0, y: view.frame.height/2.0 + playButton!.position.y/1.7)
        gameImage.setScale(1.8)
        addChild(gameImage)
        
        //Mementi
        /*self.label = SKLabelNode(text: "MEMENTI")
        if let label = self.label {
            
            label.fontName = "ArialRoundedMTBold"
            label.fontColor = .black
            label.position = CGPoint(x: view.frame.width / 2.0, y: gameImage.position.y + 100)
            addChild(label)

        }*/
   
    }
    
    func touchDown(atPoint pos : CGPoint) {

    }
    
    func touchMoved(toPoint pos : CGPoint) {

    }
    
    func touchUp(atPoint pos : CGPoint) {

    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchDown(atPoint: t.location(in: self)) }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchMoved(toPoint: t.location(in: self)) }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    func onTap(sender: Button) {
        if sender == playButton{
            if let menuDelegate = self.menuDelegate {
                menuDelegate.goToGameSelector(sender: self)
            }
            //print("playButton")
        }
        else if sender == aboutButton{
            if let menuDelegate = self.menuDelegate {
                menuDelegate.goToAbout(sender: self)
            }
            //print("aboutButton")
        }
        //print("estoy tocando un boton")
    }
    func onTap(sender: ImageButton) {
        if sender == soundButton{
            print("sound")
            print("volumen: " + String(Audio.shared.volumenOn))
            
            if Audio.shared.volumenOn {
                sender.setImage(newImage: "audio_mute")
                Audio.shared.volumenOn = false
                Audio.shared.OFF()
            }
            else if !Audio.shared.volumenOn{
                Audio.shared.volumenOn = true
                Audio.shared.ON()
                sender.setImage(newImage: "audio_on")
            }
            
        }
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
}
