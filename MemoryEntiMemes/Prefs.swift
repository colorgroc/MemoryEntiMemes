//
//  Prrefs.swift
//  MemoryEntiMemes
//
//  Created by Anna Ponce Llerda on 05/06/2019.
//  Copyright © 2019 cat.enti. All rights reserved.
//

import Foundation

class Prefs {
    
    let k_SOUND_ON = "SOUND_ON"
    public static let E_POINTS = "e_POINTS"
    public static let M_POINTS = "m_POINTS"
    public static let H_POINTS = "h_POINTS"
    
    func isSoundOn() -> Bool {
        let soundOn =
            UserDefaults.standard.bool(forKey: "SOUND_ON")
        return soundOn
    }
    
    func toggleSound(){
        let soundOn = isSoundOn()
        UserDefaults.standard.set(!soundOn, forKey: k_SOUND_ON)
    }
    
    public static func saveEasyPoints(){
        UserDefaults.standard.set(PlayMenuScene.bestEasyPoints, forKey: Prefs.E_POINTS)
    }
    public static func saveMediumPoints(){
        UserDefaults.standard.set(PlayMenuScene.bestMediumPoints, forKey: Prefs.M_POINTS)
    }
    public static func saveHardPoints(){
        UserDefaults.standard.set(PlayMenuScene.bestHardPoints, forKey: Prefs.H_POINTS)
    }
    
    public static func loadEasyPoints(){
        PlayMenuScene.bestEasyPoints = UserDefaults.standard.integer(forKey: Prefs.E_POINTS)
    }
    public static func loadMediumPoints(){
        PlayMenuScene.bestMediumPoints = UserDefaults.standard.integer(forKey: Prefs.M_POINTS)
    }
    public static func loadHardPoints(){
        PlayMenuScene.bestHardPoints = UserDefaults.standard.integer(forKey: Prefs.H_POINTS)
    }
}
