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
    var done:Bool = false
    //var estado: Int = 0
    //var card:Card = Card()
    //var textureToShow:String = ""
    
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
                    if let delegate = delegate{
                        //SwipeCard(type: ActionsEnum.backToFront.rawValue)
                        print(ID)
                        delegate.onTap(sender: self)
                        //print("Anna")
                    }
                    //self.texture = SKSpriteNode(imageNamed: textureFront).texture
                }
            }
        }
        run (action, completion: DidItTouched)
        //run
    }
    func SetDoneTrue(){
        done = true
    }
    func SetDoneFalse(){
        done = false
    }
    func SwipeCard(type: Int){
        let front = SKAction.setTexture(SKTexture(imageNamed: textureFront))
        let back = SKAction.setTexture(SKTexture(imageNamed: textureBack))
        let scaleSmallX = SKAction.scaleX(to: 0, duration: 0.1)
        let scaleBigX = SKAction.scaleX(to: xScale, duration: 0.1)
        //let scaleSmall = SKAction.scale(to: size, duration: 0.3)
        //let scaleBig = SKAction.scale(by: 0.3, duration: 0.3)
        let wait = SKAction.wait(forDuration: 0.7)
        
        //let sequence: SKAction
        if type == ActionsEnum.backToFront.rawValue{

            run(SKAction.sequence([scaleSmallX, front, scaleBigX]), completion: SetDoneTrue)
        }
        else{
            run(SKAction.sequence([wait, scaleSmallX, back, scaleBigX]), completion: SetDoneTrue)
        }
        /*else if type == ActionsEnum.match.rawValue{
            let sequence = SKAction.sequence([scaleBig, wait, scaleSmall])
        }*/
    }
    /*func setTextureToDefault(back: String) ->Void{
        textureBack = back
    }
    func setFrontTexture(){
        
    }*/
    /*
    init(size: CGSize, textureFront: SKTexture, textureBack: SKTexture) {
        self.textureFront = textureFront
        self.textureBack = textureBack
        super.init(texture: nil, color: .white, size: size)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }*/
    
    
    
}
