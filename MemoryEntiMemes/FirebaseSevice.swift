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
    
    func ReadEasyScore(completion: @escaping ([Int])->(Void)){
        let docRef = db.collection("HighScores").document("Easy")
        docRef.getDocument { (document, error) in
            if let document = document, document.exists,
                let gold = document.get("Gold") as? Int,
                let silver = document.get("Silver") as? Int,
                let bronze = document.get("Bronze") as? Int {
                
                var easyList = [Int]()
                easyList[0] = gold
                easyList[1] = silver
                easyList[2] = bronze
                //let dataDescription = document.data().map(String.init(describing:)) ?? "nil"
                completion(easyList)
            } else {
                print("Document does not exist")
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
                
                //let dataDescription = document.data().map(String.init(describing:)) ?? "nil"
                
                if score >= gold{
                    docRef.setData(["Gold" : score])
                    print("Document data: \(gold)")
                }
                else if score >= silver{
                    docRef.setData(["Silver" : score])
                    print("Document data: \(silver)")
                }
                else if score >= bronze{
                    docRef.setData(["Bronze" : score])
                    print("Document data: \(bronze)")
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
                
                //let dataDescription = document.data().map(String.init(describing:)) ?? "nil"
                
                if score >= gold{
                    docRef.setData(["Gold" : score])
                    print("Document data: \(gold)")
                }
                else if score >= silver{
                    docRef.setData(["Silver" : score])
                    print("Document data: \(silver)")
                }
                else if score >= bronze{
                    docRef.setData(["Bronze" : score])
                    print("Document data: \(bronze)")
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
                
                //let dataDescription = document.data().map(String.init(describing:)) ?? "nil"
                
                if score >= gold{
                    docRef.setData(["Gold" : score])
                    print("Document data: \(gold)")
                }
                else if score >= silver{
                    docRef.setData(["Silver" : score])
                    print("Document data: \(silver)")
                }
                else if score >= bronze{
                    docRef.setData(["Bronze" : score])
                    print("Document data: \(bronze)")
                }
            } else {
                print("Document does not exist")
            }
        }
    }
   
}
