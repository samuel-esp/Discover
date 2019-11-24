//
//  AuthService.swift
//  Discover
//
//  Created by Samuel Esposito on 24/11/2019.
//  Copyright © 2019 Samuel Esposito. All rights reserved.
//

import Foundation
import FirebaseAuth

class AuthService{
    
    static let shared = AuthService()
    
    func signIn(withEmail: String, password: String) -> String? {
        
        var result: String?
        
        Auth.auth().signIn(withEmail: withEmail, password: password) { (user, error) in
            if(error != nil){
                result = error?.localizedDescription
                return
            }
        }
        
        return result
    }
    
    
}
