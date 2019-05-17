//
//  GameLogic.swift
//  MemoryEntiMemes
//
//  Created by Anna Ponce Llerda on 21/03/2019.
//  Copyright © 2019 cat.enti. All rights reserved.
//
import Foundation
enum Levels: Int{
    case easy = 12, medium = 20, hard = 28
}
enum ActionsEnum: Int{
    case backToFront = 1, FrontToBack = 2, match = 3, selectedFrontToBack = 4
}
class GameLogic {
 
    var cards = [Card]()
    var points: Int = 0
    var bonus: Int = 1
    var matches:Int = 0
    var initTime: TimeInterval = 0
    var maxTime: TimeInterval = 10
    var time: TimeInterval = 0
    var IDSelected:Int = -1
    var cartaSeleccionada: CardSprite?
    //var selectedCard: Card?
    var level = Levels.easy
    let textures = ["Ivan", "Albert", "Jordi", "Radev", "Arnal", "Ben", "Carlos", "Coronado", "Enrique", "Fran", "Fredi", "Fukuy", "Hector", "Isidro", "Ismael", "Jaumandreu", "Jaume", "Jesus", "Jose Luis", "Jussi", "Lego", "Llobera", "Lourdes", "Matias", "Nico", "Oriol", "Oscar", "Raul", "Ricard", "Richard", "Rita", "Ruth", "Valls", "Vanesa", "Vilella", "Xavier", "Xicota" ] //opsar aqui totes les textures que poden sortir
    
    func reset(){
        cards = [Card]()
        time = maxTime
        var tempTextures = textures
        tempTextures.shuffle()
        //let number = Int.random(in: 0 ..< level.rawValue / 2)
        
        for i in 0..<level.rawValue / 2{
            var special: Bool = false
            if tempTextures[i] == "Radev" || tempTextures[i] == "Richard" || tempTextures[i] == "Oscar"{
                special = true
            }
            else{
                special = false
            }
           let card1 = Card(ID: i, special: special, estado: Card.Estado.tapada.rawValue, textureFrontName: tempTextures[i], textureBackName: "back")
            //level.rawValue para luego obtener el id para el match
            let card2 = Card(ID: i + level.rawValue / 2, special: special, estado: Card.Estado.tapada.rawValue, textureFrontName: tempTextures[i], textureBackName: "back")
            print(card2.cardID)
            cards.append(card1)
            cards.append(card2)
            cards.shuffle()
        }
        
    }
    
    func DidWin()->Bool{
        if matches == level.rawValue / 2{
            print("won")
            return true
        } else{
            return false
        }
    }
    func DidLost()->Bool{
        if time <= 0 {
            return true
        } else{
            return false
        }
    }
    
    func RandomBonus()->Void{
        let dado = [Int](arrayLiteral: 1,2,3,4,5,6)
        let res = Int.random(in: 1..<20)
        if res <= 14 {
            bonus = dado[0]
        }
        else if res <= 16{
            bonus = dado[1]
        }
        else if res <= 17{
            bonus = dado[2]
        }
        else if res <= 18{
            bonus = dado[3]
        }
        else if res <= 19{
            bonus = dado[4]
        }
        else if res == 20{
            bonus = dado[5]
        }
    }
    func AddBonus()->Void{
        bonus += 1
    }
    func ResetBonus()->Void{
        bonus = 1
    }
    func timeString(time:TimeInterval) -> String {
        let minutes = Int(time) / 60 % 60
        let seconds = Int(time) % 60
        return String(format:"%02i:%02i", minutes, seconds)
    }
}

