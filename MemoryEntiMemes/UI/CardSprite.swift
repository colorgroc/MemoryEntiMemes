//
//  CardSprite.swift
//  MemoryEntiMemes
//
//  Created by Anna Ponce Llerda on 21/03/2019.
//  Copyright © 2019 cat.enti. All rights reserved.
//

import SpriteKit

class CardSprite: SKSpriteNode {
    //guardareme referencia carta seleccionada? var selectedCard: Card?
    let textureFront, textureBack: SKTexture
    init(size: CGSize, textureFront: SKTexture, textureBack: SKTexture) {
        self.textureFront = textureFront
        self.textureBack = textureBack
        super.init(texture: nil, color: .white, size: size)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
