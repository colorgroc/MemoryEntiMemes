//
//  Score.swift
//  MemoryEntiMemes
//
//  Created by Anna Ponce Llerda on 17/05/2019.
//  Copyright © 2019 cat.enti. All rights reserved.
//

import Foundation
class Score {
    let ID: String
    var score: Int
    var time: TimeInterval
    init(ID: String, score: Int, time: TimeInterval) {
        self.ID = ID
        self.score = score
        self.time = time
    }
    
    
}
