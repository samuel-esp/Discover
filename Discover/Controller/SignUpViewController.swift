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

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    @IBOutlet weak var signUpButton: UIButton!
    
    @IBOutlet weak var errorTextField: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        emailTextField.becomeFirstResponder()
        signUpButton.isEnabled = false
        signUpButton.setTitleColor(UIColor.gray, for: UIControl.State.normal)
        handleTextField()
        handleCorrectPasswords()
        usernameTextField.setLeftPaddingPoints(10)
        passwordTextField.setLeftPaddingPoints(10)
        confirmPasswordTextField.setLeftPaddingPoints(10)
        emailTextField.setLeftPaddingPoints(10)
        // Do any additional setup after loading the view.
    }
    
    func handleTextField(){
        
        emailTextField.addTarget(self, action: #selector(SignUpViewController.textFieldDidChange), for: UIControl.Event.editingChanged)
        usernameTextField.addTarget(self, action: #selector(SignUpViewController.textFieldDidChange), for: UIControl.Event.editingChanged)
        passwordTextField.addTarget(self, action: #selector(SignUpViewController.textFieldDidChange), for: UIControl.Event.editingChanged)
        confirmPasswordTextField.addTarget(self, action: #selector(SignUpViewController.textFieldDidChange), for: UIControl.Event.editingChanged)
        
    }
    
    func handleCorrectPasswords(){
        
        passwordTextField.addTarget(self, action: #selector(SignUpViewController.passwordDidMatch), for: UIControl.Event.editingChanged)
        confirmPasswordTextField.addTarget(self, action: #selector(SignUpViewController.passwordDidMatch), for: UIControl.Event.editingChanged)
        
    }
    
    @objc func passwordDidMatch(){
        
        let password = passwordTextField.text
        let confirmPassword = confirmPasswordTextField.text
        
        if(password==confirmPassword){
            self.errorTextField.text = ""
            signUpButton.isEnabled = true
            signUpButton.setTitleColor(UIColor.white, for: UIControl.State.normal)
        }else{
            self.errorTextField.text = "Passwords don't match"
            signUpButton.isEnabled = false
            signUpButton.setTitleColor(UIColor.gray, for: UIControl.State.normal)
        }
        
        
    }
    
    @objc func textFieldDidChange(){
        
        guard let username = usernameTextField.text, !username.isEmpty,
              let email = emailTextField.text, !email.isEmpty,
              let password = passwordTextField.text, !password.isEmpty,
              let confirmPassword = confirmPasswordTextField.text, !confirmPassword.isEmpty else{
                signUpButton.isEnabled = false
                signUpButton.setTitleColor(UIColor.gray, for: UIControl.State.normal)
                return
        }
        
        signUpButton.setTitleColor(UIColor.white, for: UIControl.State.normal)
        signUpButton.isEnabled = true
        
    }
    
    @IBAction func signUpPressed(_ sender: Any) {
        
        Auth.auth().createUser(withEmail: emailTextField.text!, password: passwordTextField.text!, completion: { (user: AuthDataResult?, error: Error?) in
            if (error != nil) {
                self.errorTextField.text = error?.localizedDescription
                print(error?.localizedDescription as Any)
                return //escaping the method if the authentication got an error
            }
            print(user as Any)
            let userID = user?.user.uid //create an userID for my new user
            let databaseRoot = Database.database().reference() //taking the database reference
            let databaseChildUser = databaseRoot.child("users").child(userID!) //appending the users section and the new user to my database
            databaseChildUser.setValue(["username": self.usernameTextField.text, "email": self.emailTextField.text]) //storing the data
            self.performSegue(withIdentifier: "signUpSegue", sender: self)
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

extension UITextField {
    func setLeftPaddingPoints(_ amount:CGFloat){
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
    func setRightPaddingPoints(_ amount:CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.rightView = paddingView
        self.rightViewMode = .always
    }
}
