//
//  SignUpViewController.swift
//  Discover
//
//  Created by Samuel Esposito on 23/11/2019.
//  Copyright © 2019 Samuel Esposito. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class SignUpViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func signUpPressed(_ sender: Any) {
        
        Auth.auth().createUser(withEmail: "user@gmail.com", password: "1234", completion: { (user: AuthDataResult?, error: Error?) in
            if (error != nil) {
                return //escaping the method if the authentication got an error
            }
            
            let userID = user?.user.uid //create an userID for my new user
            let databaseRoot = Database.database().reference() //taking the database reference
            let databaseChildUser = databaseRoot.child("users").child(userID!) //appending the users section and the new user to my database
            databaseChildUser.setValue(["username": "username", "email": "email"]) //storing the data
        })
        
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
