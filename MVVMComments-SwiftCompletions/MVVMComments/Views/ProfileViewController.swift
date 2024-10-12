//
//  ProfileViewController.swift
//  MVVMComments
//
//  Created by Manan Patel on 2024-08-28.
//

import Foundation

import UIKit
import SwiftUI

class ProfileViewController: UIViewController {
    
    let nameLabel: UILabel = {
        let lbl = UILabel()
        lbl.numberOfLines = 0
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    let emailLabel: UILabel = {
        let lbl = UILabel()
        lbl.numberOfLines = 0
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    var model: UserViewModel {
        didSet {
            updateUI()
        }
    }
    init(model: UserViewModel) {
        self.model = model
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        updateUI()
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        // Add labels to the view
        view.addSubview(nameLabel)
        view.addSubview(emailLabel)
        
        // Set up constraints for nameLabel
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            nameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            nameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            nameLabel.heightAnchor.constraint(equalToConstant: 44)
        ])
        
        // Set up constraints for emailLabel
        NSLayoutConstraint.activate([
            emailLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 20),
            emailLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            emailLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            emailLabel.heightAnchor.constraint(equalToConstant: 44)
            
        ])
    }
    
    func updateUI() {
        // Update UI with user data if available
        if let user = model.user {
            nameLabel.text = "Name: \(user.name)"
            emailLabel.text = "Email: \(user.email)"
        }
    }
}

struct ProfileViewControllerRepresentable: UIViewControllerRepresentable {
    
    @ObservedObject var model: UserViewModel
    
    func makeUIViewController(context: Context) -> ProfileViewController {
        return ProfileViewController(model: model)
    }
    
    func updateUIViewController(_ uiViewController: ProfileViewController, context: Context) {
        DispatchQueue.main.async {
            uiViewController.updateUI()
        }
        
    }
}

struct UserView: View {
    @State private var model: UserViewModel
    @Binding var selectedUserId: Int
    
    init(userService: UserServiceProtocol, selectedUserId: Binding<Int>) {
        _model = State(wrappedValue: UserViewModel(userService: userService))
        _selectedUserId = selectedUserId
    }
    
    var body: some View {
        VStack {
            ProfileViewControllerRepresentable(model: model)
        }
        .navigationTitle("User Profile")
        .onAppear {
            model.fetchUserData(id: String(selectedUserId))
        }
    }
}
