//
//  ProfileViewController.swift
//  LoginApp
//
//  Created by Sergey Ruppel on 31.08.2023.
//

import UIKit

final class ProfileViewController: UIViewController {

    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var passwordLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    @IBAction func deletAccountAction() {
        UserDefaultsService.resetUserDefaults()
        navigationController?.popToRootViewController(animated: true)
    }
    
    @IBAction func logOutAction() {
        navigationController?.popToRootViewController(animated: true)
    }
    
    @objc func setupUI() {
        if let userModel = UserDefaultsService.getUserModel() {
            emailLabel.text = "Email: \(userModel.email)"
            nameLabel.text = "Name: \(userModel.name ?? "")"
            passwordLabel.text = "Password: \(userModel.password)"
        }
    }
    
}
