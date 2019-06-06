//
//  CardSprite.swift
//  MemoryEntiMemes
//
//  Created by Anna Ponce Llerda on 21/03/2019.
//  Copyright © 2019 cat.enti. All rights reserved.
//

import SpriteKit
import AudioToolbox

protocol CardDelegate: class{
    func onTap(sender:CardSprite)
}
class CardSprite: SKSpriteNode {
    //guardareme referencia carta seleccionada? var selectedCard: Card?
    var textureFront:String = ""
    var textureBack:String = ""
    var ID:Int = 0
    var state: Int = 0
    var special:Bool = false
    
    func SetTextures(front: String ,back: String)->Void{
        textureBack = back
        textureFront = front
    }
    
    weak var delegate:CardDelegate?
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.isUserInteractionEnabled = false
        let action = SKAction.moveBy(x: 6, y: 0, duration: 0.1)
        run (action)
        
    }
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        let action = SKAction.moveBy(x: -6, y: 0, duration: 0.1)
        AudioServicesPlaySystemSound(kSystemSoundID_Vibrate)
        func DidItTouched(){
            if let touch = touches.first, let parent = parent{
                if frame.contains(touch.location(in: parent)){
                    //self.isUserInteractionEnabled = false
                    SwipeCard()
                }
            }
        }
        run (action, completion: DidItTouched)
    }

    func Delegate(){
        if let delegate = delegate{
            //print(ID)
            self.state = Card.Estado.destapada.rawValue
            self.isUserInteractionEnabled = false
            delegate.onTap(sender: self)
        }
    }
    func SwipeCard(){
        Audio.shared.PLAY_PRESSED()
        let front = SKAction.setTexture(SKTexture(imageNamed: textureFront))
        let scaleSmallX = SKAction.scaleX(to: 0, duration: 0.2)
        let scaleBigX = SKAction.scaleX(to: xScale, duration: 0.2)
        run(SKAction.sequence([scaleSmallX, front, scaleBigX]), completion: Delegate)
    }
    func SwipeBackCard(){
        //self.isUserInteractionEnabled = false
        Audio.shared.PLAY_WRONG()
        let back = SKAction.setTexture(SKTexture(imageNamed: textureBack))
        let scaleSmallX = SKAction.scaleX(to: 0, duration: 0.2)
        let scaleBigX = SKAction.scaleX(to: xScale, duration: 0.2)
        let wait = SKAction.wait(forDuration: 0.7)
        run(SKAction.sequence([wait, scaleSmallX, back, scaleBigX]), completion: UseInteractionTapada)
    }
    func MatchCard(){
        Audio.shared.PLAY_MATCH()
        let scaleBig = SKAction.scale(by: 1.1, duration: 0.1)
        let scaleSmall = SKAction.scale(to: 1, duration: 0.1)
        run(SKAction.sequence([scaleBig, scaleSmall]), completion: UseInteractionMatch)

    }
    func UseInteractionTapada()->Void{
        self.state = Card.Estado.tapada.rawValue
        self.isUserInteractionEnabled = true
    }
    func UseInteractionMatch()->Void{
        self.state = Card.Estado.emparejada.rawValue
        self.isUserInteractionEnabled = false
    }

    func ShowCard(){
        self.isUserInteractionEnabled = false
        let front = SKAction.setTexture(SKTexture(imageNamed: textureFront))
        let back = SKAction.setTexture(SKTexture(imageNamed: textureBack))
        let scaleSmallX = SKAction.scaleX(to: 0, duration: 0.2)
        let scaleBigX = SKAction.scaleX(to: xScale, duration: 0.2)
        let wait_short = SKAction.wait(forDuration: 0.7)
        let wait_long = SKAction.wait(forDuration: 1.5)
        
        run(SKAction.sequence([wait_short,scaleSmallX, front, scaleBigX, wait_long, scaleSmallX, back, scaleBigX]), completion: UseInteractionTapada)
    }
}
