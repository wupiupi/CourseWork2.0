//
//  ForgotPasswordController.swift
//  CourseWork2.0
//
//  Created by Paul Makey on 23.11.23.
//

import UIKit

final class ForgotPasswordController: UIViewController {
    
    // MARK: - UI Components
    private let headerView = AuthHeaderView(title: "Forgot Password", subtitle: "Reset your password")
    
    private let emailField = CustomTextField(fieldType: .email)
    
    private let resetPasswordButton = CustomButton(title: "Sign Up", hasBackground: true, fontSize: .big, textColor: .label)
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
        resetPasswordButton.addTarget(self, action: #selector(didTapForgotPassword), for: .touchUpInside)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = false
    }
    
    // MARK: - UI Setup
    private func setupUI() {
        view.backgroundColor = .systemGray6
        
        view.addSubview(headerView)
        view.addSubview(emailField)
        view.addSubview(resetPasswordButton)
        
        headerView.translatesAutoresizingMaskIntoConstraints = false
        emailField.translatesAutoresizingMaskIntoConstraints = false
        resetPasswordButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 30),
            headerView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 230),
            
            emailField.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 11),
            emailField.centerXAnchor.constraint(equalTo: headerView.centerXAnchor),
            emailField.heightAnchor.constraint(equalToConstant: 55),
            emailField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.85),
            
            resetPasswordButton.topAnchor.constraint(equalTo: emailField.bottomAnchor, constant: 22),
            resetPasswordButton.centerXAnchor.constraint(equalTo: headerView.centerXAnchor),
            resetPasswordButton.heightAnchor.constraint(equalToConstant: 55),
            resetPasswordButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.85),
        ])
    }
    
    // MARK: - Selectors
    @objc private func didTapForgotPassword() {
        let email = self.emailField.text ?? ""
        
        if !Validator.isValidEmail(for: email) {
            AlertManager.showInvalidEmailAlert(on: self)
            return
        }
        
        AuthService.shared.forgotPassword(with: email) { [weak self] error in
            guard let self = self else { return }
            if let error = error {
                AlertManager.showErrorSendingPasswordReset(on: self, with: error)
                return
            }
            
            AlertManager.showPasswordResetSent(on: self)
        }
    }
}
