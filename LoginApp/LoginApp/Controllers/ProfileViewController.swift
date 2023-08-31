//
//  ProfileViewController.swift
//  LoginApp
//
//  Created by Sergey Ruppel on 31.08.2023.
//

import UIKit

class ProfileViewController: UIViewController {

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
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    @IBAction func deletAccountAction() {
        UserDefaultsService.resetUserDefaults()
        navigationController?.popToRootViewController(animated: true)
    }
    
    @IBAction func logOutAction() {
        navigationController?.popToRootViewController(animated: true)
    }
    
    func setupUI() {
        if let userModel = UserDefaultsService.getUserModel() {
            emailLabel.text = "Email: \(userModel.email)"
            nameLabel.text = "Name: \(userModel.name ?? "")"
            passwordLabel.text = "Password: \(userModel.password)"
        }
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
