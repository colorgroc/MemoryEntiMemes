//
//  Audio.swift
//  MemoryEntiMemes
//
//  Created by Anna Ponce Llerda on 05/06/2019.
//  Copyright © 2019 cat.enti. All rights reserved.
//

import Foundation
import AVFoundation

class Audio {
    let theme_player = AVPlayer(url: Bundle.main.url(forResource: "BACKGROUND_MUSIC.mp3", withExtension: nil)!)
    let pressed = AVPlayer(url: Bundle.main.url(forResource: "pressed.mp3", withExtension: nil)!)
    let wrong = AVPlayer(url: Bundle.main.url(forResource: "wrong.mp3", withExtension: nil)!)
    let match = AVPlayer(url: Bundle.main.url(forResource: "match.mp3", withExtension: nil)!)
    
    private static let sharedAudio = Audio()
    public var volumenOn = true
    
    static var shared: Audio{
        return sharedAudio
    }
    func PLAY(){
        //theme_player.numberOfLoops = -1
        theme_player.volume = 0.5
        theme_player.play()
    }
    func PLAY_PRESSED(){
        pressed.play()
    }
    func PLAY_WRONG(){
        wrong.play()
    }
    func PLAY_MATCH(){
        match.play()
    }
    func PAUSE(){
        theme_player.pause()
    }
    
    func STOP(){
        theme_player.pause()
        theme_player.seek(to: CMTime.zero)
    }
    
    func ON(){
        theme_player.isMuted = false
        pressed.isMuted = false
        wrong.isMuted = false
        match.isMuted = false
    }
    
    func OFF(){
        theme_player.isMuted = true
        pressed.isMuted = true
        wrong.isMuted = true
        match.isMuted = true
    }
    
}
