//
//  Helper.swift
//  FaceBook
//
//  Created by MacBook Pro on 3/17/18.
//  Copyright © 2018 MacBook Pro. All rights reserved.
//

import UIKit



class Helper {
    
    
    // validate email address function / logic
    func isValid(email: String) -> Bool {
        
        // declaring the rule of regular expression (chars to be used). Applying the rele to current state. Verifying the result (email = rule)
        let regex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let test = NSPredicate(format: "SELF MATCHES %@", regex)
        let result = test.evaluate(with: email)
        
        return result
    }
    
    
    // validate name function / logic
    func isValid(name: String) -> Bool {
        
        // declaring the rule of regular expression (chars to be used). Applying the rele to current state. Verifying the result (email = rule)
        let regex = "[A-Za-z]{2,}"
        let test = NSPredicate(format: "SELF MATCHES %@", regex)
        let result = test.evaluate(with: name)
        
        return result
    }
    
    
    // show alert message to the user
    func showAlert(title: String, message: String, in vc: UIViewController) {
        
        // creating alertController; creating button to the alertController; assigning button to alertController; presenting alert controller
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
        alert.addAction(ok)
        vc.present(alert, animated: true, completion: nil)
        
    }
    
    
    // allows us to go to another ViewController programmatically
    func instantiateViewController(identifier: String, animated: Bool, by vc: UIViewController, completion: (() -> Void)?) {
        
        // accessing any ViewController from Main.storyboard via ID
        let newViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: identifier)
        
        // presenting accessed ViewController
        vc.present(newViewController, animated: animated, completion: completion)
        
    }
    
    
}






