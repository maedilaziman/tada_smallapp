//
//  RootViewController.swift
//  TadaApp
//
//  Created by maedi laziman on 29/01/22.
//  Copyright © 2022 maedi laziman. All rights reserved.
//

import UIKit
import SnapKit

class RootViewController: UIViewController {

    var labelWelcome: UILabel!
    
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
        self.navigationController?.isNavigationBarHidden = true
        labelWelcome = UILabel()
        //labelWelcome.setDefaultLabel()
        labelWelcome.textColor = .black
        labelWelcome.text = "Welcome TADA.."
        labelWelcome.font = UIFont.systemFont(ofSize: 30)
        
        self.view.addSubview(labelWelcome)
        
        labelWelcome.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.actMoveToLogin()
        }
    }
    
}
