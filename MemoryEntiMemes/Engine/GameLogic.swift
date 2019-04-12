//
//  GameLogic.swift
//  MemoryEntiMemes
//
//  Created by Anna Ponce Llerda on 21/03/2019.
//  Copyright © 2019 cat.enti. All rights reserved.
//
enum Levels: Int{
    case easy = 12, medium = 20, hard = 28
}
enum ActionsEnum: Int{
    case backToFront = 1, FrontToBack = 2, match = 3
}
class GameLogic {
 
    var cards = [Card]()
    var points: Int = 0
    var matches:Int = 0
    var IDSelected:Int = 0
    var selectedCard: Card?
    var level = Levels.easy
    let textures = ["Ivan", "Albert", "Jordi", "Radev", "Arnal", "Ben", "Carlos", "Coronado", "Enrique", "Fran", "Fredi", "Fukuy", "Hector", "Isidro", "Ismael", "Jaumandreu", "Jaume", "Jesus", "Jose Luis", "Jussi", "Lego", "Llobera", "Lourdes", "Matias", "Nico", "Oriol", "Oscar", "Raul", "Ricard", "Richard", "Rita", "Ruth", "Valls", "Vanesa", "Vilella", "Xavier", "Xicota" ] //opsar aqui totes les textures que poden sortir
    
    func reset(){
        cards = [Card]()
        var tempTextures = textures
        tempTextures.shuffle()
        //let number = Int.random(in: 0 ..< level.rawValue / 2)
        
        for i in 0..<level.rawValue / 2{
           let card1 = Card(ID: i, special: false, estado: Card.Estado.tapada.rawValue, textureFrontName: tempTextures[i], textureBackName: "back")
            //level.rawValue para luego obtener el id para el match
            let card2 = Card(ID: i + level.rawValue / 2, special: false, estado: Card.Estado.tapada.rawValue, textureFrontName: tempTextures[i], textureBackName: "back")
            print(card2.cardID)
            cards.append(card1)
            cards.append(card2)
            cards.shuffle()
        }
        
    }
    func move(){
        
    }
    func DidWin()->Bool{
        if matches == level.rawValue / 2{
            print("won")
            return true
        } else{
            return false
        }
    }
        
}

