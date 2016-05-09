//
//  LoginViewController.swift
//  AlbumTracker
//
//  Created by Itallo Rossi Lucas on 5/9/16.
//  Copyright © 2016 AlbumTrackr. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var signupButton: UIButton!
    @IBOutlet weak var background: UIView!
    
    let gradientLayer = CAGradientLayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.background.backgroundColor = UIColor(red: 20/255, green: 87/255, blue: 127/255, alpha: 1.0)
        self.gradientLayer.frame = self.view.bounds

        self.emailField.tag = 0
//        self.username.delegate = self
        self.emailField.placeholder = "Email"
        self.emailField.backgroundColor = UIColor.whiteColor()
        self.emailField.layer.borderColor = UIColor(white: 0.9, alpha: 0.7).CGColor
        self.emailField.layer.borderWidth = 1.0

        let leftViewEmail = UIView(frame: CGRect(x: 0, y: 0, width: 41, height: 20))
        self.emailField.leftViewMode = .Always
        self.emailField.leftView = leftViewEmail
        
        self.passwordField.tag = 1
        //        self.username.delegate = self
        self.passwordField.placeholder = "Password"
        self.passwordField.backgroundColor = UIColor.whiteColor()
        self.passwordField.layer.borderColor = UIColor(white: 0.9, alpha: 0.7).CGColor
        self.passwordField.layer.borderWidth = 1.0
        
        let leftViewPassword = UIView(frame: CGRect(x: 0, y: 0, width: 41, height: 20))
        self.passwordField.leftViewMode = .Always
        self.passwordField.leftView = leftViewPassword
        
        self.loginButton.tintColor = UIColor.whiteColor()
        self.loginButton.backgroundColor = UIColor(red: 32/255, green: 140/255, blue: 204/255, alpha: 1.0)
        self.loginButton.setTitle("Login", forState: .Normal)
        
        self.signupButton.tintColor = UIColor.whiteColor()
        self.signupButton.setTitle("Create Account", forState: .Normal)
    }
}
