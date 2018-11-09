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
    
    override func viewDidLoad() {
        super.viewDidLoad()


        
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
