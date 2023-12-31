//
//  EditProfileViewController.swift
//  LoginApp
//
//  Created by Sergey Ruppel on 31.08.2023.
//

import UIKit

final class EditProfileViewController: UIViewController {
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var newPasswordTextField: UITextField!
    @IBOutlet var passwordStrengthMeter: [UIView]!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    @IBOutlet weak var doneButton: UIButton! {
        didSet { doneButton.isEnabled = false }
    }
    @IBOutlet weak var passwordVisibilityButton: UIButton!
    @IBOutlet weak var confirmPasswordVisibilityButton: UIButton!
    @IBOutlet weak var scrollView: UIScrollView!
    
    // MARK: - Properties
    
    private var isValidEmail = false
    private var isConfirmPassword = false { didSet { updateDoneButtonState() } }
    private var passwordStrength: PasswordStrength = .veryWeak {
        didSet { updateDoneButtonState() }
    }
    private var isPasswordVisible = true
    
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
    
    @IBAction func newPasswordTextFieldAction(_ sender: UITextField) {
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
           let passwordText = newPasswordTextField.text,
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
            newPasswordTextField.isSecureTextEntry = false
            confirmPasswordTextField.isSecureTextEntry = false
            passwordVisibilityButton.setImage(UIImage(systemName: "eye"),
                                              for: .normal)
            confirmPasswordVisibilityButton.setImage(UIImage(systemName: "eye"),
                                                     for: .normal)
        } else {
            newPasswordTextField.isSecureTextEntry = true
            confirmPasswordTextField.isSecureTextEntry = true
            passwordVisibilityButton.setImage(UIImage(systemName: "eye.slash"),
                                              for: .normal)
            confirmPasswordVisibilityButton.setImage(UIImage(systemName: "eye.slash"),
                                                     for: .normal)
        }
        isPasswordVisible = !isPasswordVisible
    }
    
    @IBAction func doneAction() {
        if let email = emailTextField.text,
           let password = newPasswordTextField.text {
            let userModel = UserModel(
                email: email, name: nameTextField.text, password: password
            )
            UserDefaultsService.saveUserModel(userModel: userModel)
            
            dismiss(animated: true, completion: nil)

            // TODO: refresh parent VC
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
        guard let email = UserDefaultsService.getUserModel()?.email else {
            emailTextField.attributedPlaceholder = NSAttributedString(
                string: "Your Email",
                attributes:[NSAttributedString.Key.foregroundColor: UIColor.lightGray])
            return
        }
        emailTextField.text = email
        emailTextField.leftView = UIView(
            frame: CGRect(x: 0.0, y: 0.0, width: 30.0, height: emailTextField.frame.height)
        )
        emailTextField.leftViewMode = .always
        
        // nameTextField
        nameTextField.layer.cornerRadius = nameTextField.frame.height * 0.5
        nameTextField.layer.borderWidth = 2.0
        nameTextField.layer.borderColor = CGColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        nameTextField.layer.masksToBounds = true
        guard let name = UserDefaultsService.getUserModel()?.name else {
            nameTextField.attributedPlaceholder = NSAttributedString(
                string: "Your Name",
                attributes:[NSAttributedString.Key.foregroundColor: UIColor.lightGray])
            return
        }
        nameTextField.text = name
        nameTextField.leftView = UIView(
            frame: CGRect(x: 0.0, y: 0.0, width: 30.0, height: nameTextField.frame.height)
        )
        nameTextField.leftViewMode = .always
        
        // newPasswordTextField
        newPasswordTextField.layer.cornerRadius = newPasswordTextField.frame.height * 0.5
        newPasswordTextField.layer.borderWidth = 2.0
        newPasswordTextField.layer.borderColor = CGColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        newPasswordTextField.layer.masksToBounds = true
        newPasswordTextField.attributedPlaceholder = NSAttributedString(
            string: "New Password",
            attributes:[NSAttributedString.Key.foregroundColor: UIColor.lightGray]
        )
        newPasswordTextField.leftView = UIView(
            frame: CGRect(x: 0.0, y: 0.0, width: 30.0, height: newPasswordTextField.frame.height)
        )
        newPasswordTextField.leftViewMode = .always
        
        newPasswordTextField.rightView = passwordVisibilityButton
        newPasswordTextField.rightViewMode = .always
        
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
    
    private func updateDoneButtonState() {
        doneButton.isEnabled = isConfirmPassword && passwordStrength != .veryWeak
    }
    
}
