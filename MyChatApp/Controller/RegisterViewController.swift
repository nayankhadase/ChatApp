//
//  RegisterViewController.swift
//  MyChatApp
//
//  Created by nayan.khadase on 22/10/21.
//  Copyright © 2021 nayan.khadase. All rights reserved.
//

import UIKit
import Firebase
class RegisterViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    


    @IBAction func registerBtnPressed(_ sender: UIButton) {
        if let email = emailTextField.text, let password = passTextField.text{
            Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                if let e = error{
                    print(e.localizedDescription) // error description in users language
                }else{
                    // perform segue to the chat page
                    self.performSegue(withIdentifier: K.registerToChat, sender: self)
                }
            }
        }
        }
        
}
