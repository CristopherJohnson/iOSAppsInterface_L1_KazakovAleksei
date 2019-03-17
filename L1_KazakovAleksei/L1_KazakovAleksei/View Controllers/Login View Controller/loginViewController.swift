//
//  loginViewController.swift
//  L1_KazakovAleksei
//
//  Created by Алексей Казаков on 23/01/2019.
//  Copyright © 2019 Алексей Казаков. All rights reserved.
//

import UIKit

class loginViewController: UIViewController, UITextFieldDelegate{
    
    @IBOutlet private weak var scrollView: UIScrollView?
    @IBOutlet private weak var titleLable: UILabel?
    @IBOutlet private weak var loginLable: UILabel?
    @IBOutlet private weak var loginTextField: UITextField?
    @IBOutlet private weak var passLable: UILabel?
    @IBOutlet private weak var passTextField: UITextField?
    @IBOutlet private weak var loginButton: UIButton?
    
    private let demoLogin = "root"
    private let demoPass = "1234"
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        loginTextField?.delegate = self
        passTextField?.delegate = self
        self.passTextField?.isSecureTextEntry = true

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.kbWasShown), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.kbWillBeHidden(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    // MARK: - Actions
    
    func showAlert (){
        let alert = UIAlertController(title: "Whoops", message: "Invalid login or password", preferredStyle: .alert)
        let action = UIAlertAction(title: "Try Again", style: .default, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    @IBAction func loginButtonAction (){
        print("loginButtonAction")
        
        guard let loginText = self.loginTextField?.text else {
            print("loginText is empty")
            return
        }
        
        guard let passText = self.passTextField?.text else {
            print("loginText is empty")
            return
        }
        
        if self.demoLogin == loginText && self.demoPass == passText {
            print("success")
            self.performSegue(withIdentifier: "openApp", sender: nil)
        } else {
            showAlert()
        }
        
        
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if let loginText = self.loginTextField, loginText == textField {
            passTextField?.becomeFirstResponder()
        } else if let passText = self.passTextField, passText == textField {
            passTextField?.resignFirstResponder()
            loginButtonAction()
        }
        return true
    }
    
    
    
    @IBAction func closeKbAction() {
        print("closeKbAction")
        self.view.endEditing(true)
    }
    
    @IBAction func logOutAction(segue: UIStoryboardSegue?) {
        
    }
    
    // MARK: - notifications
    
    @objc func kbWasShown (notification: Notification) {
        let info = notification.userInfo! as NSDictionary
        let kbSize = (info.value(forKey: UIResponder.keyboardFrameEndUserInfoKey) as! NSValue).cgRectValue.size
        let contentInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: kbSize.height, right: 0.0)
        
        self.scrollView?.contentInset = contentInsets
        scrollView?.scrollIndicatorInsets = contentInsets
    }
    
    @objc func kbWillBeHidden (notification: Notification) {
        let contentInsets = UIEdgeInsets.zero
        scrollView?.contentInset = contentInsets
        scrollView?.scrollIndicatorInsets = contentInsets
    }
    
    

}
