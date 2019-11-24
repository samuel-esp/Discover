//
//  LaunchScreenViewController.swift
//  Discover
//
//  Created by Samuel Esposito on 24/11/2019.
//  Copyright © 2019 Samuel Esposito. All rights reserved.
//

import UIKit
import FirebaseAuth

class LaunchScreenViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        isUserLogged()
        Timer.scheduledTimer(withTimeInterval: 4, repeats: false) { (timer) in
            self.performSegue(withIdentifier: "initialSegue", sender: self)
            return
        }
    }
    
    func isUserLogged() -> Void {
        
        if(Auth.auth().currentUser != nil){
            Timer.scheduledTimer(withTimeInterval: 4, repeats: false) { (timer) in
                self.performSegue(withIdentifier: "launchScreenSegue", sender: self)
                return
            }
        }
        
        return
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
