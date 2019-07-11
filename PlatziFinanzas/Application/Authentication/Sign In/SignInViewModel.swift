//
//  SignInViewModel.swift
//  DemoApp
//
//  Created by julio vargas bautista on 7/8/19.
//  Copyright © 2019 Platzi. All rights reserved.
//

import Foundation
import FirebaseAuth
import FBSDKLoginKit
import Firebase
import GoogleSignIn
typealias SignInHandler = ( (_ success: Bool, _ error: Error?) -> Void )


class SignInViewModel: NSObject {
    static func signInWith(email: String?, password: String?, handler: SignInHandler?) {
        guard let email = email,
            validate(text: email, regex: "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}") else {
                return
        }
        
        guard let password = password else {
                return
        }
        
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            if let error = error {
                handler?(false, error)
            }

            if result != nil {
                handler?(true, nil)
                print(result!.user.refreshToken ?? "hola")
            }
        }
        
    }
    
    static private func validate(text: String, regex: String) -> Bool {
        let range = NSRange(location: 0, length: text.count)
        let regex = try? NSRegularExpression(pattern: regex)
        return regex?.firstMatch(in: text, options: [], range: range) != nil
    }
    
    static func googleLogin(user:GIDGoogleUser?, handler:SignInHandler?){
        guard let authentication = user?.authentication else { return }
        let credential = GoogleAuthProvider.credential(withIDToken: authentication.idToken,
                                                       accessToken: authentication.accessToken)
        
        Auth.auth().signInAndRetrieveData(with: credential) {  (authResult, error)in
            if let error = error {
                handler?(false,error)
            }
            if authResult != nil {
                handler?(true, nil)
            }
           
        }
        
    }
    static func facebookLogin(viewController: UIViewController, handler: SignInHandler?) {
        FBSDKLoginManager().logIn(withReadPermissions: ["email"], from: viewController) { (result, error) in
            if let error = error {
                handler?(false, error)
                return
            }
            
            guard let token = FBSDKAccessToken.current()?.tokenString else { return }
            let credentials = FacebookAuthProvider.credential(withAccessToken: token)
            Auth.auth().signInAndRetrieveData(with: credentials, completion: { (authResult, error) in
                
                handler?(true, nil)
            })
        }
    }
}
