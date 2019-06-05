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
    let player = AVPlayer(url: Bundle.main.url(forResource: "BACKGROUND_MUSIC.mp3", withExtension: nil)!)
    
    private static let sharedAudio = Audio()
    public var volumenOn = true
    
    static var shared: Audio{
        return sharedAudio
    }
    func PLAY(){
        player.play()
    }
    
    func PAUSE(){
        player.pause()
    }
    
    func STOP(){
        player.pause()
        player.seek(to: CMTime.zero)
    }
    
    func ON(){
        //player.volume = 1.0
        player.isMuted = false
    }
    
    func OFF(){
        //player.volume = 0.0
        player.isMuted = true
    }
    
}
