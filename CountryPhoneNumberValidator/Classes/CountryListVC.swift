//
//  CountryListVC.swift
//  PhoneNumberPicker
//
//  Created by SimpuMind on 12/4/17.
//  Copyright © 2017 SimpuMind. All rights reserved.
//

import UIKit

class CountryListVC: UIViewController {
    
    var delegate: SetRegionDelegate?
    
    let countrys = Country.loadCountryFromJson()
    
    fileprivate lazy var closeButton: UIButton = {
       let button = UIButton()
        button.setTitle("X", for: .normal)
        button.setTitleColor(.gray, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    fileprivate lazy var tableView: UITableView = {
       let tv = UITableView()
        tv.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        tv.translatesAutoresizingMaskIntoConstraints = false
        return tv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        print(countrys)
        [closeButton, tableView].forEach {view.addSubview($0)}
        
        closeButton.addTarget(self, action: #selector(handleClose), for: .touchUpInside)
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(CustomCell.self, forCellReuseIdentifier: "cell")
    }
    
    @objc func handleClose(){
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        closeButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -5).isActive = true
        closeButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 20).isActive = true
        closeButton.widthAnchor.constraint(equalToConstant: 50).isActive = true
        closeButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        tableView.topAnchor.constraint(equalTo: closeButton.bottomAnchor, constant: 10).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -10).isActive = true
    }
}

extension CountryListVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countrys.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CustomCell
        
        let country = countrys[indexPath.item]
        cell.configCell(country: country)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let country = countrys[indexPath.item]
        delegate?.setRegion(country: country)
        handleClose()
    }
}

class CustomCell: UITableViewCell {
    
    
    fileprivate lazy var flagImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    fileprivate lazy var countryNameLabel: UILabel = {
       let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    fileprivate lazy var dialCodeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textAlignment = .right
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configure()
    }
    
    func configCell(country: Country){
        flagImageView.image = UIImage(named: "\(country.flag)")
        countryNameLabel.text = country.name
        dialCodeLabel.text = "+\(country.dialCode)"
    }
    
    func configure() {
        [flagImageView, countryNameLabel, dialCodeLabel].forEach {addSubview($0)}
        
        flagImageView.leftAnchor.constraint(equalTo: leftAnchor, constant: 10).isActive = true
        flagImageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        flagImageView.widthAnchor.constraint(equalToConstant: 35).isActive = true
        flagImageView.heightAnchor.constraint(equalToConstant: 35).isActive = true
        
        countryNameLabel.leftAnchor.constraint(equalTo: flagImageView.rightAnchor, constant: 10).isActive = true
        countryNameLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        countryNameLabel.widthAnchor.constraint(equalToConstant: 300).isActive = true
        countryNameLabel.heightAnchor.constraint(equalToConstant: 15).isActive = true
        
        dialCodeLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -10).isActive = true
        dialCodeLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        dialCodeLabel.widthAnchor.constraint(equalToConstant: 70).isActive = true
        dialCodeLabel.heightAnchor.constraint(equalToConstant: 15).isActive = true
    }
}
