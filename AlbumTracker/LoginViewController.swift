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
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var forgotPassworButton: UIButton!
    var keyboardOut: Bool!
    var constrainSize: CGFloat!
    let gradientLayer = CAGradientLayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor(red: 20/255, green: 87/255, blue: 127/255, alpha: 1.0)
        self.background.backgroundColor = UIColor(red: 20/255, green: 87/255, blue: 127/255, alpha: 1.0)
        self.gradientLayer.frame = self.view.bounds
        
        let darkBlue = UIColor(red: 20/255, green: 87/255, blue: 127/255, alpha: 1.0).CGColor as CGColorRef
        let lightBlue = UIColor(red: 32/255, green: 140/255, blue: 204/255, alpha: 1.0).CGColor as CGColorRef
        gradientLayer.colors = [lightBlue,darkBlue]
        gradientLayer.locations = [0.0,0.5]
        self.background.layer.insertSublayer(gradientLayer,atIndex: 0)

        self.emailField.tag = 0
        self.emailField.placeholder = NSLocalizedString("Login.email", comment: "Email Field")
        self.emailField.backgroundColor = UIColor.whiteColor()
        self.emailField.layer.borderColor = UIColor(white: 0.9, alpha: 0.7).CGColor
        self.emailField.layer.borderWidth = 1.0
        
        let leftViewEmail = UIView(frame: CGRect(x: 0, y: 0, width: 40, height: self.emailField.frame.height))
        self.emailField.leftViewMode = .Always
        self.emailField.leftView = leftViewEmail
        
        self.passwordField.tag = 1
        self.passwordField.placeholder = NSLocalizedString("Login.password", comment: "Password Field")
        self.passwordField.backgroundColor = UIColor.whiteColor()
        self.passwordField.layer.borderColor = UIColor(white: 0.9, alpha: 0.7).CGColor
        self.passwordField.layer.borderWidth = 1.0
        
        let leftViewPassword = UIView(frame: CGRect(x: 0, y: 0, width: 40, height: self.passwordField.frame.height))
        self.passwordField.leftViewMode = .Always
        self.passwordField.leftView = leftViewPassword
        
        self.loginButton.tintColor = UIColor.whiteColor()
        self.loginButton.backgroundColor = UIColor(red: 32/255, green: 140/255, blue: 204/255, alpha: 1.0)
        self.loginButton.setTitle(NSLocalizedString("Login.login", comment: "Login Button"), forState: .Normal)
        self.loginButton.layer.cornerRadius = 3.0
        
        self.signupButton.tintColor = UIColor.whiteColor()
        self.signupButton.setTitle(NSLocalizedString("Login.create_account", comment: "Create Account Button"), forState: .Normal)
        self.signupButton.layer.borderColor = UIColor.whiteColor().CGColor
        self.signupButton.layer.borderWidth = 0.7
        self.signupButton.layer.cornerRadius = 3.0
        
        self.forgotPassworButton.tintColor = UIColor.whiteColor()
        self.forgotPassworButton.setTitle(NSLocalizedString("Login.forgot_password", comment: "Forgot Password Button"), forState: .Normal)
        self.forgotPassworButton.layer.borderColor = UIColor.whiteColor().CGColor
        self.forgotPassworButton.layer.borderWidth = 0.7
        self.forgotPassworButton.layer.cornerRadius = 3.0
        
        self.keyboardOut = false
    }
    
    override func viewDidLayoutSubviews() {
        let topPath = UIBezierPath(roundedRect:self.passwordField.bounds, byRoundingCorners:[UIRectCorner.TopLeft, UIRectCorner.TopRight], cornerRadii:CGSizeMake(3.0,3.0))
        let topMaskLayer = CAShapeLayer()
        topMaskLayer.path = topPath.CGPath
        self.emailField.layer.mask = topMaskLayer
        
        let bottomPath = UIBezierPath(roundedRect:self.passwordField.bounds, byRoundingCorners:[UIRectCorner.BottomLeft, UIRectCorner.BottomRight], cornerRadii:CGSizeMake(3.0,3.0))
        let bottomMaskLayer = CAShapeLayer()
        bottomMaskLayer.path = bottomPath.CGPath
        self.passwordField.layer.mask = bottomMaskLayer
    }
    
    override func viewDidAppear(animated: Bool) {
        self.registerKeyboardNotifications()
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(true)
        self.deregisterKeyboardNotifications()
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }
    
    func registerKeyboardNotifications() {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(self.keyboardAppeared(_:)), name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(self.keyboardDisappeared(_:)), name: UIKeyboardWillHideNotification, object: nil)
    }
    
    func deregisterKeyboardNotifications () {
        let center: NSNotificationCenter = NSNotificationCenter.defaultCenter()
        center.removeObserver(self, name: UIKeyboardDidHideNotification, object: nil)
        center.removeObserver(self, name: UIKeyboardWillHideNotification, object: nil)
    }
    
    func keyboardAppeared(notification: NSNotification){
        let info = notification.userInfo!
        let kbSize = (info[UIKeyboardFrameBeginUserInfoKey])!.CGRectValue.size

        UIView.animateWithDuration (1, animations: {
            if self.keyboardOut == false {
                self.bottomConstraint.constant = kbSize.height/2
                self.keyboardOut = true
            }
            self.view.layoutIfNeeded()
        })
    }
    
    func keyboardDisappeared(notification: NSNotification){
        UIView.animateWithDuration (1, animations: {
            if self.keyboardOut == true {
                self.bottomConstraint.constant = 0
                self.keyboardOut = false
            }
            self.view.layoutIfNeeded()
        })
    }
    
    @IBAction func dismissKeboard(sender: AnyObject) {
        self.emailField.resignFirstResponder()
        self.passwordField.resignFirstResponder()
    }
}
