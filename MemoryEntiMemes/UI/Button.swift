//
//  Button.swift
//  MemoryEntiMemes
//
//  Created by Anna Ponce Llerda on 07/03/2019.
//  Copyright © 2019 cat.enti. All rights reserved.
//

import SpriteKit
import AudioToolbox
protocol ButtonDelegate: class{
    func onTap(sender:Button)
}
class Button: SKShapeNode {

    weak var delegate:ButtonDelegate?
    private var textNode = SKLabelNode()
    
    func setText(text: String){
        if textNode.parent == nil{
            addChild(textNode)
            textNode.verticalAlignmentMode = .center
            textNode.position = CGPoint(x: frame.width / 2.0, y: frame.height / 2.0)
            //textNode.fontName = "Bangla Sangam MN"
        }
        textNode.text = text
    }
   
    func setText(text: String, color: SKColor){
        if textNode.parent == nil{
            textNode.fontColor = color
            addChild(textNode)
            textNode.verticalAlignmentMode = .center
            textNode.position = CGPoint(x: frame.width / 2.0, y: frame.height / 2.0)
            //textNode.fontName = "HelveticaNeue-UltraLight"
        }
        textNode.text = text
    }
    
    func setText(text: String, color: SKColor, font: String){
        if textNode.parent == nil{
            textNode.fontColor = color
            textNode.fontName = font
            addChild(textNode)
            textNode.verticalAlignmentMode = .center
            textNode.position = CGPoint(x: frame.width / 2.0, y: frame.height / 2.0)
            //textNode.fontName = "Bangla Sangam MN"
        }
        textNode.text = text
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
