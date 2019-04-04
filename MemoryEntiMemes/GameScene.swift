//
//  GameScene.swift
//  MemoryEntiMemes
//
//  Created by Anna Ponce Llerda on 22/03/2019.
//  Copyright © 2019 cat.enti. All rights reserved.
//

import SpriteKit

protocol GameSceneDelegate: class {
    func back(sender: GameScene)
}

class GameScene: SKScene, ButtonDelegate {
    
    static let buttonWidth: CGFloat = 200.0
    static let buttonHeight: CGFloat = 50.0
    static let cardSizeEasy: CGFloat = 80.0
    
    weak var gameSceneDelegate: GameSceneDelegate?
    
    //private var label : SKLabelNode?
    
    private var backButton = Button(rect: CGRect(x: 0, y: 0, width: buttonWidth, height: buttonHeight), cornerRadius: 10)
    
    var level = Levels.easy
    var gL: GameLogic?
    //var separation: CGFloat?
    //var xPos: CGFloat = 0
    var cardsTextures = [CardSprite]()
    override func didMove(to view: SKView) {

        gL = GameLogic()
        gL?.reset()
        if(level == Levels.easy){
            print("easy")
            //separation = 5
            if let count = gL?.cards.count{
                 //print(count)
            for i in 0..<count{
                if let textName = gL?.cards[i].textureFrontName{
                let card = CardSprite(imageNamed: textName)
                    card.size = CGSize(width: GameScene.cardSizeEasy, height: GameScene.cardSizeEasy) // poner variable size en easy
                    cardsTextures.append(card);
                    addChild(card)
                    CardsPositions()
                    //xPos = xPos + separation
                }
            }
            }
        }
        else if(level == Levels.medium){
            print("medium")
            //separation = 3
        }
        else if(level == Levels.hard){
            print("hard")
            //separation = 1
        }
        
        
        
        backButton.setText(text: "BACK")
        backButton.fillColor = .red
        backButton.isUserInteractionEnabled = true
        backButton.delegate = self
        backButton.position = CGPoint(x: (view.frame.width / 2.0) - (GameScene.buttonWidth / 2.0), y: 100)
        addChild(backButton)
        
        /*let logo = SKSpriteNode(imageNamed: "logo_enti")
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
        }*/
    }
    
    func CardsPositions()->Void{
        for i in 0..<cardsTextures.count{
            if level == Levels.easy{
                let numCol = 3
                let separation: CGFloat = 25
                if i < numCol {
                    if i == 0{
                        cardsTextures[i].position = CGPoint(x: GameScene.cardSizeEasy - separation, y: view!.frame.height - 50)
                    }
                    else{
                        cardsTextures[i].position = CGPoint(x: cardsTextures[i - 1].position.x + GameScene.cardSizeEasy + separation, y: view!.frame.height - 50)
                    }
                }
                else if i < numCol*2{
                    if(i == numCol){
                        cardsTextures[i].position = CGPoint(x: cardsTextures[0].position.x, y: cardsTextures[0].position.y - GameScene.cardSizeEasy - 50)
                    }
                    else{
                        cardsTextures[i].position = CGPoint(x: cardsTextures[i - 1].position.x + GameScene.cardSizeEasy + separation, y: cardsTextures[i-1].position.y)
                    }
                }
            }
        }
        
    }
    
    
    func onTap(sender: Button) {
        if sender == backButton {
            gameSceneDelegate?.back(sender: self)
        }
    }
    
}

