//
//  LoginViewController.swift
//  Login
//
//  Created by Paige Plander on 4/5/17.
//  Copyright © 2017 Paige Plander. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    // Constants used in the LoginViewController
    struct Constants {
        static let backgroundColor: UIColor = UIColor(hue: 0.5389, saturation: 1, brightness: 0.92, alpha: 1.0)
        static let invalidEmailTitle = "Invalid username or password"
        static let invalidEmailMessage = "Please try again"
    }

    // TODO: instantiate the views needed for your project
    
    var login: UIButton!
    var email: UITextField!
    var password: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Constants.backgroundColor
        
        // TODO: Add your views either as subviews of `view` or subviews of each other using `addSubview`
        
        // Login View Bounds
        
        let loginView = UIView(frame: CGRect(x: 10, y: 300, width: UIScreen.main.bounds.width-20, height: 200))
        loginView.backgroundColor = UIColor.clear
        loginView.layer.cornerRadius = 20
        loginView.layer.borderWidth = 1
        
        
        // Login View Label
        
        let titleBlock = CGRect(x: 10, y: 80, width: UIScreen.main.bounds.width - 16, height: 200)
        let label = UILabel(frame: titleBlock)
        label.text = "Login View Controller"
        label.textAlignment = .center
        label.font = UIFont(name: "HelveticaNeue-UltraLight", size: 50)
        label.textColor = UIColor.black
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.numberOfLines = 2
        
        // Email Label
        
        email = UITextField(frame: CGRect(x: 15, y: 10, width: UIScreen.main.bounds.width - 50, height: 50))
        email.text = "   berkeley.edu account"
        email.textColor = UIColor.black
        email.backgroundColor = UIColor.clear
        email.layer.borderWidth = 1
        email.layer.cornerRadius = 20
        email.font = UIFont(name: "HelveticaNeue-UltraLight", size: 20)

        
        // Password Label
        
        password = UITextField(frame: CGRect(x: 15, y: 70, width: UIScreen.main.bounds.width - 50, height: 50))
        password.text = "   password"
        password.textColor = UIColor.black
        password.backgroundColor = UIColor.clear
        password.layer.borderWidth = 1
        password.layer.cornerRadius = 20
        password.font = UIFont(name: "HelveticaNeue-UltraLight", size: 20)

        
        // Login Button
        
        login = UIButton(frame:CGRect(x: 90, y: 130, width: UIScreen.main.bounds.width - 200, height: 50))
        login.setTitle("Login", for: .normal)
        login.backgroundColor = UIColor.clear
        login.setTitleColor(UIColor.black, for: .normal)
        login.layer.borderWidth = 1
        login.addTarget(self, action: #selector(loginAction), for: .touchDown)
        login.layer.cornerRadius = 20
        login.titleLabel!.font =  UIFont(name: "HelveticaNeue-UltraLight", size: 20)

        
        // TODO: layout your views using frames or AutoLayout
        
        loginView.addSubview(email)
        loginView.addSubview(password)
        loginView.addSubview(login)

        self.view.addSubview(label)
        self.view.addSubview(loginView)
    }
    
    // TODO: create an IBAction for your login button
    
    @IBAction func loginAction(sender: UIButton) {
        authenticateUser(username: email.text, password: password.text)
    }
    
    
    /// YOU DO NOT NEED TO MODIFY ANY OF THE CODE BELOW (but you will want to use `authenticateUser` at some point)
    
    // Model class to handle checking if username/password combinations are valid.
    // Usernames and passwords can be found in the Lab6Names.csv file
    let loginModel = LoginModel(filename: "Lab6Names")

    /// Imageview for login success image (do not need to modify)
    let loginSuccessView = UIImageView(image: UIImage(named: "oski"))
    
    /// If the provided username/password combination is valid, displays an
    /// image (in the "loginSuccessView" imageview). If invalid, displays an alert
    /// telling the user that the login was unsucessful.
    /// You do not need to edit this function, but you will want to use it for the lab.
    ///
    /// - Parameters:
    ///   - username: the user's berkeley.edu address
    ///   - password: the user's first name (what a great password!)
    func authenticateUser(username: String?, password: String?) {
        
        // if username / password combination is invalid, present an alert
        if !loginModel.authenticate(username: username, password: password) {
            loginSuccessView.isHidden = true
            let alert = UIAlertController(title: Constants.invalidEmailTitle, message: Constants.invalidEmailMessage, preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
            
        // If username / password combination is valid, display success image
        else {
            if !loginSuccessView.isDescendant(of: view) {
                view.addSubview(loginSuccessView)
                loginSuccessView.contentMode = .scaleAspectFill
            }
            
            loginSuccessView.isHidden = false
            
            // Constraints for the login success view
            loginSuccessView.translatesAutoresizingMaskIntoConstraints = false
            loginSuccessView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
            loginSuccessView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
            loginSuccessView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
            loginSuccessView.heightAnchor.constraint(equalToConstant: view.frame.height/4).isActive = true
        }
    }
}

// EXTRA; change color when entering in text

func textViewDidBeginEditing (_ textView: UITextView) {
    if textView.textColor == UIColor.black {
        textView.text = nil
        textView.textColor = UIColor.yellow
    }
}

func textViewDidEndEditing(_ textView: UITextView) {
    if textView.text.isEmpty {
        textView.text = "   berkeley.edu account"
        textView.textColor = UIColor.yellow
    }
}

