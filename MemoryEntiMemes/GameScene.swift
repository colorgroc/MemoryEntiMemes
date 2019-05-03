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
    var cartaSeleccionada: CardSprite?
    var cardsTextures = [CardSprite]()
    
    override func didMove(to view: SKView) {
        self.backgroundColor = SKColor(named: "ENTI")!
        gL = GameLogic()
        gL?.cartaSeleccionada = cartaSeleccionada
        gL?.level = level
        gL?.reset()
        if(gL?.level == Levels.easy){
            print("easy")
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

        var tempID:Int = 0
        
        if sender.ID >= level.rawValue / 2{
            tempID = sender.ID - level.rawValue / 2
        }
        else {
            tempID = sender.ID
        }
        
        print("state: " + String(gL!.cards[sender.ID].state))
       
        if gL!.cards[sender.ID].state == Card.Estado.tapada.rawValue {//} && gL!.cards[tempID].state != Card.Estado.destapada.rawValue{
            //print("id: " + String(gL!.IDSelected) + " temp : " + String(tempID2))
            
            print("id: " + String(sender.ID) + " temp: " + String(tempID) + " sel: " + String(gL!.IDSelected))
            
            sender.SwipeCard(type: ActionsEnum.backToFront.rawValue)
            if sender.done{
                gL!.cards[sender.ID].state = Card.Estado.destapada.rawValue
                //sender.SetDoneFalse()
            }
            
                if gL!.IDSelected == -1{
                    gL!.IDSelected = tempID
                    //gL!.cards[sender.ID].state = Card.Estado.destapada.rawValue
                    cartaSeleccionada = sender
                    //gL!.cards[sender.ID].state = Card.Estado.destapada.rawValue
                }
                else {
                    if tempID == gL!.IDSelected{
                       // gL!.cards[sender.ID].state = Card.Estado.destapada.rawValue
                        //gL!.cards[tempID].state = Card.Estado.destapada.rawValue
                        
                        print("match")
                        gL!.matches += 1
                        //selected = false
                        //sender.SwipeCard(type: ActionsEnum.FrontToBack.rawValue)
                        //sender.texture = SKSpriteNode(imageNamed: sender.textureFront).texture
                       // if sender.done && cartaSeleccionada!.done{
                            gL!.cards[sender.ID].state = Card.Estado.emparejada.rawValue
                            gL!.cards[gL!.IDSelected].state = Card.Estado.emparejada.rawValue
                            sender.SetDoneFalse()
                            cartaSeleccionada?.SetDoneFalse()
                       // }
                        gL!.IDSelected = -1
                    }
                    else{
                        
                        print("no match")
                        //selected = false
                        //gL!.cards[sender.ID].state = Card.Estado.destapada.rawValue
                       // cartaSeleccionada!.texture = SKSpriteNode(imageNamed: cartaSeleccionada!.textureBack).texture
                        cartaSeleccionada!.SwipeCard(type: ActionsEnum.FrontToBack.rawValue)
                        sender.SwipeCard(type: ActionsEnum.FrontToBack.rawValue)
                        if sender.done && cartaSeleccionada!.done{
                            gL!.cards[sender.ID].state = Card.Estado.tapada.rawValue
                            gL!.cards[gL!.IDSelected].state = Card.Estado.tapada.rawValue
                            sender.SetDoneFalse()
                            cartaSeleccionada?.SetDoneFalse()
                        }
                        gL!.IDSelected = -1
                       // sender.texture = SKSpriteNode(imageNamed: sender.textureBack).texture
                        //gL!.cards[IDSelected].state = Card.Estado.emparejada.rawValue
                        
                }
            }
            //run(Actions(sender: sender, type: ActionsEnum.backToFront.rawValue), completion: Swipe)
        } /*else {
            gL!.cards[sender.ID].state = Card.Estado.tapada.rawValue
        }*/
        
    }
    func AllSwipe(){
       /* if start {
            //girar todas
        }
        else if tapar {
            
        }*/
    }
    
}

