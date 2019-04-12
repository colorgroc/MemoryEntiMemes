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
    static let cardSizeMedium: CGFloat = 70.0
    static let cardSizeHard: CGFloat = 65.0
    
    weak var gameSceneDelegate: GameSceneDelegate?
    var selected:Bool = false

    private var backButton = ImageButton(imageNamed: "back_50")
    var level = Levels.easy
    var gL: GameLogic?
    var cartaSeleccionada:CardSprite?
    var cardsTextures = [CardSprite]()
    
    override func didMove(to view: SKView) {
        self.backgroundColor = SKColor(named: "ENTI")!
        //cartaSeleccionada = CardSprite()
        gL = GameLogic()
        gL?.level = level
        gL?.reset()
        if(gL?.level == Levels.easy){
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
                        if gL!.DidWin(){
                            //cambiar escena
                        }
                }
            }
        }
        else if(gL?.level == Levels.medium){
            print("medium")
            if let count = gL?.cards.count{
                for i in 0..<count{
                    let card = CardSprite(imageNamed: gL!.cards[i].textureBackName)
                    card.SetTextures(front: gL!.cards[i].textureFrontName, back: gL!.cards[i].textureBackName)
                    card.size = CGSize(width: GameScene.cardSizeMedium, height: GameScene.cardSizeMedium)
                    card.isUserInteractionEnabled = true
                    card.delegate = self
                    card.ID = gL!.cards[i].cardID
                    cardsTextures.append(card);
                    addChild(card)
                    CardsPositions()
                    if gL!.DidWin(){
                        //cambiar escena
                    }
                }
            }
        }
        else if(gL?.level == Levels.hard){
            print("hard")
            if let count = gL?.cards.count{
                for i in 0..<count{
                    let card = CardSprite(imageNamed: gL!.cards[i].textureBackName)
                    card.SetTextures(front: gL!.cards[i].textureFrontName, back: gL!.cards[i].textureBackName)
                    card.size = CGSize(width: GameScene.cardSizeHard, height: GameScene.cardSizeHard)
                    card.isUserInteractionEnabled = true
                    card.delegate = self
                    card.ID = gL!.cards[i].cardID
                    cardsTextures.append(card);
                    addChild(card)
                    CardsPositions()
                    if gL!.DidWin(){
                        //cambiar escena
                    }
                }
            }
        }
        
    
        backButton.isUserInteractionEnabled = true
        backButton.delegate = self
        backButton.position = CGPoint(x: 20, y: view.frame.height - 20)
        addChild(backButton)
        
    }
    
    func CardsPositions()->Void{
        for i in 0..<cardsTextures.count{
            if gL?.level  == Levels.easy{
                let numCol = 3
                let separationWidth: CGFloat = view!.frame.width/12
                let initialSeparationWidth: CGFloat = view!.frame.width/12
                let separationHeight: CGFloat = view!.frame.height/4
                let separationBelow: CGFloat = view!.frame.height/18
                if i < numCol {
                    if i == 0{
                        cardsTextures[i].position = CGPoint(x: GameScene.cardSizeEasy - initialSeparationWidth, y: view!.frame.height - separationHeight)
                    }
                    else{
                        cardsTextures[i].position = CGPoint(x: cardsTextures[i - 1].position.x + GameScene.cardSizeEasy + separationWidth, y: view!.frame.height - separationHeight)
                    }
                }
                else if i < numCol*2{
                    if(i == numCol){
                        cardsTextures[i].position = CGPoint(x: cardsTextures[0].position.x, y: cardsTextures[0].position.y - GameScene.cardSizeEasy - separationBelow)
                    }
                    else{
                        cardsTextures[i].position = CGPoint(x: cardsTextures[i - 1].position.x + GameScene.cardSizeEasy + separationWidth, y: cardsTextures[i-1].position.y)
                    }
                }
                else if i < numCol*3{
                    if(i == numCol*2){
                        cardsTextures[i].position = CGPoint(x: cardsTextures[0].position.x, y: cardsTextures[numCol].position.y - GameScene.cardSizeEasy - separationBelow)
                    }
                    else{
                        cardsTextures[i].position = CGPoint(x: cardsTextures[i - 1].position.x + GameScene.cardSizeEasy + separationWidth, y: cardsTextures[i-1].position.y)
                    }
                }
                else if i  < numCol*4{
                    if(i == numCol*3){
                        cardsTextures[i].position = CGPoint(x: cardsTextures[0].position.x, y: cardsTextures[numCol*2].position.y - GameScene.cardSizeEasy - separationBelow)
                    }
                    else{
                        cardsTextures[i].position = CGPoint(x: cardsTextures[i - 1].position.x + GameScene.cardSizeEasy + separationWidth, y: cardsTextures[i-1].position.y)
                    }
                }
            }
            else if gL?.level  == Levels.medium{
                let numCol = 4
                let separationWidth: CGFloat = view!.frame.width/28
                let initialSeparationWidth: CGFloat = view!.frame.width/10
                let separationHeight: CGFloat = view!.frame.height/4
                let separationBelow: CGFloat = view!.frame.height/30
                if i < numCol {
                    if i == 0{
                        cardsTextures[i].position = CGPoint(x: GameScene.cardSizeMedium - initialSeparationWidth, y: view!.frame.height - separationHeight)
                    }
                    else{
                        cardsTextures[i].position = CGPoint(x: cardsTextures[i - 1].position.x + GameScene.cardSizeMedium + separationWidth, y: view!.frame.height - separationHeight)
                    }
                }
                else if i < numCol*2{
                    if(i == numCol){
                        cardsTextures[i].position = CGPoint(x: cardsTextures[0].position.x, y: cardsTextures[0].position.y - GameScene.cardSizeMedium - separationBelow)
                    }
                    else{
                        cardsTextures[i].position = CGPoint(x: cardsTextures[i - 1].position.x + GameScene.cardSizeMedium + separationWidth, y: cardsTextures[i-1].position.y)
                    }
                }
                else if i < numCol*3{
                    if(i == numCol*2){
                        cardsTextures[i].position = CGPoint(x: cardsTextures[0].position.x, y: cardsTextures[numCol].position.y - GameScene.cardSizeMedium - separationBelow)
                    }
                    else{
                        cardsTextures[i].position = CGPoint(x: cardsTextures[i - 1].position.x + GameScene.cardSizeMedium + separationWidth, y: cardsTextures[i-1].position.y)
                    }
                }
                else if i  < numCol*4{
                    if(i == numCol*3){
                        cardsTextures[i].position = CGPoint(x: cardsTextures[0].position.x, y: cardsTextures[numCol*2].position.y - GameScene.cardSizeMedium - separationBelow)
                    }
                    else{
                        cardsTextures[i].position = CGPoint(x: cardsTextures[i - 1].position.x + GameScene.cardSizeMedium + separationWidth, y: cardsTextures[i-1].position.y)
                    }
                }
                else if i  < numCol*5{
                    if(i == numCol*4){
                        cardsTextures[i].position = CGPoint(x: cardsTextures[0].position.x, y: cardsTextures[numCol*3].position.y - GameScene.cardSizeMedium - separationBelow)
                    }
                    else{
                        cardsTextures[i].position = CGPoint(x: cardsTextures[i - 1].position.x + GameScene.cardSizeMedium + separationWidth, y: cardsTextures[i-1].position.y)
                    }
                }
                else if i  < numCol*6{
                    if(i == numCol*5){
                        cardsTextures[i].position = CGPoint(x: cardsTextures[0].position.x, y: cardsTextures[numCol*4].position.y - GameScene.cardSizeMedium - separationBelow)
                    }
                    else{
                        cardsTextures[i].position = CGPoint(x: cardsTextures[i - 1].position.x + GameScene.cardSizeMedium + separationWidth, y: cardsTextures[i-1].position.y)
                    }
                }
            }
            else if gL?.level  == Levels.hard{
                let numCol = 4
                let separationWidth: CGFloat = view!.frame.width/50
                let initialSeparationWidth: CGFloat = view!.frame.width/20
                let separationHeight: CGFloat = view!.frame.height/5
                let separationBelow: CGFloat = view!.frame.height/36
                let separationDivider: CGFloat = 6
                if i < numCol {
                    if i == 0{
                        cardsTextures[i].position = CGPoint(x: GameScene.cardSizeHard - initialSeparationWidth, y: view!.frame.height - separationHeight)
                    }
                    else{
                        cardsTextures[i].position = CGPoint(x: cardsTextures[i - 1].position.x + GameScene.cardSizeHard + separationWidth, y: view!.frame.height - separationHeight)
                    }
                }
                else if i < numCol*2{
                    if(i == numCol){
                        cardsTextures[i].position = CGPoint(x: cardsTextures[0].position.x, y: cardsTextures[0].position.y - GameScene.cardSizeHard - separationBelow/separationDivider)
                    }
                    else{
                        cardsTextures[i].position = CGPoint(x: cardsTextures[i - 1].position.x + GameScene.cardSizeHard + separationWidth, y: cardsTextures[i-1].position.y)
                    }
                }
                else if i < numCol*3{
                    if(i == numCol*2){
                        cardsTextures[i].position = CGPoint(x: cardsTextures[0].position.x, y: cardsTextures[numCol].position.y - GameScene.cardSizeHard - separationBelow/separationDivider)
                    }
                    else{
                        cardsTextures[i].position = CGPoint(x: cardsTextures[i - 1].position.x + GameScene.cardSizeHard + separationWidth, y: cardsTextures[i-1].position.y)
                    }
                }
                else if i  < numCol*4{
                    if(i == numCol*3){
                        cardsTextures[i].position = CGPoint(x: cardsTextures[0].position.x, y: cardsTextures[numCol*2].position.y - GameScene.cardSizeHard - separationBelow/separationDivider)
                    }
                    else{
                        cardsTextures[i].position = CGPoint(x: cardsTextures[i - 1].position.x + GameScene.cardSizeHard + separationWidth, y: cardsTextures[i-1].position.y)
                    }
                }
                else if i  < numCol*5{
                    if(i == numCol*4){
                        cardsTextures[i].position = CGPoint(x: cardsTextures[0].position.x, y: cardsTextures[numCol*3].position.y - GameScene.cardSizeHard - separationBelow/separationDivider)
                    }
                    else{
                        cardsTextures[i].position = CGPoint(x: cardsTextures[i - 1].position.x + GameScene.cardSizeHard + separationWidth, y: cardsTextures[i-1].position.y)
                    }
                }
                else if i  < numCol*6{
                    if(i == numCol*5){
                        cardsTextures[i].position = CGPoint(x: cardsTextures[0].position.x, y: cardsTextures[numCol*4].position.y - GameScene.cardSizeHard - separationBelow/separationDivider)
                    }
                    else{
                        cardsTextures[i].position = CGPoint(x: cardsTextures[i - 1].position.x + GameScene.cardSizeHard + separationWidth, y: cardsTextures[i-1].position.y)
                    }
                }
                else if i  < numCol*7{
                    if(i == numCol*6){
                        cardsTextures[i].position = CGPoint(x: cardsTextures[0].position.x, y: cardsTextures[numCol*5].position.y - GameScene.cardSizeHard - separationBelow/separationDivider)
                    }
                    else{
                        cardsTextures[i].position = CGPoint(x: cardsTextures[i - 1].position.x + GameScene.cardSizeHard + separationWidth, y: cardsTextures[i-1].position.y)
                    }
                }
            }
        }
        
    }
    
    func onTap(sender: ImageButton) {
        if sender == backButton {
            gameSceneDelegate?.back(sender: self)
        }
    }
    func onTap(sender: CardSprite) {
        
        //if(sender.texture == SKSpriteNode(imageNamed: sender.textureBack).texture){
        
        var tempID:Int = 0
        if sender.ID >= level.rawValue / 2{
            tempID = sender.ID - level.rawValue / 2
        }
        else {
            tempID = sender.ID
        }
        print(tempID)
        if gL!.cards[tempID].state != Card.Estado.emparejada.rawValue{
            
            func Swipe(){
                if selected == false{
                    selected = true
                    gL!.IDSelected = tempID
                    gL!.cards[gL!.IDSelected].state = Card.Estado.destapada.rawValue
                    cartaSeleccionada = sender
                }
                else {
                    if tempID == gL!.IDSelected {
                        gL!.cards[tempID].state = Card.Estado.destapada.rawValue
                        gL!.cards[tempID].state = Card.Estado.emparejada.rawValue
                        gL!.cards[gL!.IDSelected].state = Card.Estado.emparejada.rawValue
                        print("match")
                        gL!.matches += 1
                        selected = false
                        sender.texture = SKSpriteNode(imageNamed: sender.textureFront).texture
                    }
                    else{
                        print("no match")
                        selected = false
                        gL!.cards[gL!.IDSelected].state = Card.Estado.tapada.rawValue
                        gL!.cards[tempID].state = Card.Estado.tapada.rawValue
                        cartaSeleccionada!.texture = SKSpriteNode(imageNamed: cartaSeleccionada!.textureBack).texture
                        sender.texture = SKSpriteNode(imageNamed: sender.textureBack).texture
                        //gL!.cards[IDSelected].state = Card.Estado.emparejada.rawValue
                        
                    }
                }
            }
            sender.run(Actions(sender: sender, type: ActionsEnum.backToFront.rawValue), completion: Swipe)
        }
        
    }
    func Actions(sender: CardSprite, type: Int)->SKAction{
        let changeTextureActionFront = SKAction.setTexture(SKTexture(imageNamed: sender.textureFront))
        let changeTextureActionBack = SKAction.setTexture(SKTexture(imageNamed: sender.textureBack))
        let tempSizeX = sender.xScale
        let tempSize = sender.size
        let scaleSmallX = SKAction.scaleX(to: 0, duration: 0.3)
        let scaleBigX = SKAction.scaleX(to: tempSizeX, duration: 0.3)
        let scaleSmall = SKAction.scale(to: tempSize, duration: 0.3)
        let scaleBig = SKAction.scale(by: 0.3, duration: 0.3)
        let wait = SKAction.wait(forDuration: 0.7)

        let sequence: SKAction
        if type == ActionsEnum.backToFront.rawValue{
            sequence = SKAction.sequence([scaleSmallX, changeTextureActionFront, scaleBigX, wait])
        }
        else if type == ActionsEnum.FrontToBack.rawValue{
            sequence = SKAction.sequence([scaleSmallX, changeTextureActionBack, scaleBigX])
        }
        else {
            sequence = SKAction.sequence([scaleBig, wait, scaleSmall])
        }
        return sequence
    }
    
}

