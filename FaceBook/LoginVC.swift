//
//  LoginVC.swift
//  FaceBook
//
//  Created by MacBook Pro on 3/8/18.
//  Copyright © 2018 MacBook Pro. All rights reserved.
//

import UIKit

class LoginVC: UIViewController {
    
    // ui obj
    @IBOutlet weak var textFieldsView: UIView!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var leftLineView: UIView!
    @IBOutlet weak var rightLineView: UIView!
    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet weak var handsImageView: UIImageView!
    
    // constraints obj
    @IBOutlet weak var coverImageView_top: NSLayoutConstraint!
    @IBOutlet weak var whiteIconImageView_y: NSLayoutConstraint!
    @IBOutlet weak var handsImageView_top: NSLayoutConstraint!
    @IBOutlet weak var registerButton_bottom: NSLayoutConstraint!
    
    // cache obj
    var coverImageView_top_cache: CGFloat!
    var whiteIconImageView_y_cache: CGFloat!
    var handsImageView_top_cache: CGFloat!
    var registerButton_bottom_cache: CGFloat!
    
    
    // executed when the scene is loaded
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // caching all values of constraints
        coverImageView_top_cache = coverImageView_top.constant
        whiteIconImageView_y_cache = whiteIconImageView_y.constant
        handsImageView_top_cache = handsImageView_top.constant
        registerButton_bottom_cache = registerButton_bottom.constant
        
        
    }
    
    
    // executed EVERYTIME when view did appear on the screen
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // declaring notification observation in order to catch UIKeyboardWillShow / UIKeyboardWillHide Notification
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: Notification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: Notification.Name.UIKeyboardWillHide, object: nil)
        
    }
    
    
    // executed EVERYTIME when view did disappear from the screen
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // switch off notification center, so it wouldn't in action / running
        NotificationCenter.default.removeObserver(self)
        
        
    }
    
    
    // executed always when the Screen's White Space (anywhere excluding objects) tapped
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        // end editing - hide keyboards
        self.view.endEditing(false)
    }
    
    
    // executed once the keyboard is about to be shown
    @objc func keyboardWillShow(notification: Notification) {
        
        // deducting 75pxls from current Y position (doesn't act till forced)
        coverImageView_top.constant -= 75
        handsImageView_top.constant -= 75
        whiteIconImageView_y.constant += 50
        
        /*
        coverImageView_top.constant = -self.view.frame.width / 5.52
        handsImageView_top.constant = -self.view.frame.width / 5.52
        whiteIconImageView_y.constant = self.view.frame.width / 8.28
        */
        
        // if iOS (app) is able to access keyboard's frame, then change Y position of the Register Button
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            registerButton_bottom.constant += keyboardSize.height
            //registerButton_bottom.constant = self.view.frame.width / 1.75423
        }
        
        // animation function. Whatever in the closures below will be animated
        UIView.animate(withDuration: 0.5) {
            
            self.handsImageView.alpha = 0
            
            // force to update the layout
            self.view.layoutIfNeeded()
            
        }
        
    }
    
    // executed once the keyboard is about to be hidden
    @objc func keyboardWillHide(notification: Notification) {
        
        // returning all objects to its initial positions
        coverImageView_top.constant = coverImageView_top_cache
        handsImageView_top.constant = handsImageView_top_cache
        whiteIconImageView_y.constant = whiteIconImageView_y_cache
        registerButton_bottom.constant = registerButton_bottom_cache
        
        // animation function. Whatever in the closures below will be animated
        UIView.animate(withDuration: 0.5) {
            
            self.handsImageView.alpha = 1
            
            // force to update the layout
            self.view.layoutIfNeeded()
            
        }
        
    }
    
    
    // executed after aligning the objects
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
      
        // calling configure functions to be executed, as they're already declared
        configure_textFieldsView()
        configure_loginBtn()
        configre_orLabel()
        configre_registerButton()
        
    }
    
    
    // this func stores code which configures appearance of the textFields' View
    func configure_textFieldsView() {
        
        // declaring constants to store information which later on will be assigned to certain 'object'
        let width = CGFloat(2)
        let color = UIColor.groupTableViewBackground.cgColor
        
        // creating layer to be a border of the view
        let border = CALayer()
        border.borderWidth = width
        border.borderColor = color
        border.frame = CGRect(x: 0, y: 0, width: textFieldsView.frame.width, height: textFieldsView.frame.height)
        
        // creating layer to be a line in the center of the view
        let line = CALayer()
        line.borderWidth = width
        line.borderColor = color
        line.frame = CGRect(x: 0, y: textFieldsView.frame.height / 2 - width, width: textFieldsView.frame.width, height: width)
        
        // assigning created layers to the view
        textFieldsView.layer.addSublayer(border)
        textFieldsView.layer.addSublayer(line)
        
        // rounded corners
        textFieldsView.layer.cornerRadius = 5
        textFieldsView.layer.masksToBounds = true
        
    }
    
    
    // will configure Login button's appearance
    func configure_loginBtn() {
        
        loginButton.layer.cornerRadius = 5
        loginButton.layer.masksToBounds = true
        //loginButton.isEnabled = false
        
    }
    
    
    // will configure appearance of OR label and its views storing the lines
    func configre_orLabel() {
        
        // shortcuts
        let width = CGFloat(2)
        let color = UIColor.groupTableViewBackground.cgColor
        
        // create Left Line object (layer), by assigning width and color values (constants)
        let leftLine = CALayer()
        leftLine.borderWidth = width
        leftLine.borderColor = color
        leftLine.frame = CGRect(x: 0, y: leftLineView.frame.height / 2 - width, width: leftLineView.frame.width, height: width)
        
        // create Right Line object (layer), by assingning width and color values declared above (for shorter way)
        let rightLine = CALayer()
        rightLine.borderWidth = width
        rightLine.borderColor = color
        rightLine.frame = CGRect(x: 0, y: rightLineView.frame.height / 2 - width, width: rightLineView.frame.width, height: width)
        
        // assign lines (layer objects) to the UI obj (views)
        leftLineView.layer.addSublayer(leftLine)
        rightLineView.layer.addSublayer(rightLine)
        
    }
    
    
    // will configre appearance of Register Button
    func configre_registerButton() {
        
        // creating constant named 'border' of type layer which acts as a border frame
        let border = CALayer()
        border.borderColor = UIColor(red: 68/255, green: 105/255, blue: 176/255, alpha: 1).cgColor
        border.borderWidth = 2
        border.frame = CGRect(x: 0, y: 0, width: registerButton.frame.width, height: registerButton.frame.height)
        
        // assign border to the obj (button)
        registerButton.layer.addSublayer(border)
        
        // rounded corner
        registerButton.layer.cornerRadius = 5
        registerButton.layer.masksToBounds = true
        
    }
    
    
    // executed when the login button is pressed
    @IBAction func loginButton_clicked(_ sender: Any) {
        
        // accessing Helper Class that stores multi-used functions
        let helper = Helper()
        
        // 1st Varification: if etnered text in EmailTextField doesn't match our expression/rule, show alert
        if helper.isValid(email: emailTextField.text!) == false {
            helper.showAlert(title: "Invalid Email", message: "Please enter registered Email address", in: self)
            return
            
        // 2nd Varification: if password is less than 6 chars, then return do not executed further
        } else if passwordTextField.text!.count < 6 {
            helper.showAlert(title: "Invalid Password", message: "Password must contain at least 6 characters", in: self)
            return
        }
        
        // run LoginRequest Function
        loginRequest()
        
    }
    
    
    // sending request to the server for proceeding Log In
    func loginRequest() {
        
        // STEP 1. Declaring URL to be sent request to; declaring the body to be appended to URL (all this managed via request); declaring request to be executed
        let url = URL(string: "http://localhost/fb/login.php")!
        let body = "email=\(emailTextField.text!)&password=\(passwordTextField.text!)"
        var request = URLRequest(url: url)
        request.httpBody = body.data(using: .utf8)
        request.httpMethod = "POST"
        
        // STEP 2. Execute created above request
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            DispatchQueue.main.async {
            
            // accessing Helper Class to access its functions
            let helper = Helper()
            
            // if error occures
            if error != nil {
                helper.showAlert(title: "Server Error", message: error!.localizedDescription, in: self)
                return
            }
            
            // STEP 3. Receive JSON message
            do {
                
                // save mode of casting any data
                guard let data = data else {
                    helper.showAlert(title: "Data Error", message: error!.localizedDescription, in: self)
                    return
                }
                
                // fetching all JSON info received from the server
                let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? NSDictionary
                
                // save mode of casting JSON
                guard let parsedJSON = json else {
                    print("Parsing Error")
                    return
                }
                
                // STEP 4. Create Scenarios
                // Successfully Logged In
                if parsedJSON["status"] as! String == "200" {
                    
                    // go to TabBar
                    
                    helper.instantiateViewController(identifier: "TabBar", animated: true, by: self, completion: nil)
                    currentUser = parsedJSON.mutableCopy() as? NSMutableDictionary
                    UserDefaults.standard.set(currentUser, forKey: "currentUser")
                    UserDefaults.standard.synchronize()
                    
                // Some error occured related to the entered data, like: wrong password, wrong email, etc
                } else {
                    
                    // save mode of casting / checking existance of Server Message
                    if parsedJSON["message"] != nil {
                        let message = parsedJSON["message"] as! String
                        helper.showAlert(title: "Error", message: message, in: self)
                    }
                    
                }
                
                print(parsedJSON)
                
            // error while fetching JSON
            } catch {
                helper.showAlert(title: "JSON Error", message: error.localizedDescription, in: self)
            }
                
            }
            
        }.resume()
        
    }
    
    
}
