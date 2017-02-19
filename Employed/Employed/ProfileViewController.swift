//
//  ProfileViewController.swift
//  Employed
//
//  Created by Kadell on 2/18/17.
//  Copyright © 2017 Employed Inc. All rights reserved.
//

import UIKit
import FirebaseAuth
import Photos
import MobileCoreServices


class ProfileViewController: UIViewController, UITableViewDelegate,UITableViewDataSource,UINavigationControllerDelegate,UIImagePickerControllerDelegate{
    private lazy var imagePickerController: UIImagePickerController = UIImagePickerController()

    //Can be used to populate profile tableview
    private let infoImageArray: [UIImage] = []
    private let infoDetails: [String:String] = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let rightBarButton = UIBarButtonItem(customView: logOutButton)
        self.navigationItem.rightBarButtonItem = rightBarButton
        self.navigationItem.hidesBackButton = true
        
        self.view.backgroundColor = .white
        setUpViews()
        setUpTableView()
        //setImagePicker()
    }
    
    func setUpViews(){
        self.view.addSubview(profileBackGround)
        self.profileBackGround.addSubview(addResume)
        self.profileBackGround.addSubview(nameLabel)
        self.view.addSubview(infoTableView)
        self.view.addSubview(addResume)
        self.profileBackGround.addSubview(profilePic)
        
        self.edgesForExtendedLayout = []
        
        logOutButton.addTarget(self, action: #selector(logOut), for: .touchUpInside)
        
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
        
        addResume.addTarget(self, action: #selector(showCamera), for: .touchUpInside)
        
        infoTableView.snp.makeConstraints { (view) in
            view.top.equalTo(profileBackGround.snp.bottom)
            view.bottom.leading.trailing.equalToSuperview()
        }
    }
    
    func showCamera(){
        self.tabBarController?.present(imagePickerController, animated: true, completion: nil)
        // present(imagePickerController, animated: true, completion: nil)
    }
    
    func setUpTableView(){
        self.infoTableView.delegate = self
        self.infoTableView.dataSource = self
        self.infoTableView.rowHeight = UITableViewAutomaticDimension
        self.infoTableView.estimatedRowHeight = 200
        infoTableView.register(InfoTableViewCell.self, forCellReuseIdentifier: InfoTableViewCell.cellIdentifier)
    }
    

    func setImagePicker(){
        imagePickerController.delegate = self
        imagePickerController.sourceType = .camera
        imagePickerController.modalPresentationStyle = .currentContext
        
        let overlay: CameraOverlayView = CameraOverlayView()
        overlay.layer.frame = UIScreen.main.bounds
        //View covers use photo button
        //imagePickerController.cameraOverlayView = overlay
        
    }

    func logOut() {
        do{
            try FIRAuth.auth()?.signOut()

        }
        catch{
            let alertController = UIAlertController(title: "Error", message: "Trouble Logging Out", preferredStyle: UIAlertControllerStyle.alert)
            let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
            alertController.addAction(okAction)
            self.present(alertController, animated: true, completion: nil)
        }
        
         let _ = self.navigationController?.popToRootViewController(animated: true)
     }
    
    func handleTap() {
        print("TAPPPPED???")
        let imagePickerController = UIImagePickerController()
        
        imagePickerController.allowsEditing = true
        imagePickerController.sourceType = .photoLibrary
        imagePickerController.mediaTypes = [ String(kUTTypeImage) ]
        imagePickerController.delegate = self
        
        self.present(imagePickerController, animated: true, completion:  nil)
    }
    
    
    //MARK: -ImagePicker delegates 
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
         var selectedImageFromPicker: UIImage?
        
        if let originalImage = info["UIImagePickerControllerOriginalImage"] {
            selectedImageFromPicker = originalImage as? UIImage
        }
        
        if let selectedImage = selectedImageFromPicker {
            profilePic.image = selectedImage
            profileBackGround.image = selectedImage
        }
        
        dismiss(animated: true, completion: nil)

    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
         dismiss(animated: true, completion: nil)
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
//    
//    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
//        
//        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage{
//            dismiss(animated: true, completion: nil)
//            if let imageData = EmployedFileManager.shared.convertToPDf(image: image){
//                EmployedFileManager.shared.saveFile(data: imageData)
//                if let pdfUrl = EmployedFileManager.shared.retreivePDF(){
//                    let resumeVC = ResumePreviewViewController()
//                    resumeVC.pdfUrl = URLRequest(url: pdfUrl)
//                    present(resumeVC, animated: true, completion: nil)
//                }
//            }
//        }
//    }
    
    //MARK: - Views
    
    lazy var profilePic: UIImageView = {
        let imageView = UIImageView()
        
        imageView.layer.cornerRadius = 75
        imageView.layer.shadowColor = UIColor.black.cgColor
        imageView.layer.shadowOpacity = 0.4
        imageView.layer.shadowOffset = CGSize(width: 1, height: 5)
        imageView.layer.shadowRadius = 2
        imageView.layer.borderColor = UIColor.white.cgColor
        imageView.layer.borderWidth = 5
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "onepunch")
        imageView.layer.masksToBounds = true
        imageView.isUserInteractionEnabled = true
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        imageView.addGestureRecognizer(tap)
        
        return imageView
    }()
    
    
    lazy var infoTableView: UITableView = {
        let tableview: UITableView = UITableView()
        tableview.backgroundColor = .red
        return tableview
    }()
    
    lazy var addResume: UIButton = {
        let button: UIButton = UIButton(type: UIButtonType.system)
        button.setTitle("Add Resume", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.borderWidth = 2
        return button
    }()
    
    lazy var profileBackGround: UIImageView = {
        let imageView: UIImageView = UIImageView()
        imageView.image = UIImage(named: "onepunch")
        let blurEffect: UIBlurEffect = UIBlurEffect(style: UIBlurEffectStyle.regular)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = imageView.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        imageView.addSubview(blurEffectView)
        imageView.isUserInteractionEnabled = true
        return imageView
    }()
    
    lazy var nameLabel: UILabel = {
        let label: UILabel = UILabel()
        label.text = "One Punch"
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 20)
        return label
    }()
    
    lazy var logOutButton: UIButton = {
        let button = UIButton(type: UIButtonType.custom)
        button.setTitle("LogOut", for: .normal)
        button.frame = CGRect(x: 0, y: 0, width: 80, height: 20)
        return button
    }()
    
    
}
