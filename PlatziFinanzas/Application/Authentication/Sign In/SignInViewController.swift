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
        
        
        guard let email = emailTextField.text,
            validate(text: email, regex: "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}") else {
                return
        }
        
        guard let password = passwordTextField.text
            else {
                return
        }
        
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] (result, error) in
            if let error = error {
                let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
                let ok = UIAlertAction(title: "Ok", style: .default, handler: nil)
                alert.addAction(ok)
                self?.present(alert, animated: true, completion: nil)
                return
            }
            
            if result != nil {
                self?.performSegue(withIdentifier: "goToMain", sender: self)
            }
        }
    }
    
    private func validate(text: String, regex: String) -> Bool {
        let range = NSRange(location: 0, length: text.count)
        let regex = try? NSRegularExpression(pattern: regex)
        return regex?.firstMatch(in: text, options: [], range: range) != nil
    }
    

}
