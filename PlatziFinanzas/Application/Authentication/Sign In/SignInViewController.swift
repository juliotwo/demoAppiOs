//
//  SignInViewController.swift
//  DemoApp
//
//  Created by julio vargas bautista on 7/8/19.
//  Copyright © 2019 Platzi. All rights reserved.
//

import UIKit
import FirebaseAuth
class SignInViewController: UIViewController {
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func SignIn(_ sender: Any) {
        SignInViewModel.signInWith(
            email: emailTextField.text,
            password: passwordTextField.text
        ) { [weak self] (success, error) in
            
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
    

}
