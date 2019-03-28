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

class AboutScene: SKScene, ButtonDelegate {
    
    static let buttonWidth: CGFloat = 200.0
    static let buttonHeight: CGFloat = 50.0
    
    weak var aboutDelegate: AboutSceneDelegate?
    
    private var label : SKLabelNode?
    
    private var backButton = Button(rect: CGRect(x: 0, y: 0, width: buttonWidth, height: buttonHeight), cornerRadius: 10)
    
    override func didMove(to view: SKView) {
        
        backButton.setText(text: "BACK")
        backButton.fillColor = .red
        backButton.isUserInteractionEnabled = true
        backButton.delegate = self
        backButton.position = CGPoint(x: (view.frame.width / 2.0) - (AboutScene.buttonWidth / 2.0), y: 100)
        addChild(backButton)
        
        let logo = SKSpriteNode(imageNamed: "logo_enti")
        logo.position = view.center
        addChild(logo)
        
        // Get label node from scene and store it for use later
        self.label = SKLabelNode(text: "Hello, World")
        if let label = self.label {
            addChild(label)
            label.color = .red
            label.position = logo.position.applying(CGAffineTransform(translationX: 0, y: -100))
            label.alpha = 0.0
            label.run(SKAction.fadeIn(withDuration: 2.0))
        }
    }
    
    func onTap(sender: Button) {
        if sender == backButton {
            aboutDelegate?.back(sender: self)
        }
    }
    
}
