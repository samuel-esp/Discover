//
//  SignInViewController.swift
//  Discover
//
//  Created by Samuel Esposito on 22/11/2019.
//  Copyright © 2019 Samuel Esposito. All rights reserved.
//

import UIKit
import FirebaseAuth

class SignInViewController: UIViewController {

    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var errorTextField: UILabel!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        emailTextField.becomeFirstResponder()
        signInButton.isEnabled = false
        emailTextField.setLeftPaddingPoints(10)
        passwordTextField.setLeftPaddingPoints(10)
        signInButton.setTitleColor(UIColor.gray, for: UIControl.State.normal)
        handleTextField()
        
        
        // Do any additional setup after loading the view.
    }
    
    func handleTextField(){
        
        emailTextField.addTarget(self, action: #selector(SignInViewController.credentialsDidChange), for: UIControl.Event.editingChanged)
        passwordTextField.addTarget(self, action: #selector(SignInViewController.credentialsDidChange), for: UIControl.Event.editingChanged)
        
        
        
    }
    
    @objc func credentialsDidChange(){
        
        guard let username = emailTextField.text, !username.isEmpty,
            let password = passwordTextField.text, !password.isEmpty else{
                
                signInButton.setTitleColor(UIColor.gray, for: UIControl.State.normal)
                signInButton.isEnabled = false
                return
        }
        
        signInButton.setTitleColor(UIColor.white, for: UIControl.State.normal)
        signInButton.isEnabled = true
        
    }

    @IBAction func signInButtonPressed(_ sender: Any) {
        
        Auth.auth().signIn(withEmail: emailTextField.text!, password: passwordTextField.text!) { (user, error) in
            if(error != nil){
                self.errorTextField.text = error?.localizedDescription
                print(error as Any)
                return
            }
            self.performSegue(withIdentifier: "signInSegue", sender: self)
        }
        
    }
    
}
