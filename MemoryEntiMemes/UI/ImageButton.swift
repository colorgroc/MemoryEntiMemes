//
//  CloussoreButton.swift
//  MemoryEntiMemes
//
//  Created by Anna Ponce Llerda on 07/03/2019.
//  Copyright © 2019 cat.enti. All rights reserved.
//

import SpriteKit
import AudioToolbox
protocol ImageButtonDelegate: class{
    func onTap(sender:ImageButton)
}
class ImageButton: SKSpriteNode {
    
    private var imageIcon = SKSpriteNode()
    weak var delegate:ImageButtonDelegate?
    
    func setImage(newImage: String){
        self.texture! = SKTexture(imageNamed: newImage)
    }

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
                        
                    }
                }
            }
        }
        run (action, completion: DidItTouched)
    }
}

