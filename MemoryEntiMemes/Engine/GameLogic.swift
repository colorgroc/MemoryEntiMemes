//
//  GameLogic.swift
//  MemoryEntiMemes
//
//  Created by Anna Ponce Llerda on 21/03/2019.
//  Copyright © 2019 cat.enti. All rights reserved.
//
enum Levels: Int{
    case easy = 16, medium = 20, hard = 32
}
class GameLogic {
 
    var cards = [Card]()
    var points: Int = 0
    var selectedCard: Card?
    var level = Levels.easy
    let textures = ["", "", ""]
    
    init() {
        
    }
    func reset(){
        //resetear
        cards = [Card]()
        var tempTextures = textures
        tempTextures.shuffle()
        //let number = Int.random(in: 0 ..< level.rawValue / 2)
        
        for i in 0..<level.rawValue / 2{
             //init(ID: String, special: Bool, estado: Int, textureFrontName: String, textureBackName: String) {
            let card1 = Card(ID: i, special: false, estado: 1, textureFrontName: "cardTextureFront", textureBackName: "cardTextureBack")
             let card2 = Card(ID: i + level.rawValue / 2, special: false, estado: 1, textureFrontName: "cardTextureFront", textureBackName: "cardTextureBack")
            cards.append(card1)
            cards.append(card2)
        }
        
    }
    func move(){
        
    }
    func DidWin()->Bool{
        return false
    }
}
