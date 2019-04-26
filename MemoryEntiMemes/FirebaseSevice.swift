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
    let k_COLLECTION_SCORE = "score"
    let db = Firestore.firestore()
    
    func writeUserScore(score: Int, username: String?, userId: String) {
        // Si no existe la collection la crea, no pasa con los document.
        db.collection(k_COLLECTION_SCORE)
            .addDocument(data: ["score": score, "username": username ?? "", "userId": userId])
    }
    
    func updateUserScore(score: Int, username: String?, userId: String) {
        // Si el documento ya existe lo sobreescribe, si no lo crea.
        // [merge: true] sobreescribe la info que se le pasa y mantiene la que exista en otros campos.
        db.collection(k_COLLECTION_SCORE)
            .document(userId)
            .setData(["score": score, "username": username ?? "", "userId": userId])
    }
    
    func readUserScore() {
        db.collection(k_COLLECTION_SCORE)
            .whereField("score", isGreaterThan: 0)
            .getDocuments {(snapshot, error) in
                
                //Es necesario un sistem de control de error.
                if let error = error {
                    print("Not connecting to DB with error: ", error)
                } else {
                    snapshot?.documents.forEach({ print($0.data()) })
                }
        }
    }
}
