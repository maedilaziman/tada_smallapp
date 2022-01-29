//
//  Helper.swift
//  TadaApp
//
//  Created by maedi laziman on 29/01/22.
//  Copyright © 2022 maedi laziman. All rights reserved.
//

import UIKit

struct Helper {
    
    static func hexStringToUIColor (hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        if ((cString.count) != 6) {
            return UIColor.gray
        }
        var rgbValue:UInt64 = 0
        Scanner(string: cString).scanHexInt64(&rgbValue)

        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
    static func barFontColor() -> UIColor {
        //return UIColor.white.withAlphaComponent(0.7)
        return UIColor.darkGray
    }
    
    static func barBackgroundColor() -> UIColor {
        //return UIColor.white.withAlphaComponent(0.0)
        return UIColor.white
    }
    
    static func showToast(view : UIView, message : String) {
        let toastLabel = UITextView()
        toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        toastLabel.textColor = UIColor.white
        toastLabel.font = .systemFont(ofSize: 13.0)
        toastLabel.textAlignment = .center;
        toastLabel.text = message
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 10
        toastLabel.clipsToBounds  =  true
        view.addSubview(toastLabel)
        toastLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            toastLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            toastLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            toastLabel.widthAnchor.constraint(equalToConstant: 150),
            toastLabel.heightAnchor.constraint(equalToConstant: 50),
        ])
        UIView.animate(withDuration: 0.8, delay: 1.5, options: .curveEaseOut, animations: {
             toastLabel.alpha = 0.0
        }, completion: {(isCompleted) in
            toastLabel.removeFromSuperview()
        })
    }
    
    static func showInfoWhileLoadObject(view : UIView, isContentMainView: Bool = false, message : String) -> UIView {
        let parentView = UIView()
        let contentObjectView = UIView()
        contentObjectView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        contentObjectView.alpha = 1.0
        contentObjectView.layer.cornerRadius = 10
        contentObjectView.clipsToBounds  =  true
        
        let title = UILabel()
        title.setDefaultLabel()
        title.textColor = UIColor.white
        title.font = .systemFont(ofSize: 13.0)
        title.textAlignment = .center;
        title.text = message
        
        let indicateView: UIActivityIndicatorView!
        indicateView = UIActivityIndicatorView()
        indicateView.setDefaultIndicatorView()
        indicateView.startAnimating()
        
        if isContentMainView {
            parentView.setDefaultView();
            parentView.backgroundColor = UIColor.white.withAlphaComponent(0.7)
            
            contentObjectView.addSubview(indicateView)
            contentObjectView.addSubview(title)
            parentView.addSubview(contentObjectView)
            view.addSubview(parentView)
            
            parentView.translatesAutoresizingMaskIntoConstraints = false
            contentObjectView.translatesAutoresizingMaskIntoConstraints = false
            indicateView.translatesAutoresizingMaskIntoConstraints = false
            title.translatesAutoresizingMaskIntoConstraints = false
            
            NSLayoutConstraint.activate([
                parentView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
                parentView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
                parentView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
                parentView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0),
                
                contentObjectView.centerXAnchor.constraint(equalTo: parentView.centerXAnchor),
                contentObjectView.centerYAnchor.constraint(equalTo: parentView.centerYAnchor),
                //contentObjectView.leadingAnchor.constraint(equalTo: parentView.leadingAnchor, constant: 30),
                //contentObjectView.trailingAnchor.constraint(equalTo: parentView.trailingAnchor, constant: -30),
                contentObjectView.widthAnchor.constraint(equalToConstant: 120),
                contentObjectView.heightAnchor.constraint(equalToConstant: 60),
                
                indicateView.widthAnchor.constraint(equalToConstant: 25),
                indicateView.heightAnchor.constraint(equalToConstant: 25),
                indicateView.topAnchor.constraint(equalTo: contentObjectView.topAnchor, constant: 8),
                indicateView.centerXAnchor.constraint(equalTo: contentObjectView.centerXAnchor),
                
                title.topAnchor.constraint(equalTo: indicateView.bottomAnchor, constant: 3),
                title.centerXAnchor.constraint(equalTo: contentObjectView.centerXAnchor),
            ])
            
            return parentView
        }
        else {
            contentObjectView.addSubview(indicateView)
            contentObjectView.addSubview(title)
            view.addSubview(contentObjectView)
            
            contentObjectView.translatesAutoresizingMaskIntoConstraints = false
            indicateView.translatesAutoresizingMaskIntoConstraints = false
            title.translatesAutoresizingMaskIntoConstraints = false
            
            NSLayoutConstraint.activate([
                contentObjectView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                contentObjectView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
                contentObjectView.widthAnchor.constraint(equalToConstant: 120),
                contentObjectView.heightAnchor.constraint(equalToConstant: 60),
                
                indicateView.widthAnchor.constraint(equalToConstant: 25),
                indicateView.heightAnchor.constraint(equalToConstant: 25),
                indicateView.topAnchor.constraint(equalTo: contentObjectView.topAnchor, constant: 8),
                indicateView.centerXAnchor.constraint(equalTo: contentObjectView.centerXAnchor),
                
                title.topAnchor.constraint(equalTo: indicateView.bottomAnchor, constant: 3),
                title.centerXAnchor.constraint(equalTo: contentObjectView.centerXAnchor),
            ])
            
            return contentObjectView
        }
        
    }
    
    static func hideInfoWhileLoadObject(view : UIView) {
        view.alpha = 0.0
        view.removeFromSuperview()
    }
    
    static func setBoldFont() -> UIFont {
        return UIFont.boldSystemFont(ofSize: 16)
    }
    
    static func setNormalFont() -> UIFont {
        return UIFont.systemFont(ofSize: 16)
    }
    
    static func setItalicFont() -> UIFont {
        return UIFont.italicSystemFont(ofSize: 16)
    }
}
