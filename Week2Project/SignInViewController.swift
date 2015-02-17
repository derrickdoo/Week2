//
//  SignInViewController.swift
//  Week2Project
//
//  Created by Derrick Or on 2/16/15.
//  Copyright (c) 2015 derrickor. All rights reserved.
//

import UIKit

class SignInViewController: UIViewController {
    
    @IBOutlet weak var buttonsView: UIView!
    @IBOutlet weak var prompt: UIImageView!
    @IBOutlet weak var formView: UIView!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillShow:", name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillHide:", name: UIKeyboardWillHideNotification, object: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func tappedEmailField(sender: AnyObject) {
    }
    
    @IBAction func tappedPasswordField(sender: AnyObject) {
    }
    
    @IBAction func tapView(sender: AnyObject) {
        self.view.endEditing(true)
    }

    @IBAction func tapSignin(sender: AnyObject) {
        if(!self.emailField.hasText()) {
            var alertView = UIAlertView(title: "Email Required", message: "Please enter an email and try again", delegate: self, cancelButtonTitle: "OK")
            alertView.show()
        }
        else {
            if(self.emailField.text == "derrickor@gmail.com" && self.passwordField.text == "password") {
                var alertView = UIAlertView(title: "Signin in...", message: nil, delegate: self, cancelButtonTitle: nil)
                alertView.show()
            
                delay(2) {
                    alertView.dismissWithClickedButtonIndex(0, animated: true)
                
                    var vc = self.storyboard?.instantiateViewControllerWithIdentifier("tutorialView") as TutorialViewController
                    self.presentViewController(vc, animated: true, completion: nil)
                }
            }
            else {
                var alertView = UIAlertView(title: "Email or password is incorrect", message: "Please try again.", delegate: self, cancelButtonTitle: "OK")
                alertView.show()
            }
        }
    }
    
    func delay(delay:Double, closure:()->()) {
        dispatch_after(
            dispatch_time(
                DISPATCH_TIME_NOW,
                Int64(delay * Double(NSEC_PER_SEC))
            ),
            dispatch_get_main_queue(), closure)
    }
    
    func keyboardWillShow(notification: NSNotification!) {
        // Get the keyboard height and width from the notification
        // Size varies depending on OS, language, orientation
        var userInfo = notification.userInfo!
        var kbSize = (userInfo[UIKeyboardFrameEndUserInfoKey] as NSValue).CGRectValue().size
        var durationValue = userInfo[UIKeyboardAnimationDurationUserInfoKey] as NSNumber
        var animationDuration = durationValue.doubleValue
        var curveValue = userInfo[UIKeyboardAnimationCurveUserInfoKey] as NSNumber
        var animationCurve = curveValue.integerValue
        
        UIView.animateWithDuration(animationDuration, delay: 0.0, options: UIViewAnimationOptions(UInt(animationCurve << 16)), animations: {
            
            // Set view properties in here that you want to match with the animation of the keyboard
            // If you need it, you can use the kbSize property above to get the keyboard width and height.
            var yShift = kbSize.height
            
            self.buttonsView.frame.origin.y = self.buttonsView.frame.origin.y - yShift
            self.prompt.frame.origin.y = -61
            self.formView.frame.origin.y = 61
            
            }, completion: nil)
    }
    
    func keyboardWillHide(notification: NSNotification!) {
        // Get the keyboard height and width from the notification
        // Size varies depending on OS, language, orientation
        var userInfo = notification.userInfo!
        var kbSize = (userInfo[UIKeyboardFrameEndUserInfoKey] as NSValue).CGRectValue().size
        var durationValue = userInfo[UIKeyboardAnimationDurationUserInfoKey] as NSNumber
        var animationDuration = durationValue.doubleValue
        var curveValue = userInfo[UIKeyboardAnimationCurveUserInfoKey] as NSNumber
        var animationCurve = curveValue.integerValue
        
        var yShift = kbSize.height
        
        self.buttonsView.frame.origin.y = self.buttonsView.frame.origin.y + yShift
        self.prompt.frame.origin.y = 61
        self.formView.frame.origin.y = 153
        
    }

}
