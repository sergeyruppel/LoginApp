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
        
        navigationController?.popToRootViewController(animated: true)
    }
    
    private func setupUI() {
        infoLabel.text = "\(userModel?.name ?? "") to Login App"
    }
}
