//
//  ViewController.swift
//  CountryPhoneNumberValidator
//
//  Created by moderateepheezy on 12/05/2017.
//  Copyright (c) 2017 moderateepheezy. All rights reserved.
//

import UIKit
import CountryPhoneNumberValidator

class ViewController: UIViewController {
    
    var verifyButton: UIButton = {
        let button = UIButton()
        button.setTitle("Verfiy", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = #colorLiteral(red: 0.1411764706, green: 0.231372549, blue: 0.4196078431, alpha: 0.5411226455)
        button.isEnabled = false
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    var phoneView: PhoneNumberView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        phoneView = PhoneNumberView(vc: self, button: verifyButton)
        phoneView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(phoneView)
        view.addSubview(verifyButton)
        verifyButton.addTarget(self, action: #selector(verifyPhoneNumber), for: .touchUpInside)
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        phoneView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        phoneView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        phoneView.widthAnchor.constraint(equalToConstant: 300).isActive = true
        phoneView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        verifyButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -15).isActive = true
        verifyButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 15).isActive = true
        verifyButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -15).isActive = true
        verifyButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }
    
    @objc func verifyPhoneNumber() {
        phoneView.validate { (completed) in
            if completed {
                self.showAlert(withTitle: "Success", message: "PhoneNumber is Valid")
            }else{
                self.showAlert(withTitle: "", message: "The phone number is not valid.")
            }
        }
    }
}

extension UIViewController {
    func showAlert(withTitle title: String, message: String, completion: (()->())? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "Okay", style: .default) { (alert) in
            guard let completion = completion else {
                return
            }
            completion()
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
}

