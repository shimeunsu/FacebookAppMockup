//
//  LoginVC.swift
//  FaceBook
//
//  Created by Eun Su Shim on 2018-11-09.
//  Copyright © 2018 Eun Su Shim. All rights reserved.
//

import UIKit

class LoginVC: UIViewController {

    //UI Object
    @IBOutlet weak var textFieldsView: UIView!
    @IBOutlet weak var loginButton: UIButton!
    //executed when the scene is loaded
    @IBOutlet weak var leftLineView: UIView!
    @IBOutlet weak var rightLineView: UIView!
    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet weak var handsImageView: UIImageView!
    
    //constraint obj
    @IBOutlet weak var coverImageView_top: NSLayoutConstraint!
    
    @IBOutlet weak var whiteIconImageView_y: NSLayoutConstraint!
    
    @IBOutlet weak var handsViewImageView_top: NSLayoutConstraint!
    
    @IBOutlet weak var registerButton_bottom: NSLayoutConstraint!
    
 //cache objects
     var coverImageView_top_cache: CGFloat!
    
     var whiteIconImageView_y_cache: CGFloat!
    
     var handsViewImageView_top_cache: CGFloat!
    
     var registerButton_bottom_cache: CGFloat!
    
    // executed when the screen is loaded
    override func viewDidLoad() {
       super.viewDidLoad()
        coverImageView_top_cache = coverImageView_top.constant
        
        whiteIconImageView_y_cache = whiteIconImageView_y.constant
        
        
        handsViewImageView_top_cache = handsViewImageView_top.constant
        
        
        registerButton_bottom_cache = registerButton_bottom.constant
        
    }
    // executed EVERYTIME wehn vie did appear on the screen
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        //declaring notification observation in order to catch UIKeyboardWillShow notification
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: Notification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: Notification.Name.UIKeyboardWillHide, object: nil)
    }
    
    //executed EVERYTIME when view did disappear from teh screen
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        //switch off notification center, so it would not bbe in action/ running
        NotificationCenter.default.removeObserver(self)
    }
    //executed alawys when the screen white space is tapped
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(false)
        
    }
    
    
    
    //executed once the keyboard is about to be shown
    @objc func keyboardWillShow(notification: Notification){
        //returning all objects to its inital positions
        
        coverImageView_top.constant = coverImageView_top_cache
        handsViewImageView_top.constant = handsViewImageView_top_cache
        whiteIconImageView_y.constant = whiteIconImageView_y_cache
        
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue{
                registerButton_bottom.constant = registerButton_bottom_cache
        }
        
    
      //animation function. whatever in the clousres below will be animated
        UIView.animate(withDuration: 0.5) {
            self.handsImageView.alpha = 0
            self.view.layoutIfNeeded()
        }
        
        
    }
    //executed once the keyboard is about to be hidden
    @objc func keyboardWillHide(notification: Notification){
        coverImageView_top.constant = coverImageView_top_cache
        handsViewImageView_top.constant = handsViewImageView_top_cache
        whiteIconImageView_y.constant = whiteIconImageView_y_cache
        
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue{
            registerButton_bottom.constant = registerButton_bottom_cache
        }
        //whatever in the clousres belwo will be animated
        UIView.animate(withDuration: 0.5) {
            self.handsImageView.alpha = 1
            self.view.layoutIfNeeded()
        }
    }
    //executed after aligning the objects
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        configure_textFieldsView()
        configure_loginBtn()
        configure_orLabel()
        configure_registerButton()
        
    }

    // this func stores code which confgirues appearance of th etextFields' view

    func configure_textFieldsView(){
    
        // declaring constants to store ifnormation which later on will be assigned to certain objet
        let width = CGFloat(2)
        let color = UIColor.groupTableViewBackground.cgColor
        
        //creating layer to be a border of the view
        let border = CALayer()
        border.borderColor = color
        border.frame = CGRect(x:0, y:0, width: textFieldsView.frame.width, height: textFieldsView.frame.height)
        border.borderWidth = width
        
        // creating layer to be line in the center of the view
        let line = CALayer()
        line.borderWidth = width
        line.borderColor = color
        line.frame = CGRect(x: 0, y: textFieldsView.frame.height / 2 - width, width: textFieldsView.frame.width, height: width)
        
        //assigning created layers to the view
        textFieldsView.layer.addSublayer(border)
        textFieldsView.layer.addSublayer(line)
        
        // rounded corners
        textFieldsView.layer.cornerRadius = 5
        textFieldsView.layer.masksToBounds = true
        
    }

    // will configure login button's appearance
    func configure_loginBtn(){
        
        loginButton.layer.cornerRadius = 5
        loginButton.layer.masksToBounds = true
        loginButton.isEnabled = false
    }
    //will confgirue appearance of OR label and its view storing the lines
    func configure_orLabel() {
        let width = CGFloat(2)
        let color = UIColor.groupTableViewBackground.cgColor
        
        //create aleft line object (layer)
        let leftLine = CALayer()
        leftLine.borderWidth = width
        leftLine.borderColor = color
        leftLine.frame = CGRect(x: 0, y: leftLineView.frame.height / 2 - width , width: leftLineView.frame.width, height: width)
        
        // creating right lin object (layer) by assigning width and color values declared above ( for shorer way)
        let rightLine = CALayer()
        rightLine.borderWidth = width
        rightLine.borderColor = color
        rightLine.frame = CGRect(x: 0, y: rightLineView.frame.height / 2 - width, width: rightLineView.frame.width, height: width)
        
        //assign lines (layer objects) to the UI objects (view)
        leftLineView.layer.addSublayer(leftLine)
        rightLineView.layer.addSublayer(rightLine)
        
    }
    
    func configure_registerButton() {
        
        //creating constant named "border" of type layer which acts as a border frames
        let border = CALayer()
        border.borderColor = UIColor(red: 68/255, green: 105/255, blue: 176/255, alpha: 1).cgColor
        border.borderWidth = 2
        border.frame = CGRect(x: 0, y: 0, width: registerButton.frame.width, height: registerButton.frame.height)
        
        //assign border to do the obj (button)
        
        registerButton.layer.addSublayer(border)
        
        registerButton.layer.cornerRadius = 5
        registerButton.layer.masksToBounds = true
    }

}
