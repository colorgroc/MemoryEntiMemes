//
//  Prrefs.swift
//  MemoryEntiMemes
//
//  Created by Anna Ponce Llerda on 05/06/2019.
//  Copyright © 2019 cat.enti. All rights reserved.
//

import Foundation

class Prefs {
    
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
        UserDefaults.standard.set(!soundOn, forKey: "SOUND_ON")
    }
    
    public static func saveEasyPoints(points: Int){
        if points > UserDefaults.standard.integer(forKey: Prefs.E_POINTS){
            UserDefaults.standard.set(points, forKey: Prefs.E_POINTS)
        }
    }
    public static func saveMediumPoints(points: Int){
        if points > UserDefaults.standard.integer(forKey: Prefs.M_POINTS){
            UserDefaults.standard.set(points, forKey: Prefs.M_POINTS)
        }
    }
    public static func saveHardPoints(points: Int){
        if points > UserDefaults.standard.integer(forKey: Prefs.H_POINTS){
            UserDefaults.standard.set(points, forKey: Prefs.H_POINTS)
        }
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
