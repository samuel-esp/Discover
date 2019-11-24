//
//  HomeViewController.swift
//  Discover
//
//  Created by Samuel Esposito on 23/11/2019.
//  Copyright © 2019 Samuel Esposito. All rights reserved.
//

import UIKit
import FirebaseAuth

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func logOutButtonPressed(_ sender: Any) {
        
        do{
            try Auth.auth().signOut()
        }catch let error{
            print(error)
        }
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let signInVC = storyboard.instantiateViewController(identifier: "SignInViewController")
        self.present(signInVC, animated: true, completion: nil)
        
    }
    
    

}
