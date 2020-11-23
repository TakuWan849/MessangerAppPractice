//
//  RegisterViewController.swift
//  MessangerApp
//
//  Created by 野澤拓己 on 2020/11/21.
//

import UIKit
import FirebaseAuth

class RegisterViewController: UIViewController {

    private let scrollView: UIScrollView = {
       let view = UIScrollView()
        view.clipsToBounds = true
        return view
    }()
    
    private let imageView : UIImageView = {
       let imageView = UIImageView()
        imageView.image = UIImage(systemName: "person.crop.circle")
        imageView.tintColor = .gray
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        imageView.layer.borderWidth = 2
        imageView.layer.borderColor = UIColor.lightGray.cgColor
         
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
    
    private let firstNameField: UITextField = {
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
        
        field.placeholder = "First Name..."
        return field
        
    }()
    
    private let lastNameField: UITextField = {
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
        
        field.placeholder = "Last Name..."
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
    
   
    private let registerButton : UIButton = {
        let button = UIButton()
        button.setTitle("Register", for: .normal)
        button.backgroundColor = .systemGreen
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 52/2
        button.layer.masksToBounds = true
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
        
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Create Account"
        view.backgroundColor = UIColor(named: "Color")
        
        addSubViews()
        configure()
        
    }
    
    // MARK: - addSubViews
    private func addSubViews() {
        
        view.addSubview(scrollView)
        scrollView.addSubview(imageView)
        scrollView.addSubview(emailField)
        scrollView.addSubview(firstNameField)
        scrollView.addSubview(lastNameField)
        scrollView.addSubview(passWordField)
        scrollView.addSubview(registerButton)
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
        imageView.layer.cornerRadius = imageView.width / 2.0
        
        // input firstName
        firstNameField.frame = CGRect(
            x: 30,
            y: imageView.bottom + 15,
            width: (scrollView.width - 60),
            height: 52
        )
        
        // input lastName
        lastNameField.frame = CGRect(
            x: 30,
            y: firstNameField.bottom + 15,
            width: (scrollView.width - 60),
            height: 52
        )
        
        // input email
        emailField.frame = CGRect(
            x: 30,
            y: lastNameField.bottom + 15,
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
        
        // TappedRegister
        registerButton.frame = CGRect(
            x: 40,
            y: passWordField.bottom + 30,
            width: scrollView.width - 80,
            height: 52
        )
    }
    
    // MARK:- configure
    private func configure() {
        
        // registerButton
        registerButton.addTarget(self, action: #selector(didTapregisterButton), for: .touchUpInside)
        
        // emailField
        emailField.delegate = self
        
        // passWordField
        passWordField.delegate = self
        
        // imageViewのタップ時のイベント
        configureTapGesture()
        
    }
    
    private func configureTapGesture() {
        
        // タップイベントが使えるようになる
        imageView.isUserInteractionEnabled = true
        scrollView.isUserInteractionEnabled = true
        
        // imageViewにタップしたら画像を変える処理を記述
        let gesture = UITapGestureRecognizer(target: self, action: #selector(didTapChangeProfilePic))
//        gesture.numberOfTouchesRequired
        // タップ回数
//        gesture.numberOfTapsRequired = 1
        imageView.addGestureRecognizer(gesture)
    }
    
    // MARK: - Actions
    
    // Change Profile pic
    @objc private func didTapChangeProfilePic() {
        
        presentPhotoActionSheet()
    }
    
    @objc private func didTapRegister() {
        let vc = RegisterViewController()
        vc.title = "Create Account"
        navigationController?.pushViewController(vc, animated: true)
        
    }
    
    @objc private func didTapregisterButton() {
        
        // registerButtonを押すとkeyBoardを閉じる
        emailField.resignFirstResponder()
        passWordField.resignFirstResponder()
        firstNameField.resignFirstResponder()
        lastNameField.resignFirstResponder()
        
        // emailField, passWordFieldアンラップする
        guard let firstName = firstNameField.text,
              let lastName = lastNameField.text,
              let email = emailField.text,
              let password = passWordField.text,
              !firstName.isEmpty,
              !lastName.isEmpty,
              !email.isEmpty,
              !password.isEmpty,
              password.count >= 6 else {
            
            alertUserLoginError()
            
            return
        }
        
        // Firebase Log In
        
        FirebaseAuth.Auth.auth().createUser(withEmail: email, password: password) { authResult, error  in
            
            guard let result = authResult, error == nil else {
                print("Error createing user")
                return
            }
            
            let user = result.user
            print("Created User : \(user)")
            
            
        }
        
    }
        

    
    func alertUserLoginError() {
        let alert = UIAlertController(
            title: "Woops",
            message: "Please enter all information to a create new account",
            preferredStyle: .alert
        )
        
        alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
        
        present(alert, animated: true)
        
    }
    

}

extension RegisterViewController : UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if textField == emailField {
            passWordField.becomeFirstResponder()
            
        }
        else if textField == passWordField {
            didTapregisterButton()
            
        }
        
        return true
    }

}

extension RegisterViewController : UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func presentPhotoActionSheet() {
        
        let actionSheet = UIAlertController(title: "Profile Picture",
                                            message: "How would you like to select a picture?",
                                            preferredStyle: .actionSheet)
        
        actionSheet.addAction(UIAlertAction(title: "Cancel",
                                            style: .cancel,
                                            handler: nil))
        
        // 写真を撮る -> closureで管理
        actionSheet.addAction(UIAlertAction(title: "Take Photo",
                                            style: .default,
                                            // 同じクラスの関数をクロージャ内に呼び込むために[weak self]が必要
                                            // 弱参照にして循環参照を防ぐ
                                            handler: { [weak self] _ in
                                                
                                                self?.presentCamera()
                                                
                                            }))
        
        // 写真を選ぶ -> closureで管理
        actionSheet.addAction(UIAlertAction(title: "Choose Photo",
                                            style: .default,
                                            handler: { [weak self] _ in
                                                
                                                self?.presentPhotoPicker()
                                                
                                            }))
        
        present(actionSheet, animated: true)
        
    }
    
    // pictureのactionSheet -> closure内で呼ばれる処理の記述
    func presentCamera() {
        
        let vc = UIImagePickerController()
        vc.sourceType = .camera
        vc.delegate = self
        vc.allowsEditing = true
        
        present(vc, animated: true)
         
    }
    
    func presentPhotoPicker() {
        
        let vc = UIImagePickerController()
        vc.sourceType = .photoLibrary
        vc.delegate = self
        vc.allowsEditing = true
        
        present(vc, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        picker.dismiss(animated: true, completion: nil)
        print(info)
        
        // アンラップしてダウンキャスト
        guard let selectedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage else {
            return
        }
        self.imageView.image = selectedImage
    }
    
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    
}
