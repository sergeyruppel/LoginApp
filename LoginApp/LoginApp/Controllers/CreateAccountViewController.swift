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
    
    
    @IBOutlet var passwordStrengthMeter: [UIView]!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    @IBOutlet weak var continueButton: UIButton! {
        didSet { continueButton.isEnabled = false }
    }
    @IBOutlet weak var passwordVisibilityButton: UIButton!
    @IBOutlet weak var confirmPasswordVisibilityButton: UIButton!
    @IBOutlet weak var scrollView: UIScrollView!
    
    // MARK: - Properties
    
    private var isValidEmail = false { didSet { updateContinueButtonState() } }
    private var isConfirmPassword = false { didSet { updateContinueButtonState() } }
    private var passwordStrength: PasswordStrength = .veryWeak {
        didSet { updateContinueButtonState() }
    }
    private var isPasswordVisible = true

    // MARK: - Lifecycle methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        startKeyBoardObserver()
        hideKeyboardWhenTappedAround()
    }
    
    // MARK: - Verification
    
    @IBAction func emailTextFieldAction(_ sender: UITextField) {
        if let email = sender.text,
           !email.isEmpty,
           VerificationService.isValidEmail(email: email) {
            isValidEmail = true
            sender.backgroundColor = .clear
        } else {
            isValidEmail = false
            sender.backgroundColor = UIColor(
                red: 1.0, green: 0.0, blue: 0.0, alpha: 0.2
            )
        }
    }
    
    @IBAction func passwordTextFieldAction(_ sender: UITextField) {
        if let passwordText = sender.text,
           !passwordText.isEmpty {
            passwordStrength = VerificationService.isValidPassword(password: passwordText)
        } else {
            passwordStrength = .veryWeak
        }
        sender.backgroundColor = passwordStrength != .veryWeak ? .clear : UIColor(
            red: 1.0, green: 0.0, blue: 0.0, alpha: 0.2
        )
        setupPasswordStrengthMeter()
    }
    
    @IBAction func confirmPasswordTextFieldAction(_ sender: UITextField) {
        if let confirmPasswordText = sender.text,
           !confirmPasswordText.isEmpty,
           let passwordText = passwordTextField.text,
           !passwordText.isEmpty {
            isConfirmPassword = VerificationService.isPasswordsConfirm(
                password1: passwordText, password2: confirmPasswordText
            )
        } else {
            isConfirmPassword = false
        }
        sender.backgroundColor = isConfirmPassword ? .clear : UIColor(
            red: 1.0, green: 0.0, blue: 0.0, alpha: 0.2
        )
    }
    
    @IBAction func togglePasswordVisibility(sender: AnyObject) {
        if isPasswordVisible {
            passwordTextField.isSecureTextEntry = false
            confirmPasswordTextField.isSecureTextEntry = false
            passwordVisibilityButton.setImage(UIImage(systemName: "eye"),
                                              for: .normal)
            confirmPasswordVisibilityButton.setImage(UIImage(systemName: "eye"),
                                                     for: .normal)
        } else {
            passwordTextField.isSecureTextEntry = true
            confirmPasswordTextField.isSecureTextEntry = true
            passwordVisibilityButton.setImage(UIImage(systemName: "eye.slash"),
                                              for: .normal)
            confirmPasswordVisibilityButton.setImage(UIImage(systemName: "eye.slash"),
                                                     for: .normal)
        }
        isPasswordVisible = !isPasswordVisible
    }

    @IBAction func continueAction() {
        if let email = emailTextField.text,
           let password = passwordTextField.text {
            let userModel = UserModel(
                email: email, name: nameTextField.text, password: password
            )
            performSegue(withIdentifier: "goToVerificationScreen", sender: userModel)
        }
    }
    
    
    // MARK: - Setup UI
    
    private func setupUI() {
        overrideUserInterfaceStyle = .dark
        UITextField.appearance().tintColor = .white
        
        // emailTextField
        emailTextField.layer.cornerRadius = emailTextField.frame.height * 0.5
        emailTextField.layer.borderWidth = 2.0
        emailTextField.layer.borderColor = CGColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        emailTextField.layer.masksToBounds = true
        emailTextField.attributedPlaceholder = NSAttributedString(
            string: "Your Email",
            attributes:[NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        emailTextField.leftView = UIView(
            frame: CGRect(x: 0.0, y: 0.0, width: 30.0, height: emailTextField.frame.height)
        )
        emailTextField.leftViewMode = .always
        
        // nameTextField
        nameTextField.layer.cornerRadius = nameTextField.frame.height * 0.5
        nameTextField.layer.borderWidth = 2.0
        nameTextField.layer.borderColor = CGColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        nameTextField.layer.masksToBounds = true
        nameTextField.attributedPlaceholder = NSAttributedString(
            string: "Your Name",
            attributes:[NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        nameTextField.leftView = UIView(
            frame: CGRect(x: 0.0, y: 0.0, width: 30.0, height: nameTextField.frame.height)
        )
        nameTextField.leftViewMode = .always
        
        // passwordTextField
        passwordTextField.layer.cornerRadius = passwordTextField.frame.height * 0.5
        passwordTextField.layer.borderWidth = 2.0
        passwordTextField.layer.borderColor = CGColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        passwordTextField.layer.masksToBounds = true
        passwordTextField.attributedPlaceholder = NSAttributedString(
            string: "Enter Password",
            attributes:[NSAttributedString.Key.foregroundColor: UIColor.lightGray]
        )
        passwordTextField.leftView = UIView(
            frame: CGRect(x: 0.0, y: 0.0, width: 30.0, height: passwordTextField.frame.height)
        )
        passwordTextField.leftViewMode = .always
        

        passwordTextField.rightView = passwordVisibilityButton
        passwordTextField.rightViewMode = .always
        
        //strongPasswordMeter
        passwordStrengthMeter.forEach({ $0.alpha = 0.2 })
        
        // confirmPasswordTextField
        confirmPasswordTextField.layer.cornerRadius = confirmPasswordTextField.frame.height * 0.5
        confirmPasswordTextField.layer.borderWidth = 2.0
        confirmPasswordTextField.layer.borderColor = CGColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        confirmPasswordTextField.layer.masksToBounds = true
        confirmPasswordTextField.attributedPlaceholder = NSAttributedString(
            string: "Confirm Password",
            attributes:[NSAttributedString.Key.foregroundColor: UIColor.lightGray]
        )
        confirmPasswordTextField.leftView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 30.0, height: confirmPasswordTextField.frame.height))
        confirmPasswordTextField.leftViewMode = .always
        
        confirmPasswordTextField.rightView = confirmPasswordVisibilityButton
        confirmPasswordTextField.rightViewMode = .always
        
    }
    
    private func startKeyBoardObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc private func keyboardWillShow(notification: Notification) {
        guard let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else { return }
        let contentInsets = UIEdgeInsets(top: 0.0,
                                         left: 0.0,
                                         bottom: keyboardSize.height,
                                         right: 0.0)
        scrollView.contentInset = contentInsets
        scrollView.scrollIndicatorInsets = contentInsets
    }
    
    @objc private func keyboardWillHide() {
        let contentInsets = UIEdgeInsets(top: 0.0,
                                         left: 0.0,
                                         bottom: 0.0,
                                         right: 0.0)
        scrollView.contentInset = contentInsets
        scrollView.scrollIndicatorInsets = contentInsets
    }
    
    private func setupPasswordStrengthMeter() {
        passwordStrengthMeter.enumerated().forEach({ index, view in
            if index < passwordStrength.rawValue {
                view.alpha = 1.0
            } else {
                view.alpha = 0.2
            }
        })
    }
    
    private func updateContinueButtonState() {
        continueButton.isEnabled = isValidEmail && isConfirmPassword && passwordStrength != .veryWeak
    }
    
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destinationVC = segue.destination as? VerificationsViewController,
              let userModel = sender as? UserModel else { return }
        destinationVC.userModel = userModel
    }
    
}
