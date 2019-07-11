//
//  SignInViewController.swift
//  DemoApp
//
//  Created by julio vargas bautista on 7/8/19.
//  Copyright © 2019 Platzi. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase
import GoogleSignIn
class SignInViewController: UIViewController, GIDSignInUIDelegate {
    

    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
       GIDSignIn.sharedInstance().uiDelegate = self
        // Do any additional setup after loading the view.
    }
    

    @IBAction func SignIn(_ sender: Any) {
        SignInViewModel.signInWith(
            email: emailTextField.text,
            password: passwordTextField.text
        ) { [weak self] success, error in
            
            if let error = error {
                let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
                let ok = UIAlertAction(title: "Ok", style: .default, handler: nil)
                alert.addAction(ok)
                self?.present(alert, animated: true, completion: nil)
                return
            }
            
            if success {
                self?.performSegue(withIdentifier: "goToMain", sender: self)
            }
        }
    }
    
    @IBAction func googleSignIn(_ sender: Any) {
        GIDSignIn.sharedInstance().signIn()
    }
    @IBAction func facebookLogin(_ sender: Any) {
        SignInViewModel.facebookLogin(viewController: self, handler: { [weak self] (success, error) in
            if let error = error {
                let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
                let ok = UIAlertAction(title: "Ok", style: .default, handler: nil)
                alert.addAction(ok)
                self?.present(alert, animated: true, completion: nil)
                return
            }
            
            if success {
                self?.performSegue(withIdentifier: "goToMain", sender: self)
            }
        })
    }
    
}
