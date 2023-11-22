//
//  HomeController.swift
//  CourseWork2.0
//
//  Created by Paul Makey on 21.11.23.
//

import UIKit

class HomeController: UIViewController {
    
    // MARK: - UI Components
    private let label: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 24, weight: .semibold)
        label.text = "Loading..."
        label.numberOfLines = 2
        return label
    }()
    
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
        self.label.text = "Bruh..."
    }
    
    
    
    // MARK: - UI Setup
    private func setupUI() {
        self.view.backgroundColor = .systemGray6
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "Logout",
            style: .plain,
            target: self,
            action: #selector(didTapLogout)
        )
        
        self.view.addSubview(label)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: self.view.centerYAnchor)
        ])
    }
    
    
    // MARK: - Selectors
    @objc private func didTapLogout() {
        
    }
}
