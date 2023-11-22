//
//  AlertManager.swift
//  CourseWork2.0
//
//  Created by Paul Makey on 22.11.23.
//

import UIKit

class AlertManager {
    
    private static func showBasicAlert(
        on viewController: UIViewController,
        title: String,
        message: String?
    ) {
        
        //An object that manages the execution of tasks serially or concurrently on your app's main thread or on a background thread
        DispatchQueue.main.async {
            let alert = UIAlertController(
                title: title,
                message: message,
                preferredStyle: .alert
            )
            
            alert.addAction(
                UIAlertAction(
                    title: "Dismiss",
                    style: .default
                )
            )
            viewController.present(alert, animated: true)
        }
    }
}


// MARK: - Show Validation Alerts
extension AlertManager {
    
    public static func showInvalidEmailAlert(on viewController: UIViewController) {
        self.showBasicAlert(
            on: viewController,
            title: "Invalid Email",
            message: "Please, enter a valid email"
        )
    }
    
    public static func showInvalidPasswordAlert(on viewController: UIViewController) {
        self.showBasicAlert(
            on: viewController,
            title: "Invalid password",
            message: "Please, enter a valid password"
        )
    }
    
    public static func showInvalidUsernameAlert(on viewController: UIViewController) {
        self.showBasicAlert(
            on: viewController,
            title: "Invalid username",
            message: "Please, enter a valid username"
        )
    }
}

// MARK: - Registration Errors
extension AlertManager {
    public static func showRegistrationErrorAlert(on viewController: UIViewController) {
        self.showBasicAlert(
            on: viewController,
            title: "Unknown Registration Error",
            message: nil
        )
    }
    
    public static func showRegistrationErrorAlert(
        on viewController: UIViewController,
        with error: Error
    ) {
        self.showBasicAlert(
            on: viewController,
            title: "Unknown Registration Error",
            message: "\(error.localizedDescription)"
        )
    }
}

// MARK: - Log In Errors
extension AlertManager {
    public static func showSignInErrorAlert(on viewController: UIViewController) {
        self.showBasicAlert(
            on: viewController,
            title: "Unknown Error Signing In",
            message: nil
        )
    }
    
    public static func showSignInErrorAlert(
        on viewController: UIViewController,
        with error: Error
    ) {
        self.showBasicAlert(
            on: viewController,
            title: "Error Signing In",
            message: "\(error.localizedDescription)"
        )
    }
}

// MARK: - Logout Errors
extension AlertManager {
    public static func showLogoutErrorAlert(
        on viewController: UIViewController,
        with error: Error
    ) {
        self.showBasicAlert(
            on: viewController,
            title: "Log Out Error",
            message: "\(error.localizedDescription)"
        )
    }
}

// MARK: - Forgot Password
extension AlertManager {
    
    public static func showPasswordResetSent(
        on viewController: UIViewController
    ) {
        self.showBasicAlert(
            on: viewController,
            title: "Password reset sent.",
            message: nil
        )
    }
    
    public static func showErrorSendingPasswordReset(
        on viewController: UIViewController,
        with error: Error
    ) {
        self.showBasicAlert(
            on: viewController,
            title: "Error sending password reset.",
            message: "\(error.localizedDescription)"
        )
    }
}

// MARK: - Fetching User Errors
extension AlertManager {
    
    public static func showUknownUserFetchingError(
        on viewController: UIViewController
    ) {
        self.showBasicAlert(
            on: viewController,
            title: "Unknown Error Fetching User.",
            message: nil
        )
    }
    
    public static func showFetchingUserError(
        on viewController: UIViewController,
        with error: Error
    ) {
        self.showBasicAlert(
            on: viewController,
            title: "Error fetching user.",
            message: "\(error.localizedDescription)"
        )
    }
}
