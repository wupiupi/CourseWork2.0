//
//  LoginController.swift
//  CourseWork2.0
//
//  Created by Paul Makey on 21.11.23.
//

import UIKit

class LoginController: UIViewController {
    
    // MARK: - UI Components
    private let headerView = AuthHeaderView(
        title: "Sign in",
        subtitle: "Sign in to your account"
    )
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
    }
    
    // MARK: - Setup UI
    private func setupUI() {
        self.view.backgroundColor = .systemGray6
        self.view.addSubview(headerView)
        
        headerView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.headerView.topAnchor.constraint(equalTo: self.view.topAnchor),
            self.headerView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.headerView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.headerView.heightAnchor.constraint(equalToConstant: 270)
        ])
    }
    
}
