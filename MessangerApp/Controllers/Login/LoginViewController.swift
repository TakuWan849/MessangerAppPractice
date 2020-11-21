//
//  LoginViewController.swift
//  MessangerApp
//
//  Created by 野澤拓己 on 2020/11/21.
//

import UIKit

class LoginViewController: UIViewController {
    
    private let scrollView: UIScrollView = {
       let view = UIScrollView()
        view.clipsToBounds = true
        return view
    }()
    
    private let imageView : UIImageView = {
       let imageView = UIImageView()
        imageView.image = UIImage(named: "chat")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let emailField: UITextField = {
       let field = UITextField()
        
        field.backgroundColor = .white
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.returnKeyType = .continue
        
        field.layer.cornerRadius = 52/2
        field.layer.borderWidth = 1
        field.layer.borderColor = UIColor.lightGray.cgColor
        field.layer.masksToBounds = true
        
        field.leftViewMode = .always
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 0))
        
        field.placeholder = "email address...."
        return field
        
    }()
    
    private let passWordField: UITextField = {
       let field = UITextField()
        
        field.backgroundColor = .white
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.returnKeyType = .done
        field.isSecureTextEntry = true
        
        field.layer.cornerRadius = 52/2
        field.layer.borderWidth = 1
        field.layer.borderColor = UIColor.lightGray.cgColor
        field.layer.masksToBounds = true
        
        field.leftViewMode = .always
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 0))
        
        field.placeholder = "passWord...."
        return field
        
    }()
    
    private let LoginButton : UIButton = {
        let button = UIButton()
        button.setTitle("Log in", for: .normal)
        button.backgroundColor = .link
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 12
        button.layer.masksToBounds = true
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
        
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Log In"
        view.backgroundColor = .white
        
        addSubViews()
        configure()
        
    }
    
    // MARK: - addSubViews
    private func addSubViews() {
        
        view.addSubview(scrollView)
        scrollView.addSubview(emailField)
        scrollView.addSubview(imageView)
        scrollView.addSubview(passWordField)
        scrollView.addSubview(LoginButton)
    }
    
    // MARK: - viewDidLayoutSubViews
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        scrollView.frame = view.bounds
        let size = scrollView.width / 3
        
        // logo
        imageView.frame = CGRect(
            x: (scrollView.width - size)/2,
            y: 20,
            width: size,
            height: size
        )
        
        // input email
        emailField.frame = CGRect(
            x: 30,
            y: imageView.bottom + 30,
            width: scrollView.width - 60,
            height: 52
        )
        
        // input password
        passWordField.frame = CGRect(
            x: 30,
            y: emailField.bottom + 15,
            width: scrollView.width - 60,
            height: 52
        )
        
        // tappedLogin
        LoginButton.frame = CGRect(
            x: 40,
            y: passWordField.bottom + 30,
            width: scrollView.width - 80,
            height: 52
        )
    }
    
    // MARK:- configure
    private func configure() {
        
        // NavigationBar
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "Register",
            style: .done,
            target: self,
            action: #selector(didTapRegister)
        )
        
        // LoginButton
        LoginButton.addTarget(self, action: #selector(didTapLoginButton), for: .touchUpInside)
        
        // emailField
        emailField.delegate = self
        
        // passWordField
        passWordField.delegate = self
    }
    
    // MARK: - Actions
    @objc private func didTapRegister() {
        let vc = RegisterViewController()
        vc.title = "Create Account"
        navigationController?.pushViewController(vc, animated: true)
        
    }
    
    @objc private func didTapLoginButton() {
        
        // emailField, passWordFieldアンラップする
        guard let email = emailField.text, let password = passWordField.text, !email.isEmpty, !password.isEmpty, password.count >= 6 else {
            alertUserLoginError()
            return
        }
        
        // Firebase Log In
        
        
    }
    
    func alertUserLoginError() {
        let alert = UIAlertController(
            title: "Woops",
            message: "Please enter all information",
            preferredStyle: .alert
        )
        
        alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
        
        present(alert, animated: true)
        
    }
    

}

extension LoginViewController : UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if textField == emailField {
            passWordField.becomeFirstResponder()
            
        }
        else if textField == passWordField {
            didTapLoginButton()
            
        }
        
        return true
    }
}
