//
//  LoginViewController.swift
//  MessangerApp
//
//  Created by 野澤拓己 on 2020/11/21.
//

import UIKit
import FirebaseAuth
import FBSDKLoginKit
import JGProgressHUD

class LoginViewController: UIViewController {
    
    let sppiner = JGProgressHUD(style: .dark)
    
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
        
        field.layer.cornerRadius = 12
        field.layer.borderWidth = 1
        field.layer.borderColor = UIColor.lightGray.cgColor
        field.layer.masksToBounds = true
        
        field.leftViewMode = .always
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 0))
        
        field.placeholder = "Email address...."
        return field
        
    }()
    
    private let passWordField: UITextField = {
       let field = UITextField()
        
        field.backgroundColor = .white
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.returnKeyType = .done
        field.isSecureTextEntry = true
        
        field.layer.cornerRadius = 12
        field.layer.borderWidth = 1
        field.layer.borderColor = UIColor.lightGray.cgColor
        field.layer.masksToBounds = true
        
        field.leftViewMode = .always
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 0))
        
        field.placeholder = "PassWord...."
        return field
        
    }()
    
    private let loginButton : UIButton = {
        let button = UIButton()
        button.setTitle("Log in", for: .normal)
        button.backgroundColor = .systemOrange
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 52/2
        button.layer.masksToBounds = true
        
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
        
        return button
    }()
    
    // FaceBookButton
    private let FBButton : FBLoginButton = {
        let button = FBLoginButton()
        button.permissions = ["email,public_profile"]
        
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Log In"
        view.backgroundColor = UIColor(named: "bg")
        
        addSubViews()
        configure()
        
    }
    
    // MARK: - addSubViews
    private func addSubViews() {
        
        view.addSubview(scrollView)
        scrollView.addSubview(emailField)
        scrollView.addSubview(imageView)
        scrollView.addSubview(passWordField)
        scrollView.addSubview(loginButton)
        scrollView.addSubview(FBButton)
    
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
        loginButton.frame = CGRect(
            x: 40,
            y: passWordField.bottom + 30,
            width: scrollView.width - 80,
            height: 52
        )
        
        // FaceBookLoginButton
        FBButton.frame = CGRect(
            x: 20 + scrollView.width/4,
            y: loginButton.bottom + 20,
            width: (scrollView.width - 80)/2,
            height: 40
        )
        
//        FBButton.center = scrollView.center
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
        loginButton.addTarget(self, action: #selector(didTapLoginButton), for: .touchUpInside)
        
        // emailField
        emailField.delegate = self
        
        // passWordField
        passWordField.delegate = self
        
        // FBButton
        FBButton.delegate = self
    }
    
    // MARK: - Actions
    @objc private func didTapRegister() {
        let vc = RegisterViewController()
        vc.title = "Create Account"
        navigationController?.pushViewController(vc, animated: true)
        
    }
    
    @objc private func didTapLoginButton() {
        
        // loginButtonを押すとkeyBoardを閉じる
        emailField.resignFirstResponder()
        passWordField.resignFirstResponder()
        
        // emailField, passWordFieldアンラップする
        guard let email = emailField.text, let password = passWordField.text, !email.isEmpty, !password.isEmpty, password.count >= 6 else {
            alertUserLoginError()
            return
        }
        
        sppiner.show(in: view)
        
        // Firebase Log In
        FirebaseAuth.Auth.auth().signIn(withEmail: email, password: password) { [weak self] (authResult, error) in
            
            guard let strongSelf = self else {
                return
            }
            
            DispatchQueue.main.async {
                strongSelf.sppiner.dismiss()
            }
            
            guard let result = authResult, error == nil else {
                print("このEmailではログインできません: Email\(email)")
                return
            }
            
            let user = result.user
            print("ログインユーザ: \(user)")
            
            
            strongSelf.navigationController?.dismiss(animated: true, completion: nil)
            
        }
        
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

// FacebookButtonDelegate
extension LoginViewController : LoginButtonDelegate {
    func loginButtonDidLogOut(_ loginButton: FBLoginButton) {
        // no operation
    }
    
    func loginButton(_ loginButton: FBLoginButton, didCompleteWith result: LoginManagerLoginResult?, error: Error?) {
        
        guard  let token = result?.token?.tokenString else {
            print("User failed to log in wiht facebook")
            return
        }
        
        let facebookRequest = FBSDKLoginKit.GraphRequest(
            graphPath: "me",
            parameters: ["fields": "email, name"],
            tokenString: token,
            version: nil,
            httpMethod: .get
        )
        
        facebookRequest.start { (_ , result, error) in
            guard let result = result as? [String: Any], error == nil else {
                print("Failed to make Facebook graph request")
                
                return
            }
            
            print("\(result)")
            
            guard let username = result["name"] as? String,
                  let email = result["email"] as? String else {
                
                print("Failed to get email and name from fb request")
                
                return
            }
            
            // firstNameとlastNameに分ける
            let nameComponents = username.components(separatedBy: " ")
            guard nameComponents.count == 2 else {
                return
            }
            
            let firstName = nameComponents[0]
            let lastName = nameComponents[1]
            
            DatabaseManager.shared.userExists(with: email, completion: { exists in
                
                if !exists {
                    DatabaseManager.shared.insertUsr(with: ChatAppUser(
                                                        firstName: firstName,
                                                        lastName: lastName,
                                                        emailAddress: email
                    ))
                }
                
            })
            
            
            let credentical = FacebookAuthProvider.credential(withAccessToken: token)
            
            FirebaseAuth.Auth.auth().signIn(with: credentical) { [weak self] (authResult, error) in
                
                guard let strongSelf = self else {
                    return
                }
                
                guard authResult != nil, error == nil else {
                    if let error = error {
                        print("Facebook credentical login failed, MFA may be needed - \(error)")
                    }
                    
                    return
                }
                
                print("succecfully logged user in")
                strongSelf.navigationController?.dismiss(animated: true, completion: nil)
                
                
            }
        }
        
        
        

        
        
    }
    
    
    
}
