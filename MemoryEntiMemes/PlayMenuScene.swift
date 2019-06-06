//
//  PlayMenuScene.swift
//  MemoryEntiMemes
//
//  Created by Anna Ponce Llerda on 15/03/2019.
//  Copyright © 2019 cat.enti. All rights reserved.
//

import SpriteKit
import FirebaseAnalytics
//import UIKit

protocol PlayMenuSceneDelegate: class {
    func back(sender: PlayMenuScene)
    func goToGame(sender: PlayMenuScene, level: Levels)
}

class PlayMenuScene: SKScene, ButtonDelegate, ImageButtonDelegate {
    
    static let buttonWidth: CGFloat = 150.0
    static let buttonHeight: CGFloat = 50.0
    
    weak var playMenuDelegate: PlayMenuSceneDelegate?
    
    private var tableScoreLabel : SKLabelNode?
    
    static var easyScores = [Int]()
    static var mediumScores = [Int]()
    static var hardScores = [Int]()
    
    var easyButton: Button?
    var mediumButton: Button?
    var hardButton: Button?
    var tableScoreTitle: String = NSLocalizedString("ScoreBoard", comment: "")
    var typeScore: String = NSLocalizedString("typeEasy", comment: "")
    var scoreTypeTitle: SKLabelNode?
    var goldScore: SKLabelNode?
    var silverScore: SKLabelNode?
    var bronzeScore: SKLabelNode?
    //var scoreGold: String = ""
    var counterTab: Int = 0
    //var
    //swipes
    var swipeRight = UISwipeGestureRecognizer()
    var swipeLeft = UISwipeGestureRecognizer()
    var swipeUp = UISwipeGestureRecognizer()
    var swipeDown = UISwipeGestureRecognizer()
    var pageControl: SKSpriteNode?
    var backButton = ImageButton(imageNamed: "back_50")
    let goldAward = SKSpriteNode(imageNamed: "gold")
    let silverAward = SKSpriteNode(imageNamed: "silver")
    let bronzeAward = SKSpriteNode(imageNamed: "bronze")
    var screenResBackH: CGFloat = 0.95
    var screenResBackW: CGFloat = 0.06
    
    static var bestEasyPoints:Int = 0
    static var bestMediumPoints:Int = 0
    static var bestHardPoints:Int = 0
    
    //entrar escena
    override func didMove(to view: SKView) {
 
        Prefs.loadEasyPoints()
        Prefs.loadMediumPoints()
        Prefs.loadHardPoints()
        
        //swipes
        swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(SwipeRight(sender:)))
        swipeRight.direction = .right
        view.addGestureRecognizer(swipeRight)
        
        swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(SwipeLeft(sender:)))
         swipeLeft.direction = .left
        view.addGestureRecognizer(swipeLeft)
        
        backButton.isUserInteractionEnabled = true
        backButton.delegate = self
        backButton.position = CGPoint(x: view.frame.width * screenResBackW, y: view.frame.height * screenResBackH)
        addChild(backButton)
        
        easyButton = Button(rect: CGRect(x: 0, y:0, width: PlayMenuScene.buttonWidth, height: PlayMenuScene.buttonHeight), cornerRadius:30)
        mediumButton = Button(rect: CGRect(x: 0, y:0, width: PlayMenuScene.buttonWidth, height: PlayMenuScene.buttonHeight), cornerRadius:30)
        
        hardButton = Button(rect: CGRect(x: 0, y:0, width: PlayMenuScene.buttonWidth, height: PlayMenuScene.buttonHeight), cornerRadius:30)
        
        self.backgroundColor = SKColor(named: "lightGray")! //el ! es per saber si existeix o no. No sap si existeix o no
        
        //page control
        pageControl = SKSpriteNode(imageNamed: "1_Page")
        pageControl!.position = CGPoint(x: view.frame.width/2, y: (easyButton!.position.y + easyButton!.frame.height) + view.frame.height * 0.37)
        addChild(pageControl!)
        pageControl!.setScale(0.18)
 
        //easy
        if let easyButton = easyButton{
            easyButton.fillColor = SKColor(named: "lightGray_2")!//.darkGray //SKColor(named: "nombre")
            //playButton.alpha = 0.5
            easyButton.strokeColor = SKColor(named: "BotonOption")!
            //easyButton.setText(text: NSLocalizedString("Easy", comment: ""))
            easyButton.setText(text: NSLocalizedString("Easy", comment: ""), color: SKColor(named: "BotonPlay")!)
            easyButton.isUserInteractionEnabled = true
            easyButton.delegate = self
            easyButton.position = CGPoint(x: view.frame.width / 2.0 - (PlayMenuScene.buttonWidth / 2.0), y: view.frame.height*0.35)
            addChild(easyButton)
        }
        
        //medium
        if let mediumButon = mediumButton{
            mediumButon.fillColor = SKColor(named: "lightGray_2")!//.gray
            mediumButon.strokeColor = SKColor(named: "BotonOption")!
            mediumButon.setText(text: NSLocalizedString("Medium", comment: ""), color: SKColor(named: "BotonPlay")!)
            mediumButon.isUserInteractionEnabled = true
            mediumButon.delegate = self
            mediumButon.position = CGPoint(x: view.frame.width/2.0 - PlayMenuScene.buttonWidth/2.0, y: easyButton!.position.y - (PlayMenuScene.buttonHeight + 20))
            addChild(mediumButon)
        }
        //hard
        if let hardButtton = hardButton{
            hardButtton.fillColor = SKColor(named: "lightGray_2")!//.gray
            hardButtton.strokeColor = SKColor(named: "BotonOption")!
            hardButtton.setText(text: NSLocalizedString("Hard", comment: ""), color: SKColor(named: "BotonPlay")!)
            hardButtton.isUserInteractionEnabled = true
            hardButtton.delegate = self
            hardButtton.position = CGPoint(x: view.frame.width / 2.0 - PlayMenuScene.buttonWidth / 2.0, y: mediumButton!.position.y - (PlayMenuScene.buttonHeight + 20))
            addChild(hardButtton)
        }
   
        self.tableScoreLabel = SKLabelNode(text: tableScoreTitle)
        if let label = self.tableScoreLabel {
            
            label.fontName = "HelveticaNeue-Light"
            label.fontSize = 30
            label.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.center
            label.verticalAlignmentMode = SKLabelVerticalAlignmentMode.center
            label.fontColor = SKColor(named: "BotonPlay")!
            label.position = CGPoint(x: view.frame.width / 2.0, y: view.frame.height * 0.87)
            addChild(label)
        }
 
        self.scoreTypeTitle = SKLabelNode(text: typeScore)
        if let label = self.scoreTypeTitle{
            label.fontName = "HelveticaNeue-Light"
            label.fontColor = .gray//SKColor(named: "ENTI")!
            label.fontSize = 20
            label.position = CGPoint(x: view.frame.width / 2.0, y: tableScoreLabel!.position.y - view.frame.height * 0.08)
            addChild(label)
        }

        goldAward.position = CGPoint(x: view.frame.width / 2.5, y: scoreTypeTitle!.position.y - view.frame.height * 0.085)
        goldAward.setScale(1.5)
        addChild(goldAward)
        
        self.goldScore = SKLabelNode(text: "")
        if let label = self.goldScore{
            label.fontName = "HelveticaNeue-Light"
            label.fontColor = SKColor(named: "BotonPlay")!
            label.fontSize = 35
            label.position = CGPoint(x: goldAward.position.x + view.frame.width * 0.2, y: scoreTypeTitle!.position.y - view.frame.height * 0.11)
            addChild(label)
        }
        
        silverAward.position = CGPoint(x: view.frame.width / 2.5, y: goldAward.position.y - view.frame.height * 0.09)
        silverAward.setScale(1.3)
        addChild(silverAward)
        
        self.silverScore = SKLabelNode(text: "")
        if let label = self.silverScore{
            label.fontName = "HelveticaNeue-Light"
            label.fontColor = SKColor(named: "BotonPlay")!
            label.fontSize = 27
            label.position = CGPoint(x: silverAward.position.x + view.frame.width * 0.2, y: goldScore!.position.y - view.frame.height * 0.085)
            addChild(label)
        }
        
        bronzeAward.position = CGPoint(x: view.frame.width / 2.5, y: silverAward.position.y - view.frame.height * 0.08)
        bronzeAward.setScale(1)
        addChild(bronzeAward)
        
        self.bronzeScore = SKLabelNode(text: "")
        if let label = self.bronzeScore{
            label.fontName = "HelveticaNeue-Light"
            label.fontColor = SKColor(named: "BotonPlay")!
            label.fontSize = 25
            label.position = CGPoint(x: bronzeAward.position.x + view.frame.width * 0.2, y: silverScore!.position.y - view.frame.height * 0.08)
            addChild(label)
        }
    }
    
    override func update(_ currentTime: TimeInterval){
        FirebaseService().ReadScore(level: "Easy", completion: { scores in
            PlayMenuScene.easyScores = scores
        })
        FirebaseService().ReadScore(level: "Medium", completion: { scores in
            PlayMenuScene.mediumScores = scores
        })
        FirebaseService().ReadScore(level: "Hard", completion: { scores in
            PlayMenuScene.hardScores = scores
        })

        if(PlayMenuScene.easyScores.count >= 3 && PlayMenuScene.mediumScores.count >= 3 && PlayMenuScene.hardScores.count >= 3){
            if self.counterTab == 0{
                self.scoreTypeTitle?.text = NSLocalizedString("typeEasy", comment: "")
                pageControl!.run(SKAction.setTexture(SKTexture(imageNamed: "1_Page")))
                self.goldScore?.text = String(PlayMenuScene.easyScores[0])
                self.silverScore?.text = String(PlayMenuScene.easyScores[1])
                self.bronzeScore?.text = String(PlayMenuScene.easyScores[2])
            }
            else if self.counterTab == 1{
                self.scoreTypeTitle?.text = NSLocalizedString("typeMedium", comment: "")
                pageControl!.run(SKAction.setTexture(SKTexture(imageNamed: "2_Page")))
                self.goldScore?.text = String(PlayMenuScene.mediumScores[0])
                self.silverScore?.text = String(PlayMenuScene.mediumScores[1])
                self.bronzeScore?.text = String(PlayMenuScene.mediumScores[2])
            }
            else if self.counterTab == 2{
                self.scoreTypeTitle?.text = NSLocalizedString("typeHard", comment: "")
                pageControl!.run(SKAction.setTexture(SKTexture(imageNamed: "3_Page")))
                self.goldScore?.text = String(PlayMenuScene.hardScores[0])
                self.silverScore?.text = String(PlayMenuScene.hardScores[1])
                self.bronzeScore?.text = String(PlayMenuScene.hardScores[2])
            }
        }
    }
    
    func onTap(sender: Button) {
         if sender == easyButton{
            if let playMenuDelegate = self.playMenuDelegate {
                Analytics.logEvent("easy_Game", parameters:[:])
                playMenuDelegate.goToGame(sender: self, level: Levels.easy)
            }
        }else if sender == mediumButton{
            if let playMenuDelegate = self.playMenuDelegate {
                Analytics.logEvent("medium_Game", parameters:[:])
                playMenuDelegate.goToGame(sender: self, level: Levels.medium)
            }
        }else if sender == hardButton{
            if let playMenuDelegate = self.playMenuDelegate {
                Analytics.logEvent("hard_Game", parameters:[:])
                playMenuDelegate.goToGame(sender: self, level: Levels.hard)
            }
        }
        //Audio.shared.PLAY_PRESSED()
    }
    func onTap(sender: ImageButton) {
        if sender == backButton {
            playMenuDelegate?.back(sender: self)
        }
        //Audio.shared.PLAY_PRESSED()
    }
    
    //salir escena
    override func willMove(from view: SKView){
        view.removeGestureRecognizer(swipeRight)
        view.removeGestureRecognizer(swipeLeft)
        view.removeGestureRecognizer(swipeUp)
        view.removeGestureRecognizer(swipeDown)
    }
    
    @objc func SwipeRight(sender: UISwipeGestureRecognizer){
        counterTab -= 1
        if counterTab <= 0{
            counterTab = 0
        }
    }
    @objc func SwipeLeft(sender: UISwipeGestureRecognizer){
        counterTab += 1
        if counterTab >= 2{
            counterTab = 2
        }
    }
}
