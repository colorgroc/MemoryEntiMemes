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
    func goToResult(sender: GameScene, won: Bool, scoreGot: Int, timeGot: String)
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

    var cardSizeEasy: CGFloat = 0
    var cardSizeMedium: CGFloat = 0
    var cardSizeHard: CGFloat = 0
    
    var numCol: Int = 0

    var pointsScore: SKLabelNode?
    var pointsTitle: SKLabelNode?
    var timeLeft: SKLabelNode?
    var timeLeftTitle: SKLabelNode?
    var bonusText: SKLabelNode?
    var bonusTitle: SKLabelNode?
    var pointsLocalScore: SKLabelNode?
    var pointsLocalTitle: SKLabelNode?
    var startTime:Bool = false
    var localPoints:Int = 0
    static var firstShow:Bool = true
    static var initiate:Bool = false
    
    override func didMove(to view: SKView) {
        
        cardSizeEasy = view.frame.size.width * 0.22
        cardSizeMedium = view.frame.size.width * 0.21
        cardSizeHard = view.frame.size.width * 0.19
    
        screenResBackW = 0.06
        screenResBackH = 0.95
        //counter = 0
        GameScene.firstShow = true
        GameScene.initiate = false
        startTime = false
        self.backgroundColor = SKColor(named: "lightGray")!
        gL = GameLogic()

        gL?.level = level
        gL?.reset()
        gL!.time = gL!.maxTime
        startTime = false
        if(gL?.level == Levels.easy){
            localPoints = PlayMenuScene.bestEasyPoints

            gL!.maxTime *= 2
            if let count = gL?.cards.count{

                for i in 0..<count{

                    let card = CardSprite(imageNamed: gL!.cards[i].textureBackName)
                        card.SetTextures(front: gL!.cards[i].textureFrontName, back: gL!.cards[i].textureBackName)
                        card.size = CGSize(width: cardSizeEasy, height: cardSizeEasy) // poner variable size en easy
                        card.isUserInteractionEnabled = false
                        card.delegate = self
                        card.ID = gL!.cards[i].cardID
                        //ID = i
                        cardsTextures.append(card);
                        addChild(card)
                        CardsPositions()
                        AllSwipe()

                }
            }
        }
        else if(gL?.level == Levels.medium){
            localPoints = PlayMenuScene.bestMediumPoints
            //print("medium")
            gL!.maxTime *= 4
            if let count = gL?.cards.count{
                for i in 0..<count{
                    let card = CardSprite(imageNamed: gL!.cards[i].textureBackName)
                    card.SetTextures(front: gL!.cards[i].textureFrontName, back: gL!.cards[i].textureBackName)
                    card.size = CGSize(width: cardSizeMedium, height: cardSizeMedium)
                    card.delegate = self
                    card.isUserInteractionEnabled = false
                    card.ID = gL!.cards[i].cardID
                    cardsTextures.append(card);
                    addChild(card)
                    CardsPositions()
                    AllSwipe()
                    //card.isUserInteractionEnabled = false
                }
            }
        }
        else if(gL?.level == Levels.hard){
            localPoints = PlayMenuScene.bestHardPoints
            //print("hard")
            gL!.maxTime *= 6
            if let count = gL?.cards.count{
                for i in 0..<count{
                    let card = CardSprite(imageNamed: gL!.cards[i].textureBackName)
                    card.SetTextures(front: gL!.cards[i].textureFrontName, back: gL!.cards[i].textureBackName)
                    card.size = CGSize(width: cardSizeHard, height: cardSizeHard)
                    card.delegate = self
                    card.isUserInteractionEnabled = false
                    card.ID = gL!.cards[i].cardID
                    cardsTextures.append(card);
                    addChild(card)
                    CardsPositions()
                    AllSwipe()
                    //card.isUserInteractionEnabled = false
                }
            }
        }
        
        
        backButton.isUserInteractionEnabled = true
        backButton.delegate = self
        backButton.position = CGPoint(x: view.frame.width * screenResBackW, y: view.frame.height * screenResBackH)
        addChild(backButton)
        
        self.pointsLocalTitle = SKLabelNode(text: NSLocalizedString("LocalScore", comment: ""))
        if let label = self.pointsLocalTitle{
            label.fontName = "HelveticaNeue-Light"
            label.fontColor = SKColor(named: "BotonPlay")
            label.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.right
            label.fontSize = 20
            label.position = CGPoint(x: view.frame.width * 0.95, y: view.frame.height * screenResBackH)//view.frame.height * 0.82)
            addChild(label)
        }
        
        self.pointsLocalScore = SKLabelNode(text: String(localPoints))
        if let label = self.pointsLocalScore{
            label.fontName = "HelveticaNeue-Light"
            label.fontColor = .gray //SKColor(named: "Blue")
            label.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.right
            label.fontSize = 22
            //label.position = CGPoint(x: pointsLocalTitle!.position.x, y: pointsLocalTitle!.position.y - view.frame.height * 0.035)
            label.position = pointsLocalTitle!.position.applying(CGAffineTransform(translationX: 0, y: -25))
            addChild(label)
        }
 
        self.pointsScore = SKLabelNode(text: String(gL!.points))
        if let label = self.pointsScore{
            label.fontName = "HelveticaNeue-Light"
            label.fontColor = SKColor(named: "Blue")
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
            if level == Levels.easy{
                FirebaseService().UpdateEasyScore(score: gL!.points)
                Prefs.saveEasyPoints(points: gL!.points)
            }
            else if level == Levels.medium{
                FirebaseService().UpdateMediumScore(score: gL!.points)
                Prefs.saveMediumPoints(points: gL!.points)
            }
            else if level == Levels.hard{
                FirebaseService().UpdateHardScore(score: gL!.points)
                Prefs.saveHardPoints(points: gL!.points)
            }
            gameSceneDelegate?.goToResult(sender: self, won: true, scoreGot: gL!.points, timeGot: gL!.timeString(time: gL!.time))
        }
        if gL!.DidLost(){
            gameSceneDelegate?.goToResult(sender: self, won: false, scoreGot: gL!.points, timeGot: gL!.timeString(time: gL!.time))
        }
        //time = currentTime
        if !GameScene.initiate{
            gL!.time = gL!.maxTime
        }
        else{
            if !startTime{
                gL!.initTime = currentTime
                //GameScene.initiate = true
                startTime = true
                GameScene.firstShow = false
            }
            else{
                gL!.time = gL!.maxTime - (currentTime - gL!.initTime)
            }
        }
        self.timeLeft!.text = gL!.timeString(time: gL!.time)
        self.bonusText?.text = "x" + String(gL!.bonus)
        self.pointsScore?.text = String(gL!.points)
    }

    
    func CardsPositions()->Void{
        for i in 0..<cardsTextures.count{
            if gL?.level  == Levels.easy{
                ScreenResW = 0.18
                ScreenResH = 0.7
                numCol = 3
                let separationWidth: CGFloat = view!.frame.width/12

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

                ScreenResW = 0.13
                ScreenResH = 0.7
                numCol = 4
                let separationWidth: CGFloat = view!.frame.width/28

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
                ScreenResW = 0.17
                ScreenResH = 0.75

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
    func OnScoreChanged(){
        let scaleBig = SKAction.scale(by: 1.4, duration: 0.2)
        let scaleSmall = SKAction.scale(to: 1, duration: 0.1)
        pointsScore!.run(SKAction.sequence([scaleBig, scaleSmall]))
    }
    func onTap(sender: ImageButton) {
        if sender == backButton {
            gameSceneDelegate?.back(sender: self)
        }
        //Audio.shared.PLAY_PRESSED()
    }
    func onTap(sender: CardSprite) {
        if !GameScene.firstShow{
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
                                gL!.points += gL!.pointsValue * gL!.extraPointsValue * gL!.bonus
                                OnScoreChanged()
                            }
                            else{
                                gL!.points += gL!.pointsValue * gL!.bonus
                                OnScoreChanged()
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
        
    }
    
    
    func AllSwipe(){
        for i in 0..<cardsTextures.count{
            cardsTextures[i].isUserInteractionEnabled = false
        }
        
        for i in 0..<cardsTextures.count{
            cardsTextures[i].ShowCard()
            //counter += 1
        }
    }
    
}

