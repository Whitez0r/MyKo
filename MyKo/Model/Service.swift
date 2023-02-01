//
//  Service.swift
//  MyKo
//
//  Created by Илья Мунгалов on 30.03.2022.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseCore
import FirebaseFirestore

class Service{
    static let shared = Service()
    
    init() {}
    
    //
    
    func createNewUser(_ data: LoginField, completion: @escaping (ResponceCode)->()) {
        Auth.auth().createUser(withEmail: data.email, password: data.password) { [weak self] result, err in
            if err == nil {
                if result != nil {
                    let userId = result?.user.uid
                    let email = data.email
                    let data: [String: Any] = ["email":email]
                    
                    Firestore.firestore().collection("users").document(userId!).setData(data)
                    completion(ResponceCode(code: 1))
                }
            }
            else {
                completion(ResponceCode(code: 0))
            }
        }
    }
    
    func confirmEmail() {
        Auth.auth().currentUser?.sendEmailVerification(completion: { err in
            if err != nil {
                print(err!.localizedDescription)
            }
        })
    }
    
    func authInApp(_ data: LoginField, complection: @escaping (AuthResponce) -> ()) {
        Auth.auth().signIn(withEmail: data.email, password: data.password) { result, err in
            if err != nil {
                complection(.error)
            } else {
                if let result = result {
                    if result.user.isEmailVerified {
                        complection(.success)
                    } else {
                        self.confirmEmail()
                        complection(.noVerify)
                    }
                }
            }
        }
    }
    
    func getUserStatus(){
        // is isset
        // auth?
    }
    
    func getAllUsers(completion: @escaping ([String])-> ()) {
        Firestore.firestore().collection("users").getDocuments { snap, err in
            if err == nil {
                var emailList = [String]()
                if let docs = snap?.documents {
                    for doc in docs {
                        let data = doc.data()
                        let email = data["email"] as! String
                        emailList.append(email)
                    }
                }
                completion(emailList)
            }
        }
    }
    
    //MARK: -- Messanger
    
    func sendMessage(otherId: String?, convoId: String?, message: Message, text: String,  completion: @escaping (Bool) ->()) {
        if convoId == nil {
            //создаем говую переписку
        } else {
            let msg: [String: Any] = [
                "data": Date(),
                "sender": message.sender.senderId,
                "text": text
            ]
            Firestore.firestore().collection("conversations").document(convoId!).collection("messages").addDocument(data: msg) { err in
                if err == nil {
                    completion(true)
                } else {
                    completion(false)
                }
            }
        }
    }
    
    func updateConvo() {
        
        
    }
    
    func getConvoId() {
        
    }
    
    func getAllMessage() {
        
    }
    
    func getOneMessage() {
        
    }
}
