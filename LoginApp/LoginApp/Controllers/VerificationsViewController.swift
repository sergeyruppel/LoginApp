//
//  VerificationsViewController.swift
//  LoginApp
//
//  Created by Sergey Ruppel on 25.08.2023.
//

import UIKit

final class VerificationsViewController: UIViewController {
    
    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var codeTextField: UITextField!
    @IBOutlet weak var centerConstraint: NSLayoutConstraint!
    
    var userModel: UserModel?
    private let randomInt = Int.random(in: 100000...999999)
    private var sleepTime = 6

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        startKeyBoardObserver()
        hideKeyboardWhenTappedAround()
    }
        
    @IBAction func codeTextFieldAction(_ sender: UITextField) {
        guard let codeText = sender.text,
              !codeText.isEmpty,
              codeText == randomInt.description else {
//            codeTextField.backgroundColor = UIColor(
//                red: 1.0, green: 0.0, blue: 0.0, alpha: 0.2
//            )
//            codeTextField.text = "Invalid code"
            sender.isUserInteractionEnabled = false
            codeTextField.text = "Error code. Please wait \(sleepTime) seconds"
            let dispatchAfter = DispatchTimeInterval.seconds (sleepTime)
            let deadline = DispatchTime.now() + dispatchAfter
            DispatchQueue.main.asyncAfter(deadline: deadline) {
                sender.isUserInteractionEnabled = true
                self.codeTextField.text = ""
                self.sleepTime *= 2
            }
            
//            Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(resetErrorTextField), userInfo: nil, repeats: false)
            
            return
        }
        performSegue(withIdentifier: "goToWelcomeScreen", sender: nil)
    }
    
    private func setupUI() {
        overrideUserInterfaceStyle = .dark
        infoLabel.text = "Please enter code \"\(randomInt)\" from \(userModel?.email ?? "")"
        
        UITextField.appearance().tintColor = .white
        codeTextField.layer.cornerRadius = codeTextField.frame.height * 0.5
        codeTextField.layer.borderWidth = 2.0
        codeTextField.layer.borderColor = CGColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        codeTextField.layer.masksToBounds = true
        codeTextField.attributedPlaceholder = NSAttributedString(
            string: "Secret Code",
            attributes:[NSAttributedString.Key.foregroundColor: UIColor.lightGray])
    }
    
//    @objc private func resetErrorTextField() {
//        codeTextField.backgroundColor = .clear
//        codeTextField.text = ""
//    }
//
    private func startKeyBoardObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc private func keyboardWillShow(notification: Notification) {
        guard let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else { return }
        centerConstraint.constant -= keyboardSize.height * 0.5
    }
    
    @objc private func keyboardWillHide(notification: Notification) {
        guard let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else { return }
        centerConstraint.constant += keyboardSize.height * 0.5
    }


    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destinationVC = segue.destination as? WelcomeViewController else { return }
            destinationVC.userModel = userModel
        }

}
