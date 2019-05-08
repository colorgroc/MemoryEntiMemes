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

    
    func SetTextures(front: String ,back: String)->Void{
        textureBack = back
        textureFront = front
    }
    
    weak var delegate:CardDelegate?
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let action = SKAction.moveBy(x: 6, y: 0, duration: 0.1)
        run (action)
        
    }
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        let action = SKAction.moveBy(x: -6, y: 0, duration: 0.1)
        AudioServicesPlaySystemSound(kSystemSoundID_Vibrate)
        func DidItTouched(){
            if let touch = touches.first, let parent = parent{
                if frame.contains(touch.location(in: parent)){
                        SwipeCard()
                }
            }
        }
        run (action, completion: DidItTouched)
    }

    func Delegate(){
        if let delegate = delegate{
            print(ID)
            delegate.onTap(sender: self)
        }
    }
    func SwipeCard(){
        let front = SKAction.setTexture(SKTexture(imageNamed: textureFront))
        let scaleSmallX = SKAction.scaleX(to: 0, duration: 0.1)
        let scaleBigX = SKAction.scaleX(to: xScale, duration: 0.1)
        run(SKAction.sequence([scaleSmallX, front, scaleBigX]), completion: Delegate)
    }
    func SwipeBackCard(){
        let back = SKAction.setTexture(SKTexture(imageNamed: textureBack))
        let scaleSmallX = SKAction.scaleX(to: 0, duration: 0.1)
        let scaleBigX = SKAction.scaleX(to: xScale, duration: 0.1)
        let wait = SKAction.wait(forDuration: 0.7)
        run(SKAction.sequence([wait, scaleSmallX, back, scaleBigX]))
    }
    func MatchCard(){
        //let back = SKAction.setTexture(SKTexture(imageNamed: textureBack))
        //let scaleSmall = SKAction.scale(to: 0.7, duration: 0)
        //let scaleBig = SKAction.scale(to: 1, duration: 0)
        let scaleBig = SKAction.scale(by: 1.1, duration: 0.1)
        let scaleSmall = SKAction.scale(to: 1, duration: 0.1)
        //let wait = SKAction.wait(forDuration: 0.7)
        run(SKAction.sequence([scaleBig, scaleSmall]))
        //run(scale)
    }
    func ShowCard(){
        let front = SKAction.setTexture(SKTexture(imageNamed: textureFront))
        let back = SKAction.setTexture(SKTexture(imageNamed: textureBack))
        let scaleSmallX = SKAction.scaleX(to: 0, duration: 0.1)
        let scaleBigX = SKAction.scaleX(to: xScale, duration: 0.1)
        let wait_short = SKAction.wait(forDuration: 0.7)
        let wait_long = SKAction.wait(forDuration: 1.5)
        run(SKAction.sequence([wait_short,scaleSmallX, front, scaleBigX, wait_long, scaleSmallX, back, scaleBigX]))
    }
}
