//
//  Card.swift
//  MemoryEntiMemes
//
//  Created by Anna Ponce Llerda on 21/03/2019.
//  Copyright © 2019 cat.enti. All rights reserved.
//



class Card {
    let textureFrontName, textureBackName: String
    let isSpecial: Bool
    let cardID: Int
    enum Estado: Int{
        case tapada, destapada, emparejada
    }
    let state: Int
    init(ID: Int, special: Bool, estado: Int, textureFrontName: String, textureBackName: String) {
        self.cardID = ID
        self.isSpecial = special
        self.state = estado
        self.textureFrontName = textureFrontName
        self.textureBackName = textureBackName
    }
    
    
}
