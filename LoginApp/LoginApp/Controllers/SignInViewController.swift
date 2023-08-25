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
	@IBOutlet weak var signInButton: UIButton! {
		didSet { signInButton.isEnabled = false }
	}

	override func viewDidLoad() {
		super.viewDidLoad()
		setupUI()
		hideKeyboardWhenTappedAround()
	}

	private func setupUI() {
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


	/*
	 // MARK: - Navigation

	 // In a storyboard-based application, you will often want to do a little preparation before navigation
	 override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
	 // Get the new view controller using segue.destination.
	 // Pass the selected object to the new view controller.
	 }
	 */

}
