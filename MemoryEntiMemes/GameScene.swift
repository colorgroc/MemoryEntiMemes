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

class GameScene: SKScene, ImageButtonDelegate, CardDelegate {
    
    static let buttonWidth: CGFloat = 200.0
    static let buttonHeight: CGFloat = 50.0
    static let cardSizeEasy: CGFloat = 80.0
    
    weak var gameSceneDelegate: GameSceneDelegate?
    var selected:Bool = false
    //private var label : SKLabelNode?
    
    //private var backButton = Button(rect: CGRect(x: 0, y: 0, width: buttonWidth, height: buttonHeight), cornerRadius: 10)
    private var backButton = ImageButton(imageNamed: "back_50")
    var level = Levels.easy
    var gL: GameLogic?
    var IDSelected:Int = 0
    //var separation: CGFloat?
    //var xPos: CGFloat = 0
    var cardsTextures = [CardSprite]()
    override func didMove(to view: SKView) {
        self.backgroundColor = SKColor(named: "ENTI")!
        gL = GameLogic()
        gL?.reset()
        if(level == Levels.easy){
            print("easy")
            //separation = 5
            if let count = gL?.cards.count{
                 //print(count)
            for i in 0..<count{
                //if let textNameBack = gL?.cards[i].textureBackName{
                let card = CardSprite(imageNamed: gL!.cards[i].textureBackName)
                    card.SetTextures(front: gL!.cards[i].textureFrontName, back: gL!.cards[i].textureBackName)
                    card.size = CGSize(width: GameScene.cardSizeEasy, height: GameScene.cardSizeEasy) // poner variable size en easy
                    card.isUserInteractionEnabled = true
                    card.delegate = self
                    card.ID = gL!.cards[i].cardID
                    //ID = i
                    cardsTextures.append(card);
                    addChild(card)
                    CardsPositions()
                    //xPos = xPos + separation
                //}
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
        
    
        backButton.isUserInteractionEnabled = true
        backButton.delegate = self
        backButton.position = CGPoint(x: 20, y: view.frame.height - 20)
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
                        cardsTextures[i].position = CGPoint(x: GameScene.cardSizeEasy - separation, y: view!.frame.height - 150)
                    }
                    else{
                        cardsTextures[i].position = CGPoint(x: cardsTextures[i - 1].position.x + GameScene.cardSizeEasy + separation, y: view!.frame.height - 150)
                    }
                }
                else if i < numCol*2{
                    if(i == numCol){
                        cardsTextures[i].position = CGPoint(x: cardsTextures[0].position.x, y: cardsTextures[0].position.y - GameScene.cardSizeEasy - 30)
                    }
                    else{
                        cardsTextures[i].position = CGPoint(x: cardsTextures[i - 1].position.x + GameScene.cardSizeEasy + separation, y: cardsTextures[i-1].position.y)
                    }
                }
                else if i < numCol*3{
                    if(i == numCol*2){
                        cardsTextures[i].position = CGPoint(x: cardsTextures[0].position.x, y: cardsTextures[numCol].position.y - GameScene.cardSizeEasy - 30)
                    }
                    else{
                        cardsTextures[i].position = CGPoint(x: cardsTextures[i - 1].position.x + GameScene.cardSizeEasy + separation, y: cardsTextures[i-1].position.y)
                    }
                }
                else if i  < numCol*4{
                    if(i == numCol*3){
                        cardsTextures[i].position = CGPoint(x: cardsTextures[0].position.x, y: cardsTextures[numCol*2].position.y - GameScene.cardSizeEasy - 30)
                    }
                    else{
                        cardsTextures[i].position = CGPoint(x: cardsTextures[i - 1].position.x + GameScene.cardSizeEasy + separation, y: cardsTextures[i-1].position.y)
                    }
                }
            }
        }
        
    }
    
    
    /*func onTap(sender: Button) {
        if sender == backButton {
            gameSceneDelegate?.back(sender: self)
        }
    }*/
    func onTap(sender: ImageButton) {
        if sender == backButton {
            gameSceneDelegate?.back(sender: self)
        }
    }
    func onTap(sender: CardSprite) {
        sender.texture = SKSpriteNode(imageNamed: sender.textureFront).texture
        if selected == false{
            print(sender.ID)
            selected = true
            IDSelected = sender.ID

        }
        else {
            if sender.ID - level.rawValue == IDSelected || sender.ID + level.rawValue == IDSelected {
                print("match")
                selected = false
            }
            else{
                sender.texture = SKSpriteNode(imageNamed: sender.textureBack).texture
                print("no match")
                selected = false
            }
        }
    
        
    }
    
}

