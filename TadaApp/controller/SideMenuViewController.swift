//
//  SideMenuViewController.swift
//  TadaApp
//
//  Created by maedi laziman on 29/01/22.
//  Copyright © 2022 maedi laziman. All rights reserved.
//

import UIKit

protocol SideMenuViewControllerDelegate {
    func selectedView(_ row: Int)
}

class SideMenuViewController: UIViewController {
    
    var delegate: SideMenuViewControllerDelegate?
    
    var scrollView: UIScrollView!
    
    var mainContentView = UIView()
    
    var parentView: UIView!
    
    var headerContainerView: UIView!
    
    var headerContainerSubMenuView: UIView!
    
    var avatar: UIImageView!
    
    var userNameLabel: UILabel!
    
    var iconMenu_Home: UIImageView!
    
    var titleMenu_Home: UILabel!
    
    var stackViewMenuHome: UIStackView!
    
    var iconMenu_Profile: UIImageView!
    
    var titleMenu_Profile: UILabel!
    
    var stackViewMenuProfile: UIStackView!
    
    var autolayoutScrollView: ScrollViewAutolayoutCreator!
    
    var loginModel: LoginModel!
    
    init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?, loginModel: LoginModel) {
        self.loginModel = loginModel
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
        
    required init?(coder aDecoder: NSCoder) {
        //super.init(coder: aDecoder)
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        commonInit()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        userNameLabel.text = "Welcome, \(loginModel.fullName!)"
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
}

extension SideMenuViewController {
    
    private func commonInit(){
        
        self.view.frame = CGRect(x: 0, y: 0, width: self.view.frame.width/2, height: self.view.frame.height)
        
        parentView = UIView()
        parentView.setDefaultView();
        
        headerContainerView = UIView()
        headerContainerView.setDefaultView();
        headerContainerView.borders(for: [.bottom], width: 1, color: .gray, alphaColor: 1.0)
        
        headerContainerSubMenuView = UIView()
        headerContainerSubMenuView.setDefaultView();
        
        avatar = UIImageView()
        avatar.image = UIImage(systemName: "photo.fill")
        avatar.setDefaultImageView()
        avatar.contentMode = UIView.ContentMode.scaleAspectFill
        avatar.layer.cornerRadius = 2
        avatar.tintColor = .black
        
        userNameLabel = UILabel()
        userNameLabel.setDefaultLabel()
        userNameLabel.numberOfLines = 2
        userNameLabel.font = UIFont.boldSystemFont(ofSize: 14)
        userNameLabel.textAlignment = .left
        userNameLabel.text = "Welcome"
        
        iconMenu_Home = UIImageView()
        iconMenu_Home.image = UIImage(systemName: "house.fill")
        iconMenu_Home.setDefaultImageView()
        iconMenu_Home.contentMode = UIView.ContentMode.scaleAspectFill
        iconMenu_Home.tintColor = .black
        
        titleMenu_Home = UILabel()
        titleMenu_Home.setDefaultLabel()
        titleMenu_Home.font = UIFont.boldSystemFont(ofSize: 14)
        titleMenu_Home.textAlignment = .left
        titleMenu_Home.text = "Home"
        
        stackViewMenuHome = UIStackView()
        stackViewMenuHome.setDefaultStackView(axis: .horizontal)
        stackViewMenuHome.distribution = .fillProportionally
        stackViewMenuHome.alignment = .leading
        stackViewMenuHome.spacing = 16
        stackViewMenuHome.addArrangedSubview(iconMenu_Home)
        stackViewMenuHome.addArrangedSubview(titleMenu_Home)
        stackViewMenuHome.isUserInteractionEnabled = true
        stackViewMenuHome.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapHome)))
        
        iconMenu_Profile = UIImageView()
        iconMenu_Profile.image = UIImage(systemName: "person.fill")
        iconMenu_Profile.setDefaultImageView()
        iconMenu_Profile.contentMode = UIView.ContentMode.scaleAspectFill
        iconMenu_Profile.tintColor = .black
        
        titleMenu_Profile = UILabel()
        titleMenu_Profile.setDefaultLabel()
        titleMenu_Profile.font = UIFont.boldSystemFont(ofSize: 14)
        titleMenu_Profile.textAlignment = .left
        titleMenu_Profile.text = "Profile"
        
        stackViewMenuProfile = UIStackView()
        stackViewMenuProfile.setDefaultStackView(axis: .horizontal)
        stackViewMenuProfile.distribution = .fillProportionally
        stackViewMenuProfile.alignment = .leading
        stackViewMenuProfile.spacing = 16
        stackViewMenuProfile.addArrangedSubview(iconMenu_Profile)
        stackViewMenuProfile.addArrangedSubview(titleMenu_Profile)
        stackViewMenuProfile.isUserInteractionEnabled = true
        stackViewMenuProfile.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapProfile)))
        
        autolayoutScrollView = ScrollViewAutolayoutCreator(superView: self.view)
        scrollView = autolayoutScrollView.scrollView
        mainContentView = autolayoutScrollView.contentView
        mainContentView.setDefaultView()
        
        headerContainerSubMenuView.addSubview(avatar)
        headerContainerSubMenuView.addSubview(userNameLabel)
        headerContainerView.addSubview(headerContainerSubMenuView)
        parentView.addSubview(headerContainerView)
        parentView.addSubview(stackViewMenuHome)
        parentView.addSubview(stackViewMenuProfile)
        mainContentView.addSubview(parentView)
        
        setConstraint()
        
        autolayoutScrollView.addVerticalConstraints(views: [parentView], verticalPadding: Constants.verticalPaddingContentView)
        
    }
    
    private func setConstraint() {
        parentView.translatesAutoresizingMaskIntoConstraints = false
        headerContainerView.translatesAutoresizingMaskIntoConstraints = false
        headerContainerSubMenuView.translatesAutoresizingMaskIntoConstraints = false
        avatar.translatesAutoresizingMaskIntoConstraints = false
        userNameLabel.translatesAutoresizingMaskIntoConstraints = false
        stackViewMenuHome.translatesAutoresizingMaskIntoConstraints = false
        stackViewMenuProfile.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            mainContentView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 0),
            mainContentView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 0),
            
            parentView.topAnchor.constraint(equalTo: mainContentView.topAnchor, constant: 0),
            parentView.leadingAnchor.constraint(equalTo: mainContentView.leadingAnchor, constant: 0),
            parentView.trailingAnchor.constraint(equalTo: mainContentView.trailingAnchor, constant: 0),
            parentView.heightAnchor.constraint(greaterThanOrEqualTo: self.view.heightAnchor),
            parentView.centerYAnchor.constraint(equalTo: scrollView.centerYAnchor),
            
            headerContainerView.topAnchor.constraint(equalTo: parentView.topAnchor, constant: 0),
            headerContainerView.leadingAnchor.constraint(equalTo: parentView.leadingAnchor, constant: 0),
            headerContainerView.trailingAnchor.constraint(equalTo: parentView.trailingAnchor, constant: 0),
            headerContainerView.heightAnchor.constraint(equalToConstant: 70),
            
            headerContainerSubMenuView.topAnchor.constraint(equalTo: headerContainerView.topAnchor, constant: 0),
            headerContainerSubMenuView.leadingAnchor.constraint(equalTo: headerContainerView.leadingAnchor, constant: 12),
            headerContainerSubMenuView.trailingAnchor.constraint(equalTo: headerContainerView.trailingAnchor, constant: -12),
            headerContainerSubMenuView.bottomAnchor.constraint(equalTo: headerContainerView.bottomAnchor, constant: 0),
            
            avatar.topAnchor.constraint(equalTo: headerContainerSubMenuView.topAnchor, constant: 10),
            avatar.leadingAnchor.constraint(equalTo: headerContainerSubMenuView.leadingAnchor, constant: 0),
            avatar.heightAnchor.constraint(equalToConstant: 50),
            avatar.widthAnchor.constraint(equalToConstant: 50),
            
            userNameLabel.leadingAnchor.constraint(equalTo: avatar.trailingAnchor, constant: 10),
            userNameLabel.trailingAnchor.constraint(equalTo: headerContainerView.trailingAnchor, constant: 0),
            userNameLabel.centerYAnchor.constraint(equalTo: avatar.centerYAnchor),
            
            iconMenu_Home.heightAnchor.constraint(equalToConstant: 30),
            iconMenu_Home.widthAnchor.constraint(equalToConstant: 30),
            
            titleMenu_Home.centerYAnchor.constraint(equalTo: iconMenu_Home.centerYAnchor),
            
            stackViewMenuHome.topAnchor.constraint(equalTo: headerContainerView.bottomAnchor, constant: 20),
            stackViewMenuHome.leadingAnchor.constraint(equalTo: headerContainerSubMenuView.leadingAnchor, constant: 0),
            
            iconMenu_Profile.heightAnchor.constraint(equalToConstant: 30),
            iconMenu_Profile.widthAnchor.constraint(equalToConstant: 30),
            
            titleMenu_Profile.centerYAnchor.constraint(equalTo: iconMenu_Profile.centerYAnchor),
            
            stackViewMenuProfile.topAnchor.constraint(equalTo: stackViewMenuHome.bottomAnchor, constant: 20),
            stackViewMenuProfile.leadingAnchor.constraint(equalTo: headerContainerSubMenuView.leadingAnchor, constant: 0),
            
        ])
    }
    
    @objc func didTapHome(_ sender: UITapGestureRecognizer) {
        delegate?.selectedView(0)
    }
    
    @objc func didTapProfile(_ sender: UITapGestureRecognizer) {
        delegate?.selectedView(1)
    }
}
