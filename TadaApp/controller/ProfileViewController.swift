//
//  ProfileViewController.swift
//  TadaApp
//
//  Created by maedi laziman on 29/01/22.
//  Copyright © 2022 maedi laziman. All rights reserved.
//

import UIKit
import CoreData

class ProfileViewController: UIViewController {
    
    var scrollView: UIScrollView!
    
    var mainContentView = UIView()
    
    var parentView: UIView!
    
    var avatar: UIImageView!
    
    var userNameLabel: UILabel!
    
    var logoutBtn: UIButton!
    
    var autolayoutScrollView: ScrollViewAutolayoutCreator!
    
    let actLogout: (()->())
    
    var loginModel: LoginModel!
    
    init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?, loginModel: LoginModel, action: @escaping (()->())) {
        self.actLogout = action
        self.loginModel = loginModel
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
        
    required init?(coder aDecoder: NSCoder) {
        //super.init(coder: aDecoder)
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = false
        commonInit()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        userNameLabel.text = loginModel.fullName
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
}

extension ProfileViewController {
    
    private func commonInit(){
        parentView = UIView()
        parentView.setDefaultView();
        
        avatar = UIImageView()
        avatar.image = UIImage(systemName: "person.circle.fill")
        avatar.setDefaultImageView()
        avatar.contentMode = UIView.ContentMode.scaleAspectFill
        avatar.tintColor = .black
        
        userNameLabel = UILabel()
        userNameLabel.setDefaultLabel()
        userNameLabel.numberOfLines = 2
        userNameLabel.font = UIFont.boldSystemFont(ofSize: 20)
        userNameLabel.textAlignment = .left
        userNameLabel.text = "User Name"
        
        logoutBtn = UIButton()
        logoutBtn.setDefaultButton()
        logoutBtn.setTitle("LOGOUT", for: .normal)
        logoutBtn.titleLabel?.font = Helper.setNormalFont()
        logoutBtn.backgroundColor = UIColor.darkGray
        logoutBtn.contentEdgeInsets = UIEdgeInsets.init(top: 8, left: 10, bottom: 7, right: 10)
        logoutBtn.addTarget(self, action: #selector(didTapLogoutBtn(_:)), for: .touchUpInside)
        
        autolayoutScrollView = ScrollViewAutolayoutCreator(superView: self.view)
        scrollView = autolayoutScrollView.scrollView
        mainContentView = autolayoutScrollView.contentView
        mainContentView.setDefaultView()
        
        parentView.addSubview(avatar)
        parentView.addSubview(userNameLabel)
        parentView.addSubview(logoutBtn)
        mainContentView.addSubview(parentView)
        
        setConstraint()
        
        autolayoutScrollView.addVerticalConstraints(views: [parentView], verticalPadding: Constants.verticalPaddingContentView)
    }
    
    private func setConstraint() {
        parentView.translatesAutoresizingMaskIntoConstraints = false
        avatar.translatesAutoresizingMaskIntoConstraints = false
        userNameLabel.translatesAutoresizingMaskIntoConstraints = false
        logoutBtn.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            mainContentView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 0),
            mainContentView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 0),
            
            parentView.topAnchor.constraint(equalTo: mainContentView.topAnchor, constant: 0),
            parentView.leadingAnchor.constraint(equalTo: mainContentView.leadingAnchor, constant: Constants.marginFromSide),
            parentView.trailingAnchor.constraint(equalTo: mainContentView.trailingAnchor, constant: -Constants.marginFromSide),
            parentView.heightAnchor.constraint(greaterThanOrEqualTo: self.view.heightAnchor),
            parentView.centerYAnchor.constraint(equalTo: scrollView.centerYAnchor),
            
            avatar.topAnchor.constraint(equalTo: parentView.topAnchor, constant: 20),
            avatar.heightAnchor.constraint(equalToConstant: 150),
            avatar.widthAnchor.constraint(equalToConstant: 150),
            avatar.centerXAnchor.constraint(equalTo: parentView.centerXAnchor),
            
            userNameLabel.topAnchor.constraint(equalTo: avatar.bottomAnchor, constant: 40),
            userNameLabel.centerXAnchor.constraint(equalTo: parentView.centerXAnchor),
            
            logoutBtn.topAnchor.constraint(equalTo: userNameLabel.bottomAnchor, constant: 80),
            logoutBtn.centerXAnchor.constraint(equalTo: parentView.centerXAnchor),
            
        ])
    }
    
    func setFlagLogout(){
     
        //As we know that container is set up in the AppDelegates so we need to refer that container.
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
         
        let managedContext = appDelegate.persistentContainer.viewContext
         
        let fetchRequest:NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: "User")
        fetchRequest.predicate = NSPredicate(format: "username = %@", loginModel.userName)
        do
        {
            let test = try managedContext.fetch(fetchRequest)
            let objectUpdate = test[0] as! NSManagedObject
            objectUpdate.setValue(false, forKey: "login")
            do{
                try managedContext.save()
            }
            catch
            {
                print(error)
            }
        }
        catch
        {
            print(error)
        }
    
    }
    
    @objc func didTapLogoutBtn(_ sender: UIButton) {
        setFlagLogout()
        actLogout()
    }
}
