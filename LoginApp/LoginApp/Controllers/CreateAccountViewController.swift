//
//  CreateAccountViewController.swift
//  LoginApp
//
//  Created by Sergey Ruppel on 24.08.2023.
//

import UIKit

final class CreateAccountViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet var strongPasswordMeter: [UIView]!
    
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    
    @IBOutlet weak var continueButton: UIButton!
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
    // MARK: UITextField
        UITextField.appearance().tintColor = .white
        
        // emailTextField
        emailTextField.layer.cornerRadius = emailTextField.frame.height * 0.5
        emailTextField.layer.borderWidth = 2.0
        emailTextField.layer.borderColor = CGColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        emailTextField.layer.masksToBounds = true
        emailTextField.attributedPlaceholder = NSAttributedString(
            string: "Your Email",
            attributes:[NSAttributedString.Key.foregroundColor: UIColor.white])
        emailTextField.leftView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 30.0, height: emailTextField.frame.height))
        emailTextField.leftViewMode = .always
        
        // nameTextField
        nameTextField.layer.cornerRadius = nameTextField.frame.height * 0.5
        nameTextField.layer.borderWidth = 2.0
        nameTextField.layer.borderColor = CGColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        nameTextField.layer.masksToBounds = true
        nameTextField.attributedPlaceholder = NSAttributedString(
            string: "Your Name",
            attributes:[NSAttributedString.Key.foregroundColor: UIColor.white])
        nameTextField.leftView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 30.0, height: nameTextField.frame.height))
        nameTextField.leftViewMode = .always
        
        // passwordTextField
        passwordTextField.layer.cornerRadius = passwordTextField.frame.height * 0.5
        passwordTextField.layer.borderWidth = 2.0
        passwordTextField.layer.borderColor = CGColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        passwordTextField.layer.masksToBounds = true
        passwordTextField.attributedPlaceholder = NSAttributedString(
            string: "Password",
            attributes:[NSAttributedString.Key.foregroundColor: UIColor.white])
        passwordTextField.leftView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 30.0, height: passwordTextField.frame.height))
        passwordTextField.leftViewMode = .always
        
        // confirmPasswordTextField
        confirmPasswordTextField.layer.cornerRadius = confirmPasswordTextField.frame.height * 0.5
        confirmPasswordTextField.layer.borderWidth = 2.0
        confirmPasswordTextField.layer.borderColor = CGColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        confirmPasswordTextField.layer.masksToBounds = true
        confirmPasswordTextField.attributedPlaceholder = NSAttributedString(
            string: "Confirm Password",
            attributes:[NSAttributedString.Key.foregroundColor: UIColor.white])
        confirmPasswordTextField.leftView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 30.0, height: confirmPasswordTextField.frame.height))
        confirmPasswordTextField.leftViewMode = .always
        

    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
