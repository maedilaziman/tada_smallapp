//
//  RegisterViewController.swift
//  TadaApp
//
//  Created by maedi laziman on 29/01/22.
//  Copyright © 2022 maedi laziman. All rights reserved.
//

import UIKit
import CoreData

class RegisterViewController: UIViewController {
    
    var scrollView: UIScrollView!
    
    var mainContentView = UIView()
    
    var parentView: UIView!
    
    var titlePageLabel: UILabel!
    
    var userName: UITextField!
    
    var password: UITextField!
    
    var btnRegister: UIButton!
    
    var cbTermConditions: CheckBox!
    
    var titleTermConditionsLabel: UILabel!
    
    var stcViewTermConditions: UIStackView!
    
    var stackViewRegisterField: UIStackView!
    
    var autolayoutScrollView: ScrollViewAutolayoutCreator!
    
    let actMoveToLogin: (()->())
    
    init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?, action: @escaping (()->())) {
        self.actMoveToLogin = action
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
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
}

extension RegisterViewController {

    private func commonInit(){
        let leftCustomViewButton = UIButton(type: .system)
        var img = UIImage(systemName: "chevron.left")
        img = img?.imageWith(newSize: CGSize(width: 14, height: 18))
        leftCustomViewButton.setImage(img!.maskWithColor(color: .black), for: .normal)
        leftCustomViewButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        leftCustomViewButton.setTitle("\t" + Constants.appTitle, for: .normal)
        leftCustomViewButton.setTitleColor(.black, for: .normal)
        leftCustomViewButton.tintColor = .black
        leftCustomViewButton.addTarget(self, action: #selector(didTapLeftBarButton(_ :)), for: .touchUpInside)
        let leftBarButtonItem = UIBarButtonItem(customView: leftCustomViewButton)
        
        self.navigationItem.setTitle(
            title: "" ,
            underline: true,
            hideBackBtn: false,
            ctr: self,
            fontColor: UIColor.black,
            bcgColor: UIColor.white,
            leftBarButton: leftBarButtonItem,
            rightBarIcon: UIImage(),
            rightBarButton: nil,
            customView: nil,
            isLeftCustomViewPosition: false)
        
        parentView = UIView()
        parentView.setDefaultView();
        
        titlePageLabel = UILabel()
        titlePageLabel.setDefaultLabel()
        titlePageLabel.setTitlePageFont()
        titlePageLabel.textAlignment = .center
        titlePageLabel.text = "REGISTER"
        
        userName = UITextField()
        userName.setDefaultTextField(strPlaceHolder: "Username")
        
        password = UITextField()
        password.setDefaultTextField(strPlaceHolder: "Password")
        password.isSecureTextEntry = true
        
        stackViewRegisterField = UIStackView()
        stackViewRegisterField.setDefaultStackView(axis: .vertical)
        stackViewRegisterField.alignment = .leading
        stackViewRegisterField.spacing = 16
        stackViewRegisterField.addArrangedSubview(userName)
        stackViewRegisterField.addArrangedSubview(password)
        
        cbTermConditions = CheckBox.init()
        cbTermConditions.style = .tick
        cbTermConditions.borderStyle = .roundedSquare(radius: 2)
        cbTermConditions.tintColor = UIColor.lightGray
        
        titleTermConditionsLabel = UILabel()
        titleTermConditionsLabel.setDefaultLabel()
        titleTermConditionsLabel.font = UIFont.systemFont(ofSize: 14)
        titleTermConditionsLabel.text = "I Agree with Terms and Condition"
        
        stcViewTermConditions = UIStackView()
        stcViewTermConditions.setDefaultStackView(axis: .horizontal)
        stcViewTermConditions.distribution  = .fillProportionally
        stcViewTermConditions.addArrangedSubview(cbTermConditions)
        stcViewTermConditions.addArrangedSubview(titleTermConditionsLabel)
        stcViewTermConditions.spacing = 8
        
        btnRegister = UIButton()
        btnRegister.setDefaultButton()
        btnRegister.setTitle("REGISTER", for: .normal)
        btnRegister.titleLabel?.font = Helper.setNormalFont()
        btnRegister.backgroundColor = UIColor.darkGray
        btnRegister.contentEdgeInsets = UIEdgeInsets.init(top: 8, left: 10, bottom: 7, right: 10)
        btnRegister.addTarget(self, action: #selector(didTapRegisterBtn(_:)), for: .touchUpInside)
        
        autolayoutScrollView = ScrollViewAutolayoutCreator(superView: self.view)
        scrollView = autolayoutScrollView.scrollView
        mainContentView = autolayoutScrollView.contentView
        mainContentView.setDefaultView()
        
        parentView.addSubview(titlePageLabel)
        parentView.addSubview(stackViewRegisterField)
        parentView.addSubview(stcViewTermConditions)
        parentView.addSubview(btnRegister)
        mainContentView.addSubview(parentView)
        
        setConstraint()
        
        autolayoutScrollView.addVerticalConstraints(views: [parentView], verticalPadding: Constants.verticalPaddingContentView)
    }
    
    private func setConstraint() {
        parentView.translatesAutoresizingMaskIntoConstraints = false
        titlePageLabel.translatesAutoresizingMaskIntoConstraints = false
        stackViewRegisterField.translatesAutoresizingMaskIntoConstraints = false
        stcViewTermConditions.translatesAutoresizingMaskIntoConstraints = false
        btnRegister.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            mainContentView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 0),
            mainContentView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 0),
            
            parentView.topAnchor.constraint(equalTo: mainContentView.topAnchor, constant: 0),
            parentView.leadingAnchor.constraint(equalTo: mainContentView.leadingAnchor, constant: Constants.marginFromSide),
            parentView.trailingAnchor.constraint(equalTo: mainContentView.trailingAnchor, constant: -Constants.marginFromSide),
            parentView.heightAnchor.constraint(greaterThanOrEqualTo: self.view.heightAnchor),
            parentView.centerYAnchor.constraint(equalTo: scrollView.centerYAnchor),
            
            titlePageLabel.topAnchor.constraint(equalTo: parentView.topAnchor, constant: 40),
            titlePageLabel.leadingAnchor.constraint(equalTo: parentView.leadingAnchor, constant: 0),
            titlePageLabel.trailingAnchor.constraint(equalTo: parentView.trailingAnchor, constant: 0),
            titlePageLabel.centerXAnchor.constraint(equalTo: parentView.centerXAnchor),
            
            stackViewRegisterField.topAnchor.constraint(equalTo: titlePageLabel.bottomAnchor, constant: 50),
            stackViewRegisterField.leadingAnchor.constraint(equalTo: parentView.leadingAnchor, constant: 0),
            stackViewRegisterField.trailingAnchor.constraint(equalTo: parentView.trailingAnchor, constant: 0),
            
            userName.leadingAnchor.constraint(equalTo: stackViewRegisterField.leadingAnchor, constant: 0),
            userName.trailingAnchor.constraint(equalTo: stackViewRegisterField.trailingAnchor, constant: 0),
            
            password.leadingAnchor.constraint(equalTo: stackViewRegisterField.leadingAnchor, constant: 0),
            password.trailingAnchor.constraint(equalTo: stackViewRegisterField.trailingAnchor, constant: 0),
            
            stcViewTermConditions.topAnchor.constraint(equalTo: stackViewRegisterField.bottomAnchor, constant: 12),
            stcViewTermConditions.leadingAnchor.constraint(equalTo: parentView.leadingAnchor, constant: 0),
            stcViewTermConditions.trailingAnchor.constraint(equalTo: parentView.trailingAnchor, constant: 0),
            
            cbTermConditions.heightAnchor.constraint(equalToConstant: 17),
            cbTermConditions.widthAnchor.constraint(equalToConstant: 17),
            
            btnRegister.topAnchor.constraint(equalTo: stcViewTermConditions.bottomAnchor, constant: 20),
            btnRegister.leadingAnchor.constraint(equalTo: parentView.leadingAnchor, constant: 0),
            btnRegister.heightAnchor.constraint(equalToConstant: 30),
            btnRegister.widthAnchor.constraint(equalToConstant: 100),
        ])
    }
    
    func createUserTable(registerModel: RegisterModel) -> Bool{
        
        //As we know that container is set up in the AppDelegates so we need to refer that container.
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return false }
        
        var success = true
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let userEntity = NSEntityDescription.entity(forEntityName: "User", in: managedContext)!
        
        let user = NSManagedObject(entity: userEntity, insertInto: managedContext)
        user.setValue(registerModel.fullName, forKeyPath: "username")
        user.setValue(registerModel.password, forKey: "password")
        user.setValue(false, forKey: "login")
        
        do {
            try managedContext.save()
           
        } catch let error as NSError {
            success = false
            print("Could not save. \(error), \(error.userInfo)")
        }
        
        return success
    }
    
    @objc func didTapRegisterBtn(_ sender: UIButton) {
        let usrName = userName.text
        let pass = password.text
        let registerModel = RegisterModel(userName: usrName!, password: pass!, checkTermCondition: cbTermConditions.isChecked)
        let validationField = ValidationField(registerModel: registerModel)
        if validationField.validationAllRegisterField(ctr: self) {
            if createUserTable(registerModel: registerModel) {
                actMoveToLogin()
            }
        }
    }
    
    @objc func didTapLeftBarButton(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
}
