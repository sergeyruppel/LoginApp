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
        guard let userModel = userModel else { return }
        UserDefaultsService.saveUserModel(userModel: userModel)
//        navigationController?.popToRootViewController(animated: true)
        goToTabBarController()
    }
    
    private func setupUI() {
        infoLabel.text = "\(userModel?.name ?? "") to Login App"
    }
    
    
    private func goToTabBarController() {
        let storyboard = UIStoryboard(name: "MainStoryboard", bundle: nil)
        guard let vc = storyboard.instantiateViewController(
            withIdentifier: "TabBarController"
        ) as? TabBarController else { return }
        navigationController?.pushViewController(vc, animated: true)
    }
    
}
