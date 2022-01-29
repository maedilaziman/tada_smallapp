//
//  LoginViewController.swift
//  TadaApp
//
//  Created by maedi laziman on 29/01/22.
//  Copyright © 2022 maedi laziman. All rights reserved.
//

import UIKit
import CoreData

class LoginViewController: UIViewController {
    
    var scrollView: UIScrollView!
    
    var mainContentView = UIView()
    
    var parentView: UIView!
    
    var titlePageLabel: UILabel!
    
    var userName: UITextField!
    
    var password: UITextField!
    
    var btnLogin: UIButton!
    
    var registerLabel: UILabel!
    
    var stackViewLoginField: UIStackView!
    
    var autolayoutScrollView: ScrollViewAutolayoutCreator!
    
    let actMoveToHome: ((LoginModel)->())
    
    let actMoveToRegister: (()->())
    
    init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?, actionHome: @escaping ((LoginModel)->()), actionRegister: @escaping (()->())) {
        self.actMoveToHome = actionHome
        self.actMoveToRegister = actionRegister
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

extension LoginViewController {

    private func commonInit(){
        self.navigationItem.setTitle(
            title: Constants.appTitle ,
            underline: true,
            hideBackBtn: true,
            ctr: self,
            fontColor: UIColor.black,
            bcgColor: UIColor.white,
            leftBarButton: nil,
            rightBarIcon: UIImage(),
            rightBarButton: nil,
            customView: nil,
            isLeftCustomViewPosition: true)
        
        parentView = UIView()
        parentView.setDefaultView();
        
        titlePageLabel = UILabel()
        titlePageLabel.setDefaultLabel()
        titlePageLabel.setTitlePageFont()
        titlePageLabel.textAlignment = .center
        titlePageLabel.text = "LOGIN"
        
        userName = UITextField()
        userName.setDefaultTextField(strPlaceHolder: "Username")
        
        password = UITextField()
        password.setDefaultTextField(strPlaceHolder: "Password")
        password.isSecureTextEntry = true
        
        stackViewLoginField = UIStackView()
        stackViewLoginField.setDefaultStackView(axis: .vertical)
        stackViewLoginField.alignment = .leading
        stackViewLoginField.spacing = 16
        stackViewLoginField.addArrangedSubview(userName)
        stackViewLoginField.addArrangedSubview(password)
        
        btnLogin = UIButton()
        btnLogin.setDefaultButton()
        btnLogin.setTitle("LOGIN", for: .normal)
        btnLogin.titleLabel?.font = Helper.setNormalFont()
        btnLogin.backgroundColor = UIColor.darkGray
        btnLogin.contentEdgeInsets = UIEdgeInsets.init(top: 8, left: 10, bottom: 7, right: 10)
        btnLogin.addTarget(self, action: #selector(didTapLoginBtn(_:)), for: .touchUpInside)
        
        registerLabel = UILabel()
        registerLabel.setDefaultLabel()
        registerLabel.attributedText = setTextAttribute(firstText: "Don’t have account ?", secondText: " Register")
        registerLabel.isUserInteractionEnabled = true
        registerLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapRegister)))
        
        autolayoutScrollView = ScrollViewAutolayoutCreator(superView: self.view)
        scrollView = autolayoutScrollView.scrollView
        mainContentView = autolayoutScrollView.contentView
        mainContentView.setDefaultView()
        
        parentView.addSubview(titlePageLabel)
        parentView.addSubview(stackViewLoginField)
        parentView.addSubview(btnLogin)
        parentView.addSubview(registerLabel)
        mainContentView.addSubview(parentView)
        
        setConstraint()
        
        autolayoutScrollView.addVerticalConstraints(views: [parentView], verticalPadding: Constants.verticalPaddingContentView)
    }
    
    private func setConstraint() {
        parentView.translatesAutoresizingMaskIntoConstraints = false
        titlePageLabel.translatesAutoresizingMaskIntoConstraints = false
        stackViewLoginField.translatesAutoresizingMaskIntoConstraints = false
        btnLogin.translatesAutoresizingMaskIntoConstraints = false
        registerLabel.translatesAutoresizingMaskIntoConstraints = false
        
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
            
            stackViewLoginField.topAnchor.constraint(equalTo: titlePageLabel.bottomAnchor, constant: 50),
            stackViewLoginField.leadingAnchor.constraint(equalTo: parentView.leadingAnchor, constant: 0),
            stackViewLoginField.trailingAnchor.constraint(equalTo: parentView.trailingAnchor, constant: 0),
            
            userName.leadingAnchor.constraint(equalTo: stackViewLoginField.leadingAnchor, constant: 0),
            userName.trailingAnchor.constraint(equalTo: stackViewLoginField.trailingAnchor, constant: 0),
            
            password.leadingAnchor.constraint(equalTo: stackViewLoginField.leadingAnchor, constant: 0),
            password.trailingAnchor.constraint(equalTo: stackViewLoginField.trailingAnchor, constant: 0),
            
            btnLogin.topAnchor.constraint(equalTo: stackViewLoginField.bottomAnchor, constant: 20),
            btnLogin.trailingAnchor.constraint(equalTo: parentView.trailingAnchor, constant: 0),
            btnLogin.heightAnchor.constraint(equalToConstant: 30),
            btnLogin.widthAnchor.constraint(equalToConstant: 100),
            
            registerLabel.topAnchor.constraint(equalTo: btnLogin.bottomAnchor, constant: 5),
            registerLabel.trailingAnchor.constraint(equalTo: parentView.trailingAnchor, constant: 0),
        ])
    }
    
    private func setTextAttribute(firstText: String, secondText: String) -> NSAttributedString {
        let font = UIFont.systemFont(ofSize: 14)
        let attrs = [NSAttributedString.Key.font : font]
        let attributedString = NSMutableAttributedString(string:firstText, attributes:attrs as [NSAttributedString.Key : Any])

        let colorTextAttribute: [NSAttributedString.Key: Any] = [.font: font,.foregroundColor: Helper.hexStringToUIColor(hex: "#d84372")]
        let colorString = NSMutableAttributedString(string:secondText, attributes:colorTextAttribute)
        attributedString.append(colorString)
        return attributedString
    }
    
    func checkUserIsExistInDB(loginModel: LoginModel) -> Bool{
        //As we know that container is set up in the AppDelegates so we need to refer that container.
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return false}
        var exist = false
        let managedContext = appDelegate.persistentContainer.viewContext
                    
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
        do {
            let result = try managedContext.fetch(fetchRequest)
            for data in result as! [NSManagedObject] {
                print(data.value(forKey: "username") as! String)
                if loginModel.userName == data.value(forKey: "username") as! String {
                    exist = true
                    break
                }
            }
                        
        } catch {
            print("Failed")
        }
        return exist
    }
    
    func setFlagLogin(){
     
        //As we know that container is set up in the AppDelegates so we need to refer that container.
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
         
        let managedContext = appDelegate.persistentContainer.viewContext
         
        let fetchRequest:NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: "User")
        fetchRequest.predicate = NSPredicate(format: "username = %@", userName.text!)
        do
        {
            let test = try managedContext.fetch(fetchRequest)
            let objectUpdate = test[0] as! NSManagedObject
            objectUpdate.setValue(true, forKey: "login")
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
    
    @objc func didTapLoginBtn(_ sender: UIButton) {
        let usrName = userName.text
        let pass = password.text
        let loginModel = LoginModel(userName: usrName!, password: pass!)
        let validationField = ValidationField(loginModel: loginModel)
        if validationField.validationAllLoginField(ctr: self) {
            if checkUserIsExistInDB(loginModel: loginModel) {
                setFlagLogin()
                actMoveToHome(loginModel)
            }
            else {
                let alert = UIAlertController(title: "Error", message: "Username does not exist!, please Register first", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
    
    @objc func didTapRegister(_ sender: UITapGestureRecognizer) {
        self.actMoveToRegister()
    }
}
