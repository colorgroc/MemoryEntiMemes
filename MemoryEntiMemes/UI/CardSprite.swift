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
    //var card:Card = Card()
    //var textureToShow:String = ""
    
    func SetTextures(front: String ,back:String)->Void{
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
                        delegate.onTap(sender: self)
                        //print("Anna")
                    }
                    //self.texture = SKSpriteNode(imageNamed: textureFront).texture
                }
            }
        }
        run (action, completion: DidItTouched)
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
