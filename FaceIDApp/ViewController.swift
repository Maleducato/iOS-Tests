//
//  ViewController.swift
//  FaceIDApp
//
//  Created by Marco Loprete on 26.01.22.
//

import UIKit
import LocalAuthentication

class ViewController: UIViewController {
    @IBOutlet weak var signInLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    
        
    }

    @IBAction func signInClicked(_ sender: Any) {
        let authConext = LAContext()
        var error : NSError?
        
        if authConext.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            
            authConext.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: "Is it you?") { success, error in
                if success == true {
                    //Success
                    DispatchQueue.main.async {
                        self.performSegue(withIdentifier: "toSecondVC", sender: nil)
                    }
                    
                } else {
                    DispatchQueue.main.async {
                        self.signInLabel.text = "Error"
                    }
                   
                }
            }
            
        } else {
            showAlert(titleInput: "Error", messageInput: "No Biometric Authentication supported by this device")
        }
    }
    
    func showAlert(titleInput: String, messageInput: String){
        let alert = UIAlertController(title: titleInput, message: messageInput, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "Ok", style: UIAlertAction.Style.default) 
        alert.addAction(okButton)
        self.present(alert, animated: true, completion: nil)
    }
    
}

