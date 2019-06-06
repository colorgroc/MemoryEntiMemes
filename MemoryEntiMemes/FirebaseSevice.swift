//
//  FirebaseSevice.swift
//  MemoryEntiMemes
//
//  Created by Anna Ponce Llerda on 26/04/2019.
//  Copyright © 2019 cat.enti. All rights reserved.
//

import Foundation
import FirebaseFirestore

class FirebaseService {
    //let k_COLLECTION_HIGHSCORE = "HighScore"
    let db = Firestore.firestore()
    
    func ReadScore(level: String, completion: @escaping ([Int])->(Void)){
        if level == "Easy"{
            let docRef = db.collection("HighScores").document("Easy")
            docRef.getDocument { (document, error) in
                if let document = document, document.exists,
                    let gold = document.get("Gold") as? Int,
                    let silver = document.get("Silver") as? Int,
                    let bronze = document.get("Bronze") as? Int {
                    
                    var tempList = [Int]()
                    tempList.append(gold)
                    tempList.append(silver)
                    tempList.append(bronze)
                    //let dataDescription = document.data().map(String.init(describing:)) ?? "nil"
                    completion(tempList)
                } else {
                    print("Easy Document does not exist")
                }
            }
        }
        else if level == "Medium"{
            let docRef = db.collection("HighScores").document("Medium")
            docRef.getDocument { (document, error) in
                if let document = document, document.exists,
                    let gold = document.get("Gold") as? Int,
                    let silver = document.get("Silver") as? Int,
                    let bronze = document.get("Bronze") as? Int {
                    
                    var tempList = [Int]()
                    tempList.append(gold)
                    tempList.append(silver)
                    tempList.append(bronze)
                    //let dataDescription = document.data().map(String.init(describing:)) ?? "nil"
                    completion(tempList)
                } else {
                    print("Medium Document does not exist")
                }
            }
        }
        else if level == "Hard"{
            let docRef = db.collection("HighScores").document("Hard")
            docRef.getDocument { (document, error) in
                if let document = document, document.exists,
                    let gold = document.get("Gold") as? Int,
                    let silver = document.get("Silver") as? Int,
                    let bronze = document.get("Bronze") as? Int {
                    
                    var tempList = [Int]()
                    tempList.append(gold)
                    tempList.append(silver)
                    tempList.append(bronze)
                    //let dataDescription = document.data().map(String.init(describing:)) ?? "nil"
                    completion(tempList)
                } else {
                    print("Hard Document does not exist")
                }
            }
        }
    }
    func UpdateEasyScore(score:Int){
        let docRef = db.collection("HighScores").document("Easy")
        docRef.getDocument { (document, error) in
            if let document = document, document.exists,
                let gold = document.get("Gold") as? Int,
                let silver = document.get("Silver") as? Int,
                let bronze = document.get("Bronze") as? Int {
                
                if score >= gold{
                    if score == gold {
                        docRef.setData(["Gold" : score, "Silver" : silver, "Bronze" : bronze])
                    }
                    else{
                        docRef.setData(["Gold" : score, "Silver" : gold, "Bronze" : silver])
                    }
                    
                }
                else if score >= silver{
                    if score == silver {
                        docRef.setData(["Gold" : gold, "Silver" : score, "Bronze" : bronze])
                    }
                    else{
                        docRef.setData(["Gold" : gold, "Silver" : score, "Bronze" : silver])
                    }
                }
                else if score >= bronze{
                    docRef.setData(["Gold" : gold, "Silver" : silver, "Bronze" : score])
                }
            } else {
                print("Document does not exist")
            }
        }
    }
    func UpdateMediumScore(score:Int){
        let docRef = db.collection("HighScores").document("Medium")
        docRef.getDocument { (document, error) in
            if let document = document, document.exists,
                let gold = document.get("Gold") as? Int,
                let silver = document.get("Silver") as? Int,
                let bronze = document.get("Bronze") as? Int {

                if score >= gold{
                    if score == gold {
                        docRef.setData(["Gold" : score, "Silver" : silver, "Bronze" : bronze])
                    }
                    else{
                        docRef.setData(["Gold" : score, "Silver" : gold, "Bronze" : silver])
                    }
                    
                }
                else if score >= silver{
                    if score == silver {
                        docRef.setData(["Gold" : gold, "Silver" : score, "Bronze" : bronze])
                    }
                    else{
                        docRef.setData(["Gold" : gold, "Silver" : score, "Bronze" : silver])
                    }
                }
                else if score >= bronze{
                    docRef.setData(["Gold" : gold, "Silver" : silver, "Bronze" : score])
                }
            } else {
                print("Document does not exist")
            }
        }
    }
    func UpdateHardScore(score:Int){
        let docRef = db.collection("HighScores").document("Hard")
        docRef.getDocument { (document, error) in
            if let document = document, document.exists,
                let gold = document.get("Gold") as? Int,
                let silver = document.get("Silver") as? Int,
                let bronze = document.get("Bronze") as? Int {
                
                if score >= gold{
                    if score == gold {
                        docRef.setData(["Gold" : score, "Silver" : silver, "Bronze" : bronze])
                    }
                    else{
                        docRef.setData(["Gold" : score, "Silver" : gold, "Bronze" : silver])
                    }
                    
                }
                else if score >= silver{
                    if score == silver {
                        docRef.setData(["Gold" : gold, "Silver" : score, "Bronze" : bronze])
                    }
                    else{
                        docRef.setData(["Gold" : gold, "Silver" : score, "Bronze" : silver])
                    }
                }
                else if score >= bronze{
                    docRef.setData(["Gold" : gold, "Silver" : silver, "Bronze" : score])
                }
            } else {
                print("Document does not exist")
            }
        }
    }
   
}
