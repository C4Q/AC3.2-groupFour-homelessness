//
//  ProfileViewController.swift
//  Employed
//
//  Created by Kadell on 2/18/17.
//  Copyright © 2017 Employed Inc. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController, UITableViewDelegate,UITableViewDataSource{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        setUpViews()
        setUpTableView()
    }
    
    func setUpViews(){
        self.view.addSubview(profileBackGround)
        self.profileBackGround.addSubview(profilePic)
        self.profileBackGround.addSubview(addResume)
        self.profileBackGround.addSubview(nameLabel)
        self.view.addSubview(infoTableView)
        self.view.addSubview(addResume)
        
        self.edgesForExtendedLayout = []
        
        addResume.addTarget(self, action: #selector(uploadResume), for: .touchUpInside)
        
        profileBackGround.snp.makeConstraints { (view) in
            view.top.leading.trailing.equalToSuperview()
            view.height.equalToSuperview().multipliedBy(0.4)
        }
        
        profilePic.snp.makeConstraints { (view) in
            view.top.equalToSuperview().offset(20)
            view.centerX.equalToSuperview()
            view.size.equalTo(CGSize(width: 150, height: 150))
        }
        
        nameLabel.snp.makeConstraints { (view) in
            view.centerX.equalToSuperview()
            view.top.equalTo(profilePic.snp.bottom).offset(10)
            
        }
        
        addResume.snp.makeConstraints { (view) in
            view.top.equalTo(nameLabel.snp.bottom).offset(10)
            view.centerX.equalToSuperview()
            view.width.equalToSuperview().multipliedBy(0.3)
        }
        
        infoTableView.snp.makeConstraints { (view) in
            view.top.equalTo(profileBackGround.snp.bottom)
            view.bottom.leading.trailing.equalToSuperview()
        }
    }
    
    
    func uploadResume(){
        print("Upload resume")
    }
    
    func setUpTableView(){
        self.infoTableView.delegate = self
        self.infoTableView.dataSource = self
        infoTableView.register(InfoTableViewCell.self, forCellReuseIdentifier: InfoTableViewCell.cellIdentifier)
    }
    
    //MARK :- TableView degelgate methods
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: InfoTableViewCell.cellIdentifier, for: indexPath) as! InfoTableViewCell
        
        return cell
    }
    
    //MARK: - Views
    
    internal let profilePic: UIImageView = {
        let imageView = UIImageView()
        
        imageView.layer.cornerRadius = 75
        imageView.isUserInteractionEnabled = true
        imageView.layer.shadowColor = UIColor.black.cgColor
        imageView.layer.shadowOpacity = 0.4
        imageView.layer.shadowOffset = CGSize(width: 1, height: 5)
        imageView.layer.shadowRadius = 2
        imageView.layer.borderColor = UIColor.white.cgColor
        imageView.layer.borderWidth = 5
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "onepunch")
        imageView.layer.masksToBounds = true
        return imageView
        
    }()
    
    
    internal let infoTableView: UITableView = {
        let tableview: UITableView = UITableView()
        tableview.backgroundColor = .red
        return tableview
    }()
    
    internal let addResume: UIButton = {
        let button: UIButton = UIButton(type: UIButtonType.system)
        button.setTitle("Add Resume", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.borderWidth = 2
        return button
    }()
    
    internal let profileBackGround: UIImageView = {
        let imageView: UIImageView = UIImageView()
        imageView.image = UIImage(named: "onepunch")
        let blurEffect: UIBlurEffect = UIBlurEffect(style: UIBlurEffectStyle.regular)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = imageView.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        imageView.addSubview(blurEffectView)
        return imageView
    }()
    
    internal let nameLabel: UILabel = {
        let label: UILabel = UILabel()
        label.text = "One Punch"
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 20)
        return label
    }()
    
    
}
