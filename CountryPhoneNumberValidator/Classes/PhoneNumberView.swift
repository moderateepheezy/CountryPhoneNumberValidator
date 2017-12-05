//
//  PhoneNumberView.swift
//  PhoneNumberPicker
//
//  Created by SimpuMind on 11/6/17.
//  Copyright © 2017 SimpuMind. All rights reserved.
//

import UIKit
import PhoneNumberKit
import libPhoneNumber_iOS

protocol SetRegionDelegate: class {
    func setRegion(country: Country)
}

public class PhoneNumberView: UIView, SetRegionDelegate{
    
    let phoneNumberKit = PhoneNumberKit()
    var region = "ng"
    fileprivate var viewController: UIViewController!
    
    var flagImageView: UIImageView = {
       let iv = UIImageView()
        iv.image = #imageLiteral(resourceName: "nigeria")
        iv.contentMode = .scaleAspectFit
        iv.isUserInteractionEnabled = true
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    let plusLabel: UILabel = {
       let label = UILabel()
        label.text = "+"
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    var codeTextField: UITextField = {
       let tf = UITextField()
        tf.borderStyle = .none
        tf.keyboardType = .phonePad
        tf.textAlignment = .left
        tf.text = "234"
        tf.font = UIFont.boldSystemFont(ofSize: 20)
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    let midleView: UIView = {
       let v = UIView()
        v.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    let bottomView: UIView = {
        let v = UIView()
        v.backgroundColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    var phoneTextField: UITextField = {
        let tf = UITextField()
        tf.borderStyle = .none
        tf.keyboardType = .numberPad
        tf.font = UIFont.boldSystemFont(ofSize: 20)
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    var verifyButton: UIButton!
    
    
    public init(vc: UIViewController, button: UIButton) {
        super.init(frame: CGRect.zero)
        setUpView()
        configure()
        self.viewController = vc
        self.verifyButton = button
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
        setUpView()
    }
    
    fileprivate func configure(){
        flagImageView.clipsToBounds = true
        flagImageView.layer.cornerRadius = flagImageView.frame.height / 2
        
        codeTextField.delegate = self
        phoneTextField.delegate = self
        
        codeTextField.addTarget(self, action: #selector(searchRecordsAsPerText(textField:)), for: .editingChanged)
        
        flagImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleFlagTapped)))
    }
    
    @objc private func handleFlagTapped(){
        let vc = CountryListVC()
        vc.delegate = self
        viewController.present(vc, animated: true, completion: nil)
    }
    
    @objc private func searchRecordsAsPerText(textField: UITextField){
        guard let text = textField.text, !text.isEmpty else { return }
        
        if let country = Country.loadCountryFromJson().first(where: { text == $0.dialCode && $0.priority == 0 }) {
            region = country.iso2
            self.flagImageView.image = UIImage(named: country.flag)
        } else {
            self.flagImageView.image = nil
        }
    }
    
    public func validate(completed: @escaping (Bool) -> ()){
        guard let text = phoneTextField.text, !text.isEmpty, let _ = codeTextField.text else { return }
         completed(validatePhoneNumber(number: text, region: self.region))
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpView(){
        
        [flagImageView, plusLabel, codeTextField,
         midleView, phoneTextField, bottomView]
            .forEach {addSubview($0)}
        
        bottomView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        bottomView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        
        bottomView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        bottomView.heightAnchor.constraint(equalToConstant: 2).isActive = true
        
        flagImageView.widthAnchor.constraint(equalToConstant: 30).isActive = true
        flagImageView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        flagImageView.heightAnchor.constraint(equalToConstant: 30).isActive = true
        flagImageView.bottomAnchor.constraint(equalTo: bottomView.topAnchor, constant: -5).isActive = true
        
        plusLabel.leftAnchor.constraint(equalTo: flagImageView.rightAnchor, constant: 10).isActive = true
        plusLabel.widthAnchor.constraint(equalToConstant: 15).isActive = true
        plusLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        plusLabel.bottomAnchor.constraint(equalTo: bottomView.topAnchor, constant: -10).isActive = true
        
        codeTextField.widthAnchor.constraint(equalToConstant: 45).isActive = true
        codeTextField.leftAnchor.constraint(equalTo: plusLabel.rightAnchor, constant: 5).isActive = true
        codeTextField.heightAnchor.constraint(equalToConstant: 30).isActive = true
        codeTextField.bottomAnchor.constraint(equalTo: bottomView.topAnchor, constant: -5).isActive = true
        
        midleView.widthAnchor.constraint(equalToConstant: 1).isActive = true
        midleView.heightAnchor.constraint(equalToConstant: 30).isActive = true
        midleView.bottomAnchor.constraint(equalTo: bottomView.topAnchor, constant: -8).isActive = true
        midleView.leftAnchor.constraint(equalTo: codeTextField.rightAnchor).isActive = true
        
        phoneTextField.bottomAnchor.constraint(equalTo: bottomView.topAnchor, constant: -5).isActive = true
        phoneTextField.leftAnchor.constraint(equalTo: midleView.rightAnchor, constant: 10).isActive = true
        phoneTextField.heightAnchor.constraint(equalToConstant: 30).isActive = true
        phoneTextField.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        
    }
    
    private func validatePhoneNumber(number: String, region: String) -> Bool{
        var isValid = false
        let phoneUtil = NBPhoneNumberUtil()
        do {
            let phoneNumber: NBPhoneNumber = try phoneUtil.parse(number, defaultRegion: region.capitalized)
            if phoneUtil.isValidNumber(phoneNumber) {
                bottomView.backgroundColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
                isValid = true
            }else{
                isValid = false
                bottomView.backgroundColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
            }
        }
        catch let error as NSError {
            print(error.localizedDescription)
            bottomView.backgroundColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
            isValid = false
        }
        return isValid
    }
    
    func setRegion(country: Country) {
        self.region = country.iso2
        self.flagImageView.image = UIImage(named: "\(country.flag)")
        self.codeTextField.text = country.dialCode
    }
}

extension PhoneNumberView: UITextFieldDelegate{

    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == codeTextField {
            guard let text = textField.text else { return true }
            let newLength = text.count + string.count - range.length
            return newLength <= 4
        }else if textField == phoneTextField{
            guard let text  = textField.text else { return true }
            let newLength = text.count + string.count - range.length
            let islimited = (newLength >= 9 && newLength <= 16)
            verifyButton.backgroundColor = (!islimited) ? #colorLiteral(red: 0.1411764706, green: 0.231372549, blue: 0.4196078431, alpha: 0.5411226455) : #colorLiteral(red: 0.1411764706, green: 0.231372549, blue: 0.4196078431, alpha: 1)
            verifyButton.isEnabled = islimited
        }
        return true
    }
}
