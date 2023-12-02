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
        view.backgroundColor = .systemGray6
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "Logout",
            style: .plain,
            target: self,
            action: #selector(didTapLogout)
        )
        
        view.addSubview(greetingLabel)
        view.addSubview(planesButton)
        view.addSubview(pilotsButton)
        view.addSubview(warehousePasswordButton)
        
        greetingLabel.translatesAutoresizingMaskIntoConstraints = false
        planesButton.translatesAutoresizingMaskIntoConstraints = false
        pilotsButton.translatesAutoresizingMaskIntoConstraints = false
        warehousePasswordButton.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            greetingLabel.topAnchor.constraint(equalTo:view.layoutMarginsGuide.topAnchor),
            greetingLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            greetingLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            greetingLabel.heightAnchor.constraint(equalToConstant: 200),
            
            planesButton.topAnchor.constraint(equalTo: greetingLabel.bottomAnchor, constant: 22),
            planesButton.centerXAnchor.constraint(equalTo: greetingLabel.centerXAnchor),
            planesButton.heightAnchor.constraint(equalToConstant: 55),
            planesButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.85),
            
            pilotsButton.topAnchor.constraint(equalTo: planesButton.bottomAnchor, constant: 22),
            pilotsButton.centerXAnchor.constraint(equalTo: greetingLabel.centerXAnchor),
            pilotsButton.heightAnchor.constraint(equalToConstant: 55),
            pilotsButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.85),
            
            warehousePasswordButton.topAnchor.constraint(equalTo: pilotsButton.bottomAnchor, constant: 22),
            warehousePasswordButton.centerXAnchor.constraint(equalTo: greetingLabel.centerXAnchor),
            warehousePasswordButton.heightAnchor.constraint(equalToConstant: 55),
            warehousePasswordButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.85)
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
        let vc = PlanesViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc private func didTapPilots() {
        let vc = PilotsViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc private func didTapWarehouse() {
        let vc = WarehouseViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
