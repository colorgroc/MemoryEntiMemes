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
   // let theme_player_2 = AVPlayer(url: Bundle.main.url(forResource: "BACKGROUND_MUSIC.mp3", withExtension: nil)!)
    //let pressed = AVPlayer(url: Bundle.main.url(forResource: "pressed.mp3", withExtension: nil)!)
    //let wrong = AVPlayer(url: Bundle.main.url(forResource: "wrong.mp3", withExtension: nil)!)
    //let match = AVPlayer(url: Bundle.main.url(forResource: "match.mp3", withExtension: nil)!)
    var theme_player: AVAudioPlayer?
    var pressed: AVAudioPlayer?
    var wrong: AVAudioPlayer?
    var match: AVAudioPlayer?
    
    private static let sharedAudio = Audio()
    public var volumenOn = true
    
    static var shared: Audio{
        return sharedAudio
    }
    func PLAY(){
        
        let path = Bundle.main.path(forResource: "BACKGROUND_MUSIC.mp3", ofType:nil)!
        let url = URL(fileURLWithPath: path)
        
        do {
            theme_player = try AVAudioPlayer(contentsOf: url)
            theme_player?.numberOfLoops = -1
            theme_player?.play()
            
        } catch {
            // couldn't load file :(
        }

        //theme_player.play()
    }
    func PLAY_PRESSED(){
        let path = Bundle.main.path(forResource: "pressed_2.mp3", ofType:nil)!
        let url = URL(fileURLWithPath: path)
        
        do {
            pressed = try AVAudioPlayer(contentsOf: url)
            //pressed?.numberOfLoops = -1
            pressed?.play()
        } catch {
            // couldn't load file :(
        }
       // pressed.play()
    }
    func PLAY_WRONG(){
        let path = Bundle.main.path(forResource: "wrong.mp3", ofType:nil)!
        let url = URL(fileURLWithPath: path)
        
        do {
            wrong = try AVAudioPlayer(contentsOf: url)
            //wrong?.numberOfLoops = -1
            wrong?.play()
        } catch {
            // couldn't load file :(
        }
        //wrong.play()
    }
    func PLAY_MATCH(){
        let path = Bundle.main.path(forResource: "match.mp3", ofType:nil)!
        let url = URL(fileURLWithPath: path)
        
        do {
            match = try AVAudioPlayer(contentsOf: url)
            //match?.numberOfLoops = -1
            match?.play()
            
        } catch {
            // couldn't load file :(
        }
        //match.play()
    }
    func PAUSE(){
        theme_player!.pause()
    }
    
    func STOP(){
        
        theme_player!.stop()
        //theme_player!.seek(to: CMTime.zero)
    }
    
    func ON(){
        theme_player!.volume = 1
        /*pressed!.volume = 1
        wrong!.volume = 1
        match!.volume = 1*/
        /*theme_player!.isMuted = false
        pressed.isMuted = false
        wrong.isMuted = false
        match.isMuted = false*/
    }
    
    func OFF(){
        theme_player!.volume = 0
        /*pressed!.volume = 0
        wrong!.volume = 0
        match!.volume = 0*/
        /*theme_player!.isMuted = true
        pressed.isMuted = true
        wrong.isMuted = true
        match.isMuted = true*/
    }
    
}
