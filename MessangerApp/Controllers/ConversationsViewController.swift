//
//  ConversationsViewController.swift
//  MessangerApp
//
//  Created by 野澤拓己 on 2020/11/21.
//

import UIKit

class ConversationsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .red
        
    }
    

    
    // MARK:- v iewDidAppear
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let isLoggedIn = UserDefaults.standard.bool(forKey: "logged_in")
        
        // isLoggedInがfalseならログイン画面に遷移
        if !isLoggedIn {
            let vc = LoginViewController()
            let navVC = UINavigationController(rootViewController: vc)
            navVC.modalPresentationStyle = .fullScreen
            
            present(navVC, animated: true)
        }
        
    }


}
