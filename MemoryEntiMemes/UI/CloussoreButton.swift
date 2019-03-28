//
//  CloussoreButton.swift
//  MemoryEntiMemes
//
//  Created by Anna Ponce Llerda on 07/03/2019.
//  Copyright © 2019 cat.enti. All rights reserved.
//

import SpriteKit

class CloussoreButton: SKShapeNode {
    
    var onTap: (() -> (Void))?
    private var textNode = SKLabelNode()
    
    func setText(text: String){
        if textNode.parent == nil{
            addChild(textNode)
            textNode.verticalAlignmentMode = .center
            textNode.position = CGPoint(x: frame.width / 2.0, y: frame.height / 2.0)
        }
        textNode.text = text
    }
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        if let touch = touches.first, let parent = parent{
            if frame.contains(touch.location(in: parent)){
                if let onTap = onTap{
                    onTap()
                }
                
            }
        }
    }
}
