//
//  WelcomeViewController.swift
//  LoginApp
//
//  Created by Sergey Ruppel on 25.08.2023.
//

import UIKit

class WelcomeViewController: UIViewController {
    
    @IBOutlet weak var infoLabel: UILabel!
    
    
    var userModel: UserModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    @IBAction func continueAction() {
        saveToUserDefaults()
        syncUserDefaults()
        printUserDefaults()
        navigationController?.popToRootViewController(animated: true)
    }
    
    private func setupUI() {
        infoLabel.text = "\(userModel?.name ?? "") to Login App"
    }
    
    func saveToUserDefaults() {
        UserDefaults.standard.set(userModel?.name, forKey: "nameKey")
        UserDefaults.standard.set(userModel?.email, forKey: "emailKey")
        UserDefaults.standard.set(userModel?.password, forKey: "passKey")
    }
    func syncUserDefaults() {
        UserDefaults.standard.synchronize()
    }
    func printUserDefaults() {
        if let savedName = UserDefaults.standard.string(forKey: "nameKey"),
           let savedEmail = UserDefaults.standard.string(forKey: "emailKey"),
           let savedPassword = UserDefaults.standard.string(forKey: "passKey") {
            print("User Name: \(savedName)")
            print("User Email: \(savedEmail)")
            print("User Password: \(savedPassword)")
        } else {
            print("Data not found in UserDefaults.")
        }
    }
}
