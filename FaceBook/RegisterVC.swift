//
//  RegisterVC.swift
//  FaceBook
//
//  Created by MacBook Pro on 3/11/18.
//  Copyright © 2018 MacBook Pro. All rights reserved.
//

import UIKit

class RegisterVC: UIViewController {

    // cons obj
    @IBOutlet weak var contentView_width: NSLayoutConstraint!
    @IBOutlet weak var emailView_width: NSLayoutConstraint!
    @IBOutlet weak var nameView_width: NSLayoutConstraint!
    @IBOutlet weak var passwordView_width: NSLayoutConstraint!
    @IBOutlet weak var birthdayView_width: NSLayoutConstraint!
    @IBOutlet weak var genderView_width: NSLayoutConstraint!
    
    // ui obj
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var birthdayTextField: UITextField!
    
    @IBOutlet weak var emailContinueButton: UIButton!
    @IBOutlet weak var fullnameContinueButton: UIButton!
    @IBOutlet weak var passwordContinueButton: UIButton!
    @IBOutlet weak var birthdayContinueButton: UIButton!
    
    @IBOutlet weak var femaleGenderButton: UIButton!
    @IBOutlet weak var maleGenderButton: UIButton!
    
    @IBOutlet weak var footerView: UIView!
    
    // code obj
    var datePicker: UIDatePicker!
    
    
    
    // first load func when the page is loaded
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // adjust width of the views to the screen of the device
        contentView_width.constant = self.view.frame.width * 5
        emailView_width.constant = self.view.frame.width
        nameView_width.constant = self.view.frame.width
        passwordView_width.constant = self.view.frame.width
        birthdayView_width.constant = self.view.frame.width
        genderView_width.constant = self.view.frame.width
        
        
        // make corners of the objects rounded
        cornerRadius(for: emailTextField)
        cornerRadius(for: firstNameTextField)
        cornerRadius(for: lastNameTextField)
        cornerRadius(for: passwordTextField)
        cornerRadius(for: birthdayTextField)
        cornerRadius(for: emailContinueButton)
        cornerRadius(for: fullnameContinueButton)
        cornerRadius(for: passwordContinueButton)
        cornerRadius(for: birthdayContinueButton)
        
        
        // apply padding to the textFields
        padding(for: emailTextField)
        padding(for: firstNameTextField)
        padding(for: lastNameTextField)
        padding(for: passwordTextField)
        padding(for: birthdayTextField)
        
        
        // run function of configuration
        configure_footerView()
        
        
        // creating, configuring and implementing datePicker into BirthdayTextField
        datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.maximumDate = Calendar.current.date(byAdding: .year, value: -5, to: Date())
        datePicker.addTarget(self, action: #selector(self.datePickerDidChange(_:)), for: .valueChanged)
        birthdayTextField.inputView = datePicker
        
        
        // implementation of Swipe Gesture
        let swipe = UISwipeGestureRecognizer(target: self, action: #selector(self.handle(_:)))
        swipe.direction = .right
        self.view.addGestureRecognizer(swipe)
        
    }
    
    
    // executed once the Auto-Layout has been applied / executed
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        // run all the func assync-ly / parallelly once the main tasks are completed
        DispatchQueue.main.async {
            // fun function to configure the appearance
            self.configure_button(gender: self.maleGenderButton)
            self.configure_button(gender: self.femaleGenderButton)
        }

    }
    
    
    // make corners rounded for any views (objects)
    func cornerRadius(for view: UIView) {
        view.layer.cornerRadius = 5
        view.layer.masksToBounds = true
    }
    
    
    // add blank view to the left side of the TextField (it'll act as a blank gap)
    func padding(for textField: UITextField) {
        
        let blankView = UIView.init(frame: CGRect(x: 0, y: 0, width: 10, height: 20))
        textField.leftView = blankView
        textField.leftViewMode = .always
        
    }
    
    
    // configuring the appearance of the footerView
    func configure_footerView() {
        
        // adding the line at the top of the footerView
        let topLine = CALayer()
        topLine.borderWidth = 1
        topLine.borderColor = UIColor.lightGray.cgColor
        topLine.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: 1)
        
        footerView.layer.addSublayer(topLine)
        
    }
    
    
    // cinfiguring the appearance of the gender buttons
    func configure_button(gender button: UIButton) {
        
        // creating constant with name border which's of type CALayer (it can execute func-s of CALayer Class)
        let border = CALayer()
        border.borderWidth = 1.5
        border.borderColor = UIColor.lightGray.cgColor
        border.frame = CGRect(x: 0, y: 0, width: button.frame.width, height: button.frame.height)
        
        // assign the layer created to the button
        button.layer.addSublayer(border)
        
        // making corners rounded
        button.layer.cornerRadius = 5
        button.layer.masksToBounds = true
        
    }
    
    
    // called everytime when textField gets changed
    @IBAction func textFieldDidChange(_ textField: UITextField) {
        
        // declaring constant (shortcut) to the Helper Class
        let helper = Helper()
        
        // logic for Email TextField
        if textField == emailTextField {
            
            // check email validation
            if helper.isValid(email: emailTextField.text!) {
                emailContinueButton.isHidden = false
            }
            
        // logic for First Name or Last Name TextFields
        } else if textField == firstNameTextField || textField == lastNameTextField {
            
            // check fullname validation
            if helper.isValid(name: firstNameTextField.text!) && helper.isValid(name: lastNameTextField.text!) {
                fullnameContinueButton.isHidden = false
            }
            
        // logic for Password TextField
        } else if textField == passwordTextField {
            
            // check password validation
            if passwordTextField.text!.count >= 6 {
                passwordContinueButton.isHidden = false
            }
        }
        
    }
    
    
    
    // called once Continue button is pressed on Email Page
    @IBAction func emailContinueButton_clicked(_ sender: Any) {
        
        // move scrollView horizontally (by X to the WIDTH as a pointer)
        let position = CGPoint(x: self.view.frame.width, y: 0)
        scrollView.setContentOffset(position, animated: true)
        
        // show keyboard of next TextField
        if firstNameTextField.text!.isEmpty {
            firstNameTextField.becomeFirstResponder()
        } else if lastNameTextField.text!.isEmpty {
            lastNameTextField.becomeFirstResponder()
        } else if firstNameTextField.text!.isEmpty == false && lastNameTextField.text!.isEmpty == false {
            firstNameTextField.resignFirstResponder()
            lastNameTextField.resignFirstResponder()
        }
        
    }
    
    
    // called once Continue button is pressed Fullname Page
    @IBAction func fullnameContinueButton_clicked(_ sender: Any) {
        
        // move scrollView horizontally (by X to the 2x WIDTH as a pointer)
        let position = CGPoint(x: self.view.frame.width * 2, y: 0)
        scrollView.setContentOffset(position, animated: true)
        
        // show keyboard of next TextField
        if passwordTextField.text!.isEmpty {
            passwordTextField.becomeFirstResponder()
        } else if passwordTextField.text!.isEmpty == false {
            passwordTextField.resignFirstResponder()
        }
        
    }
    
    
    // called once Continue button is pressed Password Page
    @IBAction func passwordContinueButton_clicked(_ sender: Any) {
        
        // move scrollView horizontally (by X to the 3x WIDTH as a pointer)
        let position = CGPoint(x: self.view.frame.width * 3, y: 0)
        scrollView.setContentOffset(position, animated: true)
        
        // show keyboard of next TextField
        if birthdayTextField.text!.isEmpty {
            birthdayTextField.becomeFirstResponder()
        } else if birthdayTextField.text!.isEmpty == false {
            birthdayTextField.resignFirstResponder()
        }
        
    }
    
    
    // func will be executed whenever any date is selected
    @objc func datePickerDidChange(_ datePicker: UIDatePicker) {
        
        // declaring the format to be used in TextField while presenting the date
        let formatter = DateFormatter()
        formatter.dateStyle = DateFormatter.Style.medium
        birthdayTextField.text = formatter.string(from: datePicker.date)
        
        // declaring the format of date, then to place a dummy date into this format
        let compareDateFormatter = DateFormatter()
        compareDateFormatter.dateFormat = "yyyy/MM/dd HH:mm"
        let compareDate = compareDateFormatter.date(from: "2013/01/01 00:01")
        
        // IF logic. If user is older than 5 years, show Continue Button
        if datePicker.date < compareDate! {
            birthdayContinueButton.isHidden = false
        } else {
            birthdayContinueButton.isHidden = true
        }
        
    }
    
    
    // called once Continue button is pressed Birthday Page
    @IBAction func birthdayContinueButton_clicked(_ sender: Any) {
        
        // move scrollView horizontally (by X to the 4x WIDTH as a pointer)
        let position = CGPoint(x: self.view.frame.width * 4, y: 0)
        scrollView.setContentOffset(position, animated: true)
        
        // hide keyboard when Continue button on Birthday Page is clicked
        birthdayTextField.resignFirstResponder()
    }
    
    
    // called once Swiped to the direction Right ->
    @objc func handle(_ gesture: UISwipeGestureRecognizer) {
        
        // getting current position of the ScrollView (horizontal position)
        let current_x = scrollView.contentOffset.x
        
        // getting the width of the screen (deduct this size)
        let screen_width = self.view.frame.width
        
        // from current position of ScrollView, we comeback by width of the screen
        let new_x = CGPoint(x: current_x - screen_width, y: 0)
        
        // ... until unless it's more than 0 (0 - 1st page)
        if current_x > 0 {
            scrollView.setContentOffset(new_x, animated: true)
        }
        
    }
    
    
    // This function is executed whenever Male / Female button has been clicked
    @IBAction func genderButton_clicked(_ sender: UIButton) {
        
        // STEP 1. Declaring URL of the request; declaring the body to the URL; declaring request with the safest method - POST, that no one can grab our info.
        let url = URL(string: "http://localhost/fb/register.php")!
        let body = "email=\(emailTextField.text!.lowercased())&firstName=\(firstNameTextField.text!.lowercased())&lastName=\(lastNameTextField.text!.lowercased())&password=\(passwordTextField.text!)&birthday=\(datePicker.date)&gender=\(sender.tag)"
        var request = URLRequest(url: url)
        request.httpBody = body.data(using: .utf8)
        request.httpMethod = "POST"
        
        // STEP 2. Execute created above request
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            // access helper class
            let helper = Helper()
            
            // error
            if error != nil {
                helper.showAlert(title: "Server Error", message: error!.localizedDescription, in: self)
                return
            }
            
            // fetch JSON if no error
            do {
                
                // save mode of casting data
                guard let data = data else {
                    helper.showAlert(title: "Data Error", message: error!.localizedDescription, in: self)
                    return
                }
                
                // fetching all JSON received from the server
                let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? NSDictionary
                
                // save mode of casting JSON
                guard let parsedJSON = json else {
                    print("Parsing Error")
                    return
                }
                
                
                // STEP 4. Create Scenarious
                // Successfully Registered In
                if parsedJSON["status"] as! String == "200" {
                    
                    // go to TabBar
                      helper.instantiateViewController(identifier: "TabBar", animated: true, by: self, completion: nil) 
                    
                // Some error occured related to the entered data, like: wrong password, wrong email, etc
                } else {
                    
                    // save mode of casting / checking existance of Server Message
                    if parsedJSON["message"] != nil {
                        let message = parsedJSON["message"] as! String
                        helper.showAlert(title: "Error", message: message, in: self)
                    }
                    
                }
                
                
            // error while fetching JSON
            } catch {
                helper.showAlert(title: "JSON Error", message: error.localizedDescription, in: self)
            }
            
            
        }.resume()
        
        
    }
    
    
    // executed once any CANCEL (DISMISSING) button has been pressed
    @IBAction func cancelButton_clicked(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
}
