//
//  SettingsScene.swift
//  MemoryEntiMemes
//
//  Created by Anna Ponce Llerda on 14/03/2019.
//  Copyright © 2019 cat.enti. All rights reserved.
//

import SpriteKit

protocol ResultSceneDelegate: class {
    func back(sender: ResultScene)
}

class ResultScene: SKScene, ImageButtonDelegate {
    
    static let buttonWidth: CGFloat = 200.0
    static let buttonHeight: CGFloat = 50.0
    var screenResBackH: CGFloat = 0.0
    var screenResBackW: CGFloat = 0.0
    weak var resultDelegate: ResultSceneDelegate?
    private var score : SKLabelNode?
    private var scorePoints_string : SKLabelNode?
    private var time_string : SKLabelNode?
    private var time : SKLabelNode?
    private var result : SKLabelNode?
    private var points : String = NSLocalizedString("YourScore", comment: "")
    private var timeDone : String = NSLocalizedString("TimeDone", comment: "")
    private var backButton = ImageButton(imageNamed: "back_50")
    private var congratulations: String = NSLocalizedString("Congratulations", comment: "")
    private var lost: String = NSLocalizedString("Lost", comment: "")
    var scoreGot: Int = 0
    var timeGot: String = "00:00"
    var won: Bool = false
    
    
    override func didMove(to view: SKView) {
    
        screenResBackW = 0.06
        screenResBackH = 0.95
        
        self.backgroundColor = SKColor(named: "lightGray")!
        
        FirebaseService().ReadScore(level: "Easy", completion: { scores in
            PlayMenuScene.easyScores = scores
        })
        FirebaseService().ReadScore(level: "Medium", completion: { scores in
            PlayMenuScene.mediumScores = scores
        })
        FirebaseService().ReadScore(level: "Hard", completion: { scores in
            PlayMenuScene.hardScores = scores
        })
        
        
        //logo enti
        let logo = SKSpriteNode(imageNamed: "enti-png-2")
        logo.position = CGPoint(x: view.frame.width * 0.25, y: view.frame.height * 0.03)
        addChild(logo)
        logo.setScale(0.3)
        
        if won == true{
            self.result = SKLabelNode(text: congratulations + "!")
            if let label = self.result {
                label.fontColor = SKColor(named: "BotonPlay")
                label.position = CGPoint(x: view.frame.width/2, y: view.frame.height/1.5)
                label.fontSize = 40
                addChild(label)
            }
            
            Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(Loop), userInfo: nil, repeats: true)
            
            self.score = SKLabelNode(text: points + ":")
            if let label = self.score {
                label.fontColor = .darkGray
                label.fontSize = 20
                label.position = result!.position.applying(CGAffineTransform(translationX: -70, y: -70))
                addChild(label)
                label.alpha = 0.0
                label.run(SKAction.fadeIn(withDuration: 1.0))
            }
            
            self.scorePoints_string = SKLabelNode(text: String(scoreGot))
            if let label = self.scorePoints_string {
                label.fontColor = SKColor(named: "Blue")
                label.position = score!.position.applying(CGAffineTransform(translationX: 0, y: -35))
                label.fontSize = 30
                label.alpha = 0.0
                addChild(label)
                label.run(SKAction.fadeIn(withDuration: 1.0))
            }
            
            self.time = SKLabelNode(text: timeDone + ":")
            if let label = self.time {
                label.fontSize = 20
                label.fontColor = .darkGray
                label.position = result!.position.applying(CGAffineTransform(translationX: 70, y: -70))
                addChild(label)
                label.alpha = 0.0
                
                label.run(SKAction.fadeIn(withDuration: 1.0))
            }
            
            self.time_string = SKLabelNode(text: timeGot)
            if let label = self.time_string {
                label.fontColor = .darkGray
                label.position = time!.position.applying(CGAffineTransform(translationX: 0, y: -35))
                label.fontSize = 30
                addChild(label)
                label.alpha = 0.0
                label.run(SKAction.fadeIn(withDuration: 1.0))
            }
        }
        else{
            self.result = SKLabelNode(text: lost + "...")
            if let label = self.result {
                addChild(label)
                label.fontColor = .darkGray
                label.position = CGPoint(x: view.frame.width/2, y: view.frame.height/2)
                label.alpha = 0.0
                label.run(SKAction.fadeIn(withDuration: 1.0))
            }
        }
        
        //back
        backButton.isUserInteractionEnabled = true
        backButton.delegate = self
        backButton.position = CGPoint(x: view.frame.width * screenResBackW, y: view.frame.height * screenResBackH)
        if won && time_string!.alpha == 1{
            backButton.alpha = 0.0
            backButton.run(SKAction.fadeIn(withDuration: 1.0))
        }
        addChild(backButton)
    }

    @objc func Loop(){
        let scaleBig = SKAction.scale(by: 1.1, duration: 0.5)
        let scaleSmall = SKAction.scale(to: 1, duration: 0.5)
        result!.run(SKAction.sequence([scaleBig, scaleSmall]))
        scorePoints_string!.run(SKAction.sequence([scaleBig, scaleSmall]))
    }
    
    func onTap(sender: ImageButton) {
        if sender == backButton {
            resultDelegate?.back(sender: self)
        }
    }
    
}

