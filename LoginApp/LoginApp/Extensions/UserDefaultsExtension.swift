//
//  UserDefaultsExtension.swift
//  LoginApp
//
//  Created by Sergey Ruppel on 30.08.2023.
//

import Foundation

extension UserDefaults {
    
    enum Keys: String, CaseIterable {
        case email
        case name
        case password
    }
    
    func reset() {
        let allCases = Keys.allCases
        allCases.forEach({ removeObject(forKey: $0.rawValue) })
    }
}
