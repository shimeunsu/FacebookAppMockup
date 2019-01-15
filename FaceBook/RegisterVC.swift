//
//  RegisterVC.swift
//  FaceBook
//
//  Created by Eun Su Shim on 2018-12-02.
//  Copyright © 2018 Eun Su Shim. All rights reserved.
//

import UIKit

class RegisterVC: UIViewController {

//cons objs
    @IBOutlet weak var contentView_width: NSLayoutConstraint!
    @IBOutlet weak var emailView_width: NSLayoutConstraint!
    @IBOutlet weak var nameView_width: NSLayoutConstraint!
    @IBOutlet weak var passwordView_width: NSLayoutConstraint!
    @IBOutlet weak var birthdayView_width: NSLayoutConstraint!
    @IBOutlet weak var genderView_width: NSLayoutConstraint!

    //UIobjs
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
    @IBOutlet weak var femaileGenderButton: UIButton!
    @IBOutlet weak var maleGenderButton: UIButton!
    
    @IBOutlet weak var footerView: UIView!
    
    //cod obj
    var datePicker: UIDatePicker!
    
    //first loading function when the page is loaded
    override func viewDidLoad() {
        super.viewDidLoad()
        
        contentView_width.constant = self.view.frame.width * 5
        emailView_width.constant = self.view.frame.width
        nameView_width.constant = self.view.frame.width
        passwordView_width.constant = self.view.frame.width
        birthdayView_width.constant = self.view.frame.width
        genderView_width.constant = self.view.frame.width
        
        //make corner of the obj rounded
        cornerRadius(for: emailTextField)
        cornerRadius(for: firstNameTextField)
        cornerRadius(for: lastNameTextField)
        cornerRadius(for: passwordTextField)
        cornerRadius(for: birthdayTextField)
        
        cornerRadius(for: emailContinueButton)
        cornerRadius(for: fullnameContinueButton)
        cornerRadius(for: passwordTextField)
        cornerRadius(for: birthdayContinueButton)
        cornerRadius(for: femaileGenderButton)
        cornerRadius(for: maleGenderButton)
        
        //apply padding to the textfields
        padding(for: emailTextField)
        padding(for: firstNameTextField)
        padding(for: lastNameTextField)
        padding(for: birthdayTextField)
        padding(for: passwordTextField)
    
        
        //run function for configu for footer
        //configure_footerView()
        
        
        //implement birthday picker textfield
        datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.maximumDate = Calendar.current.date(byAdding: .year, value: -5, to: Date())
        datePicker.addTarget(self, action: #selector(self.datePickerDidChange(_:)), for: .valueChanged)
        birthdayTextField.inputView = datePicker
        
        //implemntation of Swipe Gesture
        
        let swipe = UISwipeGestureRecognizer(target: self, action: #selector( self.handle(_:)))
        swipe.direction = .right
        self.view.addGestureRecognizer(swipe)
    }
    
    override func viewDidLayoutSubviews() {
       super.viewDidLayoutSubviews()
        
        DispatchQueue.main.async{
        self.configure_buttons(gender: self.femaileGenderButton)
        self.configure_buttons(gender: self.maleGenderButton)
        }
        
    }
    //make corners rounded for any views (objects)
    func cornerRadius(for view: UIView) {
        view.layer.cornerRadius = 5
        view.layer.masksToBounds = true
        
    }
    // add blank view to the left side of the text field
    func padding(for textField: UITextField){
        let blankView = UIView.init(frame: CGRect(x: 0, y: 0, width: 10, height: 20))
        textField.leftView = blankView
        textField.leftViewMode = .always
    
    }
    
    func configure_footerView(){
        let topLine = CALayer()
        topLine.borderWidth = 2
        topLine.borderColor = UIColor.lightGray.cgColor
        topLine.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: 1)
        
        footerView.layer.addSublayer(topLine)
        
    }
    //configuring the appearance of the gender button
    func configure_buttons(gender button: UIButton){
        let border = CALayer()
        border.borderWidth = 1
        border.borderColor = UIColor.lightGray.cgColor
        border.frame = CGRect(x: 0, y: 0, width: button.frame.width, height: button.frame.height)
        
        //assign the layer created to the button
        button.layer.addSublayer(border)
        
        //making corners rounded
        button.layer.cornerRadius = 5
        button.layer.masksToBounds = true
    }
    
    //called everytime textfiled get changed 
    @IBAction func textFieldDidChange(_ textField: UITextField) {
        let helper = Helper()
        
        if textField == emailTextField && helper.isValid(email: emailTextField.text!){
            emailContinueButton.isHidden = false
        }
        else if textField == firstNameTextField || textField == lastNameTextField {
            if helper.isValid(name: firstNameTextField.text!) && helper.isValid(name: lastNameTextField.text!){
                fullnameContinueButton.isHidden = false
            }
        }
        else if textField == passwordTextField {
            if passwordTextField.text!.count  >= 6 {
                passwordContinueButton.isHidden = false
            }
        }
    }
    @IBAction func emailContinueButton_clicked(_ sender: Any) {
        //move the screen horizontally
        let position = CGPoint(x: self.view.frame.width , y: 0)
        scrollView.setContentOffset(position, animated: true)
        
        // show new keyboard
        if firstNameTextField.text!.isEmpty{
            firstNameTextField.becomeFirstResponder()
            
        }else if lastNameTextField.text!.isEmpty{
            lastNameTextField.becomeFirstResponder()
            
        }else if firstNameTextField.text!.isEmpty == false && lastNameTextField.text!.isEmpty == false {
            firstNameTextField.resignFirstResponder()
            lastNameTextField.resignFirstResponder()
        }
    }
    
    @IBAction func fullnameContinueButton_clicked(_ sender: Any) {
        //move the screen horizontally
        let position = CGPoint(x: self.view.frame.width * 2 , y: 0)
        scrollView.setContentOffset(position, animated: true)
        
        if passwordTextField.text!.isEmpty{
            passwordTextField.becomeFirstResponder()
        } else if passwordTextField.text!.isEmpty {
            birthdayTextField.resignFirstResponder()
        }
    }
    
    
    @IBAction func passwordContinueButton_clicked(_ sender: Any) {
        //move the screen horizontally
        let position = CGPoint(x: self.view.frame.width * 3 , y: 0)
        scrollView.setContentOffset(position, animated: true)
        
        if birthdayTextField.text!.isEmpty {
            birthdayTextField.becomeFirstResponder()
        }
    }
    // func will be executed whenever any day is selected
    @objc func datePickerDidChange(_ datePicker: UIDatePicker) {
        let formater = DateFormatter()
        formater.dateStyle = DateFormatter.Style.medium
        birthdayTextField.text = formater.string(from: datePicker.date)
        
        let compareDateFormatter = DateFormatter()
        compareDateFormatter.dateFormat = "yyyy/MM/dd HH:mm"
        
        let compareDate = compareDateFormatter.date(from: "2013/01/01 00:01")
        
        if datePicker.date < compareDate! {
            birthdayContinueButton.isHidden = false
        } else {
            birthdayContinueButton.isHidden = true
        }
    }
    
    @IBAction func birthdayContinueButton_clicked(_ sender: Any) {
        //move the screen horizontally
        let position = CGPoint(x: self.view.frame.width * 4 , y: 0)
        scrollView.setContentOffset(position, animated: true)
        // hide keybboard when continue button is hidden
        birthdayTextField.resignFirstResponder()
    }
    // called once swipe to the direction right ->
    @objc func handle(_ gesture: UISwipeGestureRecognizer){
        
        //getting current position of the Scroll View (horizontal position)
        let current_x = scrollView.contentOffset.x
        
        //getting the width of the screen
        let screen_width = self.view.frame.width
        // from current postion of scroll view we come back by width of the scrren
        let new_x = CGPoint(x: current_x - screen_width, y : 0)
        
        if current_x > 0 {
        scrollView.setContentOffset(new_x, animated: true)
        }
        
    }
    // called when the screen is tapped ( outside of any objects)
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        //hide keyboard or stop all editing
        emailTextField.resignFirstResponder()
        firstNameTextField.resignFirstResponder()
        lastNameTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
        birthdayTextField.resignFirstResponder()
    }
    
    @IBAction func genderBButton_Clicked(_ sender: UIButton) {
        //step1. declaring URL of the request; declaring the body to the URL; declaring request with the safest method - POST that no one can grab our information.
        
        let url = URL(string:"http://localhost/fb/register.php")!
        let body = "email=\(emailTextField.text!.lowercased())&firstName=\(firstNameTextField.text!.lowercased())&lastName=\(lastNameTextField.text!.lowercased())&password=\(passwordTextField.text!)&birthday=\(datePicker.date)&gender=\(sender.tag)"
        var request = URLRequest(url: url)
        request.httpBody = body.data(using: .utf8)
        request.httpMethod = "POST"
        
        //step2. execute created above request
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            //error
            let helper = Helper()

            if error != nil {
                let helper = Helper()
                helper.showAlert(title: "Server Error", message: error!.localizedDescription, in : self)
                
                return
            }
            
            // fetch JSON if no error
            do{
                //save mode of casting data
                guard let data = data else{
                    helper.showAlert(title: "Data Error", message: error!.localizedDescription, in: self)
                    return
                }
                //fetching all Json recei ved from the server
                let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? NSDictionary
            //error while fetching JSON
            }catch{
                helper.showAlert(title: "JSON Error", message: error.localizedDescription, in: self)
            }
            
            }.resume()
        
    }
    // executed one any CANCEL (Dimissing) button has been pressed
    @IBAction func cancelButton_clicked(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
        
    }
}
