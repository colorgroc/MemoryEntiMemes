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
    
    
    weak var gameSceneDelegate: GameSceneDelegate?
    var selected:Bool = false

    private var backButton = ImageButton(imageNamed: "back_50")
    var level = Levels.easy
    var gL: GameLogic?
    var cartaSeleccionada: CardSprite?
    var cardsTextures = [CardSprite]()
    var ScreenResW: CGFloat = 0.0
    var ScreenResH: CGFloat = 0.0
    var screenResBackH: CGFloat = 0.0
    var screenResBackW: CGFloat = 0.0
    
    /*static var cardSizeEasy: CGFloat = 80.0
    static var cardSizeMedium: CGFloat = 70.0
    static var cardSizeHard: CGFloat = 65.0*/
    
    var cardSizeEasy: CGFloat = 0
    var cardSizeMedium: CGFloat = 0
    var cardSizeHard: CGFloat = 0
    
    var numCol: Int = 0
    //var points: Int = 0
    //var bonus: Int = 0
    //var time: TimeInterval = 0
    var pointsScore: SKLabelNode?
    var pointsTitle: SKLabelNode?
    var timeLeft: SKLabelNode?
    var timeLeftTitle: SKLabelNode?
    var bonusText: SKLabelNode?
    var bonusTitle: SKLabelNode?
    var initiate:Bool = false
    var startTime:Bool = false
    //var timer: Timer?
    
    
    
    override func didMove(to view: SKView) {
        
        cardSizeEasy = view.frame.size.width * 0.22
        cardSizeMedium = view.frame.size.width * 0.21
        cardSizeHard = view.frame.size.width * 0.19
        
        //print("modelo: " + MenuScene.modelIdentifier())
       /* if MenuScene.modelIdentifier() == "iPhone11,8"{
            screenResBackW = 0.09
            screenResBackH = 0.92
            /*GameScene.cardSizeMedium = GameScene.cardSizeEasy
            GameScene.cardSizeHard = GameScene.cardSizeMedium*/
        }*/
        //else {
            screenResBackW = 0.06
            screenResBackH = 0.95
        //}
        
        
        
        self.backgroundColor = SKColor(named: "lightGray")!
        gL = GameLogic()
        //gL?.cartaSeleccionada //= cartaSeleccionada
        gL?.level = level
        gL?.reset()
        gL!.time = gL!.maxTime
        startTime = false
        if(gL?.level == Levels.easy){
            //print("easy")
            gL!.maxTime *= 3
            if let count = gL?.cards.count{
                 //print(count)
                for i in 0..<count{
                    //if let textNameBack = gL?.cards[i].textureBackName{
                    let card = CardSprite(imageNamed: gL!.cards[i].textureBackName)
                        card.SetTextures(front: gL!.cards[i].textureFrontName, back: gL!.cards[i].textureBackName)
                        card.size = CGSize(width: cardSizeEasy, height: cardSizeEasy) // poner variable size en easy
                        card.isUserInteractionEnabled = true
                        card.delegate = self
                        card.ID = gL!.cards[i].cardID
                        //ID = i
                        cardsTextures.append(card);
                        addChild(card)
                        CardsPositions()
                        AllSwipe()
                        //card.isUserInteractionEnabled = true
                }
            }
        }
        else if(gL?.level == Levels.medium){
            //print("medium")
            gL!.maxTime *= 5
            if let count = gL?.cards.count{
                for i in 0..<count{
                    let card = CardSprite(imageNamed: gL!.cards[i].textureBackName)
                    card.SetTextures(front: gL!.cards[i].textureFrontName, back: gL!.cards[i].textureBackName)
                    card.size = CGSize(width: cardSizeMedium, height: cardSizeMedium)
                    
                    card.delegate = self
                    card.ID = gL!.cards[i].cardID
                    cardsTextures.append(card);
                    addChild(card)
                    CardsPositions()
                    AllSwipe()
                    //card.isUserInteractionEnabled = true
                }
            }
        }
        else if(gL?.level == Levels.hard){
            //print("hard")
            gL!.maxTime *= 10
            if let count = gL?.cards.count{
                for i in 0..<count{
                    let card = CardSprite(imageNamed: gL!.cards[i].textureBackName)
                    card.SetTextures(front: gL!.cards[i].textureFrontName, back: gL!.cards[i].textureBackName)
                    card.size = CGSize(width: cardSizeHard, height: cardSizeHard)
                    card.delegate = self
                    card.ID = gL!.cards[i].cardID
                    cardsTextures.append(card);
                    addChild(card)
                    CardsPositions()
                    AllSwipe()
                    //card.isUserInteractionEnabled = true
                }
            }
        }
        
        
        backButton.isUserInteractionEnabled = true
        backButton.delegate = self
        backButton.position = CGPoint(x: view.frame.width * screenResBackW, y: view.frame.height * screenResBackH)
       /* if MenuScene.modelIdentifier() == "iPhone11,8"{
            backButton.size = CGSize(width: backButton.size.width*1.2, height: backButton.size.height*1.2)
        }*/
        addChild(backButton)
        
        self.pointsScore = SKLabelNode(text: String(gL!.points))
        if let label = self.pointsScore{
            label.fontName = "HelveticaNeue-Light"
            label.fontColor = SKColor(named: "BotonPlay")
            label.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.right
            label.fontSize = 17
            label.position = CGPoint(x: cardsTextures[numCol-1].position.x + cardsTextures[numCol-1].size.width/2, y: cardsTextures[0].position.y + view.frame.height * 0.08)
            addChild(label)
        }
        self.pointsTitle = SKLabelNode(text: NSLocalizedString("Score", comment: ""))
        if let label = self.pointsTitle{
            label.fontName = "HelveticaNeue-Light"
            label.fontColor = .darkGray
            label.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.right
            label.fontSize = 18
            label.position = CGPoint(x: cardsTextures[numCol-1].position.x + cardsTextures[numCol-1].size.width/2, y: self.pointsScore!.position.y + view.frame.height * 0.035)//view.frame.height * 0.82)
            addChild(label)
        }
        
        self.bonusText = SKLabelNode(text: "x " + String(gL!.bonus))
        if let label = self.bonusText{
            label.fontName = "HelveticaNeue-Light"
            label.fontColor = SKColor(named: "BotonPlay")
            label.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.left
            label.fontSize = 17
            label.position = CGPoint(x: cardsTextures[0].position.x - cardsTextures[0].size.width/2, y: cardsTextures[0].position.y + view.frame.height * 0.08)
            addChild(label)
        }
        self.bonusTitle = SKLabelNode(text: "Bonus")
        if let label = self.bonusTitle{
            label.fontName = "HelveticaNeue-Light"
            label.fontColor = .darkGray
            label.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.left
            label.fontSize = 18
            label.position = CGPoint(x: cardsTextures[0].position.x - cardsTextures[0].size.width/2, y: self.pointsScore!.position.y + view.frame.height * 0.035)//view.frame.height * 0.82)
            addChild(label)
        }
        
        self.timeLeft = SKLabelNode(text: "10:00")//String(gL!.time))
        if let label = self.timeLeft{
            label.fontName = "HelveticaNeue-Light"
            label.fontColor = SKColor(named: "BotonPlay")
            label.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.center
            label.fontSize = 17
            label.position = CGPoint(x: view.frame.width/2.0, y: cardsTextures[0].position.y + view.frame.height * 0.08)
            addChild(label)
        }
        self.timeLeftTitle = SKLabelNode(text: NSLocalizedString("TimeLeft", comment: ""))
        if let label = self.timeLeftTitle{
            label.fontName = "HelveticaNeue-Light"
            label.fontColor = .darkGray
            label.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.center
            label.fontSize = 18
            label.position = CGPoint(x: view.frame.width/2.0, y: self.pointsScore!.position.y + view.frame.height * 0.035)//view.frame.height * 0.82)
            addChild(label)
        }
        
    }
    override func update(_ currentTime: TimeInterval){
        if gL!.DidWin(){
            //guardar cosas
            gameSceneDelegate?.back(sender: self)
        }
        if gL!.DidLost(){
            gameSceneDelegate?.back(sender: self)
        }
        //time = currentTime
        if initiate{
            gL!.initTime = currentTime
            initiate = false
            startTime = true
        }
        if !initiate && startTime{
            gL!.time = gL!.maxTime - (currentTime - gL!.initTime)
        }

        
        self.timeLeft!.text = gL!.timeString(time: gL!.time)
        self.bonusText?.text = "x" + String(gL!.bonus)
        self.pointsScore?.text = String(gL!.points)
    }

    
    func CardsPositions()->Void{
        for i in 0..<cardsTextures.count{
            if gL?.level  == Levels.easy{
                /*if MenuScene.modelIdentifier() == "iPhone11,8"{
                    ScreenResW = 0.22
                    ScreenResH = 0.65
                }*/
               // else {
                    ScreenResW = 0.18
                    ScreenResH = 0.7
               // }
                numCol = 3
                let separationWidth: CGFloat = view!.frame.width/12
                //let initialSeparationWidth: CGFloat = view!.frame.width/12
                //let separationHeight: CGFloat = view!.frame.height/4
                let separationBelow: CGFloat = view!.frame.height/18
                if i < numCol {
                    if i == 0{
                        cardsTextures[i].position = CGPoint(x: view!.frame.width * ScreenResW, y: view!.frame.height * ScreenResH)
                    }
                    else{
                        cardsTextures[i].position = CGPoint(x: cardsTextures[i - 1].position.x + cardSizeEasy + separationWidth, y: view!.frame.height * ScreenResH)
                    }
                }
                else if i < numCol*2{
                    if(i == numCol){
                        cardsTextures[i].position = CGPoint(x: cardsTextures[0].position.x, y: cardsTextures[0].position.y - cardSizeEasy - separationBelow)
                    }
                    else{
                        cardsTextures[i].position = CGPoint(x: cardsTextures[i - 1].position.x + cardSizeEasy + separationWidth, y: cardsTextures[i-1].position.y)
                    }
                }
                else if i < numCol*3{
                    if(i == numCol*2){
                        cardsTextures[i].position = CGPoint(x: cardsTextures[0].position.x, y: cardsTextures[numCol].position.y - cardSizeEasy - separationBelow)
                    }
                    else{
                        cardsTextures[i].position = CGPoint(x: cardsTextures[i - 1].position.x + cardSizeEasy + separationWidth, y: cardsTextures[i-1].position.y)
                    }
                }
                else if i  < numCol*4{
                    if(i == numCol*3){
                        cardsTextures[i].position = CGPoint(x: cardsTextures[0].position.x, y: cardsTextures[numCol*2].position.y - cardSizeEasy - separationBelow)
                    }
                    else{
                        cardsTextures[i].position = CGPoint(x: cardsTextures[i - 1].position.x + cardSizeEasy + separationWidth, y: cardsTextures[i-1].position.y)
                    }
                }
            }
            else if gL?.level  == Levels.medium{
                /*if MenuScene.modelIdentifier() == "iPhone11,8"{
                    ScreenResW = 0.15
                    ScreenResH = 0.65
                }*/
                //else {
                    ScreenResW = 0.13
                    ScreenResH = 0.7
                //}
                numCol = 4
                let separationWidth: CGFloat = view!.frame.width/28
                //let initialSeparationWidth: CGFloat = view!.frame.width/10
                //let separationHeight: CGFloat = view!.frame.height/4
                let separationBelow: CGFloat = view!.frame.height/30
                if i < numCol {
                    if i == 0{
                        cardsTextures[i].position = CGPoint(x: view!.frame.width * ScreenResW, y: view!.frame.height * ScreenResH)
                    }
                    else{
                        cardsTextures[i].position = CGPoint(x: cardsTextures[i - 1].position.x + cardSizeMedium + separationWidth, y: view!.frame.height * ScreenResH)
                    }
                }
                else if i < numCol*2{
                    if(i == numCol){
                        cardsTextures[i].position = CGPoint(x: cardsTextures[0].position.x, y: cardsTextures[0].position.y - cardSizeMedium - separationBelow)
                    }
                    else{
                        cardsTextures[i].position = CGPoint(x: cardsTextures[i - 1].position.x + cardSizeMedium + separationWidth, y: cardsTextures[i-1].position.y)
                    }
                }
                else if i < numCol*3{
                    if(i == numCol*2){
                        cardsTextures[i].position = CGPoint(x: cardsTextures[0].position.x, y: cardsTextures[numCol].position.y - cardSizeMedium - separationBelow)
                    }
                    else{
                        cardsTextures[i].position = CGPoint(x: cardsTextures[i - 1].position.x + cardSizeMedium + separationWidth, y: cardsTextures[i-1].position.y)
                    }
                }
                else if i  < numCol*4{
                    if(i == numCol*3){
                        cardsTextures[i].position = CGPoint(x: cardsTextures[0].position.x, y: cardsTextures[numCol*2].position.y - cardSizeMedium - separationBelow)
                    }
                    else{
                        cardsTextures[i].position = CGPoint(x: cardsTextures[i - 1].position.x + cardSizeMedium + separationWidth, y: cardsTextures[i-1].position.y)
                    }
                }
                else if i  < numCol*5{
                    if(i == numCol*4){
                        cardsTextures[i].position = CGPoint(x: cardsTextures[0].position.x, y: cardsTextures[numCol*3].position.y - cardSizeMedium - separationBelow)
                    }
                    else{
                        cardsTextures[i].position = CGPoint(x: cardsTextures[i - 1].position.x + cardSizeMedium + separationWidth, y: cardsTextures[i-1].position.y)
                    }
                }
                else if i  < numCol*6{
                    if(i == numCol*5){
                        cardsTextures[i].position = CGPoint(x: cardsTextures[0].position.x, y: cardsTextures[numCol*4].position.y - cardSizeMedium - separationBelow)
                    }
                    else{
                        cardsTextures[i].position = CGPoint(x: cardsTextures[i - 1].position.x + cardSizeMedium + separationWidth, y: cardsTextures[i-1].position.y)
                    }
                }
            }
            else if gL?.level  == Levels.hard{
                /*if MenuScene.modelIdentifier() == "iPhone11,8"{
                    ScreenResW = 0.17
                    ScreenResH = 0.65
                }*/
                //else {
                    ScreenResW = 0.17
                    ScreenResH = 0.75
                //}
                numCol = 4
                let separationWidth: CGFloat = view!.frame.width/50

                let separationBelow: CGFloat = view!.frame.height/36
                let separationDivider: CGFloat = 6
                if i < numCol {
                    if i == 0{
                        cardsTextures[i].position = CGPoint(x: view!.frame.width * ScreenResW, y: view!.frame.height * ScreenResH)
                    }
                    else{
                        cardsTextures[i].position = CGPoint(x: cardsTextures[i - 1].position.x + cardSizeHard + separationWidth, y: view!.frame.height * ScreenResH)
                    }
                }
                else if i < numCol*2{
                    if(i == numCol){
                        cardsTextures[i].position = CGPoint(x: cardsTextures[0].position.x, y: cardsTextures[0].position.y - cardSizeHard - separationBelow/separationDivider)
                    }
                    else{
                        cardsTextures[i].position = CGPoint(x: cardsTextures[i - 1].position.x + cardSizeHard + separationWidth, y: cardsTextures[i-1].position.y)
                    }
                }
                else if i < numCol*3{
                    if(i == numCol*2){
                        cardsTextures[i].position = CGPoint(x: cardsTextures[0].position.x, y: cardsTextures[numCol].position.y - cardSizeHard - separationBelow/separationDivider)
                    }
                    else{
                        cardsTextures[i].position = CGPoint(x: cardsTextures[i - 1].position.x + cardSizeHard + separationWidth, y: cardsTextures[i-1].position.y)
                    }
                }
                else if i  < numCol*4{
                    if(i == numCol*3){
                        cardsTextures[i].position = CGPoint(x: cardsTextures[0].position.x, y: cardsTextures[numCol*2].position.y - cardSizeHard - separationBelow/separationDivider)
                    }
                    else{
                        cardsTextures[i].position = CGPoint(x: cardsTextures[i - 1].position.x + cardSizeHard + separationWidth, y: cardsTextures[i-1].position.y)
                    }
                }
                else if i  < numCol*5{
                    if(i == numCol*4){
                        cardsTextures[i].position = CGPoint(x: cardsTextures[0].position.x, y: cardsTextures[numCol*3].position.y - cardSizeHard - separationBelow/separationDivider)
                    }
                    else{
                        cardsTextures[i].position = CGPoint(x: cardsTextures[i - 1].position.x + cardSizeHard + separationWidth, y: cardsTextures[i-1].position.y)
                    }
                }
                else if i  < numCol*6{
                    if(i == numCol*5){
                        cardsTextures[i].position = CGPoint(x: cardsTextures[0].position.x, y: cardsTextures[numCol*4].position.y - cardSizeHard - separationBelow/separationDivider)
                    }
                    else{
                        cardsTextures[i].position = CGPoint(x: cardsTextures[i - 1].position.x + cardSizeHard + separationWidth, y: cardsTextures[i-1].position.y)
                    }
                }
                else if i  < numCol*7{
                    if(i == numCol*6){
                        cardsTextures[i].position = CGPoint(x: cardsTextures[0].position.x, y: cardsTextures[numCol*5].position.y - cardSizeHard - separationBelow/separationDivider)
                    }
                    else{
                        cardsTextures[i].position = CGPoint(x: cardsTextures[i - 1].position.x + cardSizeHard + separationWidth, y: cardsTextures[i-1].position.y)
                    }
                }
            }
        }
        
    }
    func OnBonusChanged(){
        let scaleBig = SKAction.scale(by: 1.4, duration: 0.2)
        let scaleSmall = SKAction.scale(to: 1, duration: 0.1)
        bonusText!.run(SKAction.sequence([scaleBig, scaleSmall]))
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
       
        if gL!.cards[sender.ID].state == Card.Estado.tapada.rawValue {

                gL!.cards[sender.ID].state = Card.Estado.destapada.rawValue
            
                if gL?.cartaSeleccionada == nil{
                    gL!.IDSelected = tempID
                    gL?.cartaSeleccionada = sender
                    gL?.cartaSeleccionada?.ID = sender.ID
                    gL?.cartaSeleccionada?.special = sender.special
                }
                else {
                    //match
                    if tempID == gL!.IDSelected{
                        gL?.cartaSeleccionada?.MatchCard()
                        sender.MatchCard()
                        gL!.cards[sender.ID].state = Card.Estado.emparejada.rawValue
                        gL!.cards[gL!.cartaSeleccionada!.ID].state = Card.Estado.emparejada.rawValue
                        gL!.matches += 1
                        
                        if sender.special{
                            gL!.points += 3 * 2 * gL!.bonus
                        }
                        else{
                            gL!.points += 3 * gL!.bonus
                        }
                        if gL!.matches < ((level.rawValue / 2) - 1){
                            //gL!.RandomBonus()
                            gL!.AddBonus()
                            OnBonusChanged()
                        }
                        
                        gL?.cartaSeleccionada = nil
                        gL!.IDSelected = -1
                    }
                        //no match
                    else{
                        gL?.cartaSeleccionada?.SwipeBackCard()
                        sender.SwipeBackCard()
                        gL!.cards[sender.ID].state = Card.Estado.tapada.rawValue
                        gL!.cards[gL!.cartaSeleccionada!.ID].state = Card.Estado.tapada.rawValue
                        gL!.IDSelected = -1
                        gL!.ResetBonus()
                        //gL!.RandomBonus()
                        gL?.cartaSeleccionada = nil
                 
                }
            }
        
        }
        
    }
    
    
    func AllSwipe(){
        /*for i in 0..<cardsTextures.count{
            cardsTextures[i].isUserInteractionEnabled = false
        }*/
        var counter: Int = 0
        for i in 0..<cardsTextures.count{
            cardsTextures[i].ShowCard()
            counter += 1
        }
        if counter >= cardsTextures.count{
            initiate = true
            for i in 0..<cardsTextures.count{
                cardsTextures[i].isUserInteractionEnabled = true
            }
        }
    }
    
}

