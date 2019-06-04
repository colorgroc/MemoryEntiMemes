//
//  AboutScene.swift
//  MemoryEntiMemes
//
//  Created by Anna Ponce Llerda on 14/03/2019.
//  Copyright © 2019 cat.enti. All rights reserved.
//

import SpriteKit

protocol AboutSceneDelegate: class {
    func back(sender: AboutScene)
}

class AboutScene: SKScene, ImageButtonDelegate {
    
    static let buttonWidth: CGFloat = 200.0
    static let buttonHeight: CGFloat = 50.0
    var screenResBackH: CGFloat = 0.0
    var screenResBackW: CGFloat = 0.0
    weak var aboutDelegate: AboutSceneDelegate?
    private var anna : SKLabelNode?
    private var enti : SKLabelNode?
    private var label : SKLabelNode?
    private var backButton = ImageButton(imageNamed: "back_50")
    
    //private var backButton = Button(rect: CGRect(x: 0, y: 0, width: buttonWidth, height: buttonHeight), cornerRadius: 10)
    
    override func didMove(to view: SKView) {
        
        screenResBackW = 0.06
        screenResBackH = 0.95
        self.backgroundColor = SKColor(named: "lightGray")!
        
        backButton.isUserInteractionEnabled = true
        backButton.delegate = self
        backButton.position = CGPoint(x: view.frame.width * screenResBackW, y: view.frame.height * screenResBackH)
        addChild(backButton)
        //logo enti
        let logo = SKSpriteNode(imageNamed: "enti-png-2")
        logo.position = CGPoint(x: view.frame.width * 0.25, y: view.frame.height * 0.03)
        addChild(logo)
        logo.setScale(0.3)
        // Get label node from scene and store it for use later
        self.anna = SKLabelNode(text: "Anna Ponce")
        if let label = self.anna {
            addChild(label)
            label.fontColor = .darkGray
            label.position = CGPoint(x: view.frame.width/2, y: view.frame.height/2)
            label.alpha = 0.0
            label.run(SKAction.fadeIn(withDuration: 2.0))
        }
        self.enti = SKLabelNode(text: "Programació de jocs per a mobils")
        if let label = self.enti {
            addChild(label)
            label.fontColor = .darkGray
            label.position = anna!.position.applying(CGAffineTransform(translationX: 0, y: -20))
            label.alpha = 0.0
            label.fontSize = 15
            label.run(SKAction.fadeIn(withDuration: 3.0))
        }
        self.label = SKLabelNode(text: "Made by")
        if let label = self.label {
            addChild(label)
            label.fontColor = .black
            label.fontSize = 15
            label.position = anna!.position.applying(CGAffineTransform(translationX: 0, y: +50))
            //label.alpha = 0.0
            //label.run(SKAction.fadeIn(withDuration: 1.0))
        }
    }
    
    func onTap(sender: ImageButton) {
        if sender == backButton {
            aboutDelegate?.back(sender: self)
        }
    }
    
}
