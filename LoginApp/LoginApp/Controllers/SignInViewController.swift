//
//  SignInViewController.swift
//  LoginApp
//
//  Created by Sergey Ruppel on 23.08.2023.
//

import UIKit

final class SignInViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signInButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        hideKeyboardWhenTappedAround()
        if let _ = UserDefaultsService.getUserModel() {
            goToTabBarController()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        emailTextField.text = ""
        passwordTextField.text = ""
    }
    
    @IBAction func signInAction() {
        guard let email = emailTextField.text,
              let password = passwordTextField.text,
              let userModel = UserDefaultsService.getUserModel(),
              email == userModel.email,
              password == userModel.password else {
            emailTextField.backgroundColor = UIColor(
                red: 1.0, green: 0.0, blue: 0.0, alpha: 0.2
            )
            emailTextField.text = ""
            emailTextField.placeholder = "Wrong Email"
            passwordTextField.backgroundColor = UIColor(
                red: 1.0, green: 0.0, blue: 0.0, alpha: 0.2
            )
            passwordTextField.text = ""
            passwordTextField.placeholder = "Wrong Password"
            return
        }
        goToTabBarController()
        
    }
    
    private func setupUI() {
        overrideUserInterfaceStyle = .dark
        // MARK: UITextField
        UITextField.appearance().tintColor = .white
        emailTextField.layer.cornerRadius = emailTextField.frame.height * 0.5
        emailTextField.layer.borderWidth = 2.0
        emailTextField.layer.borderColor = CGColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        emailTextField.layer.masksToBounds = true
        emailTextField.attributedPlaceholder = NSAttributedString(
            string: "Your Email",
            attributes:[NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        emailTextField.leftView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 30.0, height: emailTextField.frame.height))
        emailTextField.leftViewMode = .always
        passwordTextField.layer.cornerRadius = passwordTextField.frame.height * 0.5
        passwordTextField.layer.borderWidth = 2.0
        passwordTextField.layer.borderColor = CGColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        passwordTextField.layer.masksToBounds = true
        passwordTextField.attributedPlaceholder = NSAttributedString(
            string: "Password",
            attributes:[NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        passwordTextField.leftView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 30.0, height: passwordTextField.frame.height))
        passwordTextField.leftViewMode = .always
    }
    
    private func goToTabBarController() {
        let storyboard = UIStoryboard(name: "MainStoryboard", bundle: nil)
        guard let vc = storyboard.instantiateViewController(
            withIdentifier: "TabBarController"
        ) as? TabBarController else { return }
        navigationController?.pushViewController(vc, animated: true)
    }
    
}
