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
    func goToSettings(sender: MenuScene)
}


class MenuScene: SKScene, ButtonDelegate {
    
    
    static let widthButton_MainMenu: CGFloat = 150
    static let heightButton_MainMenu: CGFloat = 50
    
    var playButton: Button?
    var settingsButton: Button?
    var aboutButton: Button?
    
    weak var menuDelegate: MenuSceneDelegate?
    
    private var label : SKLabelNode?
    private var spinnyNode : SKShapeNode?
    
    override func didMove(to view: SKView) {
        playButton = Button(rect: CGRect(x: 0, y:0, width: MenuScene.widthButton_MainMenu * 1.1, height: MenuScene.heightButton_MainMenu*1.1), cornerRadius:30)
        settingsButton = Button(rect: CGRect(x: 0, y:0, width: MenuScene.widthButton_MainMenu, height: MenuScene.heightButton_MainMenu), cornerRadius:30)
        
        aboutButton = Button(rect: CGRect(x: 0, y:0, width: MenuScene.widthButton_MainMenu, height: MenuScene.heightButton_MainMenu), cornerRadius:30)
        self.backgroundColor = SKColor(named: "ENTI")! //el ! es per saber si existeix o no. No sap si existeix o no
        //play
        if let playButton = playButton{
            playButton.fillColor = SKColor(named: "BotonPlay")!//.darkGray //SKColor(named: "nombre")
            //playButton.alpha = 0.5
            playButton.strokeColor = .darkGray
            playButton.setText(text: "Play")
            playButton.isUserInteractionEnabled = true
            playButton.delegate = self
            playButton.position = CGPoint(x: view.frame.width / 2.0 - (MenuScene.widthButton_MainMenu*1.1 / 2.0), y: view.frame.height*0.35)
            addChild(playButton)
        }
        
        //Options
        if let settingsButton = settingsButton{
        settingsButton.fillColor = SKColor(named: "BotonOption")!//.gray
        settingsButton.strokeColor = .white
        settingsButton.setText(text: "Settings")
        settingsButton.isUserInteractionEnabled = true
        settingsButton.delegate = self
        settingsButton.position = CGPoint(x: view.frame.width/2.0 - MenuScene.widthButton_MainMenu/2.0, y: playButton!.position.y - (MenuScene.heightButton_MainMenu + 20))
        addChild(settingsButton)
        }
        //about
        if let aboutButton = aboutButton{
        aboutButton.fillColor = SKColor(named: "BotonOption")!//.gray
        aboutButton.strokeColor = .white
        aboutButton.setText(text: "About")
        aboutButton.isUserInteractionEnabled = true
        aboutButton.delegate = self
        aboutButton.position = CGPoint(x: view.frame.width / 2.0 - MenuScene.widthButton_MainMenu / 2.0, y: settingsButton!.position.y - (MenuScene.heightButton_MainMenu + 20))
        addChild(aboutButton)
        }
        //logo enti
        let logo = SKSpriteNode(imageNamed: "enti-png-2")
        logo.position = CGPoint(x: 75, y: 20)
        addChild(logo)
        logo.setScale(0.3)
        
        //trollface
        let troll = SKSpriteNode(imageNamed: "Radev")
        troll.position = CGPoint(x: view.frame.width / 2.0, y: view.frame.height/2.0 + playButton!.position.y/2.0)
        troll.setScale(0.5)
        addChild(troll)
        
        //Mementi
        self.label = SKLabelNode(text: "MEMENTI")
        if let label = self.label {
            
            label.fontName = "ArialRoundedMTBold"
            label.fontColor = .black
            label.position = CGPoint(x: view.frame.width / 2.0, y: troll.position.y + 100)
            addChild(label)

        }
        
        // Create shape node to use during mouse interaction
       /* let w = (self.size.width + self.size.height) * 0.1
        self.spinnyNode = SKShapeNode.init(rectOf: CGSize.init(width: w, height: w), cornerRadius: w * 0.3)
        
        if let spinnyNode = self.spinnyNode {
            spinnyNode.lineWidth = 2.5
            
            spinnyNode.run(SKAction.repeatForever(SKAction.rotate(byAngle: CGFloat(Double.pi), duration: 1)))
            spinnyNode.run(SKAction.sequence([SKAction.wait(forDuration: 0.5),
                                              SKAction.fadeOut(withDuration: 0.5),
                                              SKAction.removeFromParent()]))
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
            print("playButton")
        }else if sender == settingsButton{
            if let menuDelegate = self.menuDelegate {
                menuDelegate.goToSettings(sender: self)
            }
            print("settingsButton")
        }else if sender == aboutButton{
            if let menuDelegate = self.menuDelegate {
                menuDelegate.goToAbout(sender: self)
            }
            print("aboutButton")
        }
        //print("estoy tocando un boton")
    }
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
}
