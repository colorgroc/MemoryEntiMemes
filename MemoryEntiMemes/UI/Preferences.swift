//
//  Preferences.swift
//  MemoryEntiMemes
//
//  Created by Anna Ponce Llerda on 29/03/2019.
//  Copyright © 2019 cat.enti. All rights reserved.
//

import Foundation
//cmd + shift + o
class Preferences {
    
    let k_SOUND_ON = "SOUND_ON"
    
    func isSoundOn() -> Bool{
        if let _ = UserDefaults.standard.object(forKey: k_SOUND_ON){ //saber si hay algun valor existente o no
            let soundOn = UserDefaults.standard.bool(forKey: k_SOUND_ON)
            return soundOn
        }
        return true
    }
    
    func toggleSound(){
         let soundOn = isSoundOn()
        UserDefaults.standard.set(!soundOn, forKey: k_SOUND_ON)
    }
}
