//
//  loginViewController.swift
//  L1_KazakovAleksei
//
//  Created by Алексей Казаков on 23/01/2019.
//  Copyright © 2019 Алексей Казаков. All rights reserved.
//

import UIKit

class loginViewController: UIViewController {
    
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
        } else {
            showAlert()
        }
        
        
    }

}
