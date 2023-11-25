//
//  HomeController.swift
//  CourseWork2.0
//
//  Created by Paul Makey on 23.11.23.
//

import UIKit

final class HomeController: UIViewController {
    
    // MARK: - UI Components
    let planesButton = CustomButton(
        title: "Planes",
        hasBackground: true,
        fontSize: .medium,
        textColor: .label
    )
    private let pilotsButton = CustomButton(
        title: "Pilots",
        hasBackground: true,
        fontSize: .medium,
        textColor: .label
    )
    private let warehousePasswordButton = CustomButton(
        title: "Warehouse",
        hasBackground: true,
        fontSize: .medium,
        textColor: .label
    )
    
    private let greetingLabel: UILabel = {
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
        self.setupUI()
        
        self.planesButton.addTarget(
            self,
            action: #selector(didTapPlanes),
            for: .touchUpInside
        )
        
        self.pilotsButton.addTarget(
            self,
            action: #selector(didTapPilots),
            for: .touchUpInside
        )
        
        self.warehousePasswordButton.addTarget(
            self,
            action: #selector(didTapWarehouse),
            for: .touchUpInside
        )
        
        
        AuthService.shared.fetchUser { [weak self] user, error in
            guard let self = self else { return }
            if let error = error {
                AlertManager.showFetchingUserError(on: self, with: error)
                return
            }
            
            if let user {
                self.greetingLabel.text = "Welcome back, \(user.username)!"
            }
        }
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
        
        self.view.addSubview(greetingLabel)
        self.view.addSubview(planesButton)
        self.view.addSubview(pilotsButton)
        self.view.addSubview(warehousePasswordButton)
        
        greetingLabel.translatesAutoresizingMaskIntoConstraints = false
        planesButton.translatesAutoresizingMaskIntoConstraints = false
        pilotsButton.translatesAutoresizingMaskIntoConstraints = false
        warehousePasswordButton.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            self.greetingLabel.topAnchor.constraint(equalTo: self.view.layoutMarginsGuide.topAnchor),
            self.greetingLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.greetingLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.greetingLabel.heightAnchor.constraint(equalToConstant: 200),
            
            self.planesButton.topAnchor.constraint(equalTo: greetingLabel.bottomAnchor, constant: 22),
            self.planesButton.centerXAnchor.constraint(equalTo: greetingLabel.centerXAnchor),
            self.planesButton.heightAnchor.constraint(equalToConstant: 55),
            self.planesButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.85),
            
            self.pilotsButton.topAnchor.constraint(equalTo: planesButton.bottomAnchor, constant: 22),
            self.pilotsButton.centerXAnchor.constraint(equalTo: greetingLabel.centerXAnchor),
            self.pilotsButton.heightAnchor.constraint(equalToConstant: 55),
            self.pilotsButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.85),
            
            self.warehousePasswordButton.topAnchor.constraint(equalTo: pilotsButton.bottomAnchor, constant: 22),
            self.warehousePasswordButton.centerXAnchor.constraint(equalTo: greetingLabel.centerXAnchor),
            self.warehousePasswordButton.heightAnchor.constraint(equalToConstant: 55),
            self.warehousePasswordButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.85)
        ])
    }
    
    // MARK: - Selectors
    @objc private func didTapLogout() {
        AuthService.shared.signOut { [weak self] error in
            guard let self = self else { return }
            if let error = error {
                AlertManager.showLogoutError(on: self, with: error)
                return
            }
            
            if let sceneDelegate = self.view.window?.windowScene?.delegate as? SceneDelegate {
                sceneDelegate.checkAuthentication()
            }
        }
    }
    
    @objc private func didTapPlanes() {
        let vc = WebViewerController(with: "https://www.mil.by/ru/forces/vvspvo/equipment/134/")
        let nav = UINavigationController(rootViewController: vc)
        self.present(nav, animated: true, completion: nil)
    }
    
    @objc private func didTapPilots() {
        let vc = WebViewerController(with: "https://www.mil.by/ru/forces/vvspvo/command/")
        let nav = UINavigationController(rootViewController: vc)
        self.present(nav, animated: true, completion: nil)
    }
    
    @objc private func didTapWarehouse() {
        let vc = WarehouseViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
