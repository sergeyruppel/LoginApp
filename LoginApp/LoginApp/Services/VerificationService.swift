//
//  EmailVerificationService.swift
//  LoginApp
//
//  Created by Sergey Ruppel on 25.08.2023.
//

import Foundation

enum PasswordStrength: Int {
    case veryWeak
    case weak
    case medium
    case strong
    case veryStrong
}

final class VerificationService {
    
    static let weakRegex = "^(?=.*[A-Za-z])(?=.*\\d)[A-Za-z\\d]{8,}$"
    static let mediumRegex = "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)[a-zA-Z\\d]{8,}$"
    static let strongRegex = "^(?=.*[A-Za-z])(?=.*\\d)(?=.*[$@$!%*#?&])[A-Za-z\\d$@$!%*#?&]{8,}$"
    static let veryStrongRegex = "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[d$@$!%*?&#])[A-Za-z\\dd$@$!%*?&#]{8,}"
    
    static func isValidPassword(password: String) -> PasswordStrength {
        if NSPredicate(format: "SELF MATCHES %@", veryStrongRegex).evaluate(with: password) {
            return .veryStrong
        } else if NSPredicate(format: "SELF MATCHES %@", strongRegex).evaluate(with: password) {
            return .strong
        } else if NSPredicate(format: "SELF MATCHES %@", mediumRegex).evaluate(with: password) {
            return .medium
        } else if NSPredicate(format: "SELF MATCHES %@", weakRegex).evaluate(with: password) {
            return .weak
        } else {
            return .veryWeak
        }
    }
    
    static func isValidEmail(email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }

	static func isPasswordsConfirm(password1: String, password2: String) -> Bool {
		return password1 == password2
	}
}
