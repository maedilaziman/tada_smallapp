//
//  SetUpExtension.swift
//  TadaApp
//
//  Created by maedi laziman on 29/01/22.
//  Copyright © 2022 maedi laziman. All rights reserved.
//

import UIKit
import SnapKit

extension UINavigationItem {
    
    func setTitle(title:String, underline: Bool, hideBackBtn: Bool, ctr: UIViewController, fontColor: UIColor, bcgColor: UIColor,  leftBarButton: UIBarButtonItem?, rightBarIcon: UIImage?,  rightBarButton: UIBarButtonItem?, customView: UIView?, isLeftCustomViewPosition: Bool) {
        var _itemView: UIView?
        if nil != customView {
            _itemView = customView
        }
        else {
            _itemView = setTitleLabel(title: title, ctr: ctr, fontColor: fontColor)
        }
        ctr.navigationController?.navigationBar.addSubview(_itemView!)
        _itemView!.translatesAutoresizingMaskIntoConstraints = false
        //if let navigationBar = ctr.navigationController?.navigationBar {
        //    _itemView!.widthAnchor.constraint(equalTo: navigationBar.widthAnchor, constant: -80).isActive = true
        //}
        if hideBackBtn {
            self.hidesBackButton = true
        }
        if nil != leftBarButton {
            self.leftBarButtonItem = leftBarButton
        }
        if isLeftCustomViewPosition {
            self.leftBarButtonItem = UIBarButtonItem.init(customView: _itemView!)
        }
        else {
            //center customView position
            self.titleView = _itemView
        }
        
        if nil == rightBarButton {
            self.rightBarButtonItem = UIBarButtonItem(image: rightBarIcon, style: .plain, target: self, action: nil)
        }
        else {
            self.rightBarButtonItem = rightBarButton
        }
        
        ctr.navigationController?.navigationBar.setNavBar(uicontroll: ctr, under_line: underline, fontColor: fontColor, bcgColor: bcgColor)
    }
    
    func setTitleLabel(title:String, ctr: UIViewController, fontColor: UIColor) -> UILabel{
        let lblTitle = UILabel()
        let titleAttribute: [NSAttributedString.Key: Any] = [.font: UIFont.boldSystemFont(ofSize: 20),.foregroundColor: fontColor]
        let attributeString = NSMutableAttributedString(string: title, attributes: titleAttribute)
        lblTitle.attributedText = attributeString
        lblTitle.sizeToFit()
        lblTitle.textAlignment = .center
        return lblTitle
    }
}

extension UINavigationBar {

    func setNavBar(uicontroll: UIViewController, under_line: Bool, fontColor: UIColor, bcgColor: UIColor) {
        uicontroll.navigationController?.navigationBar.barTintColor = bcgColor
        uicontroll.navigationController?.navigationBar.tintColor = fontColor
        //this if we want to transparent bar
        //uicontroll.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        //this for remove default bottom border
        uicontroll.navigationController?.navigationBar.shadowImage = UIImage()
        if let navigationController = uicontroll.navigationController {
            if under_line {
                let navigationBar = navigationController.navigationBar
                let navigationSeparator = UIView()
                navigationSeparator.backgroundColor = UIColor.lightGray
                //navigationSeparator.isOpaque = true
                uicontroll.navigationController?.navigationBar.addSubview(navigationSeparator)
                navigationSeparator.snp.makeConstraints { make in
                    make.leading.trailing.equalToSuperview().offset(0)
                    make.top.equalTo(navigationBar.snp.bottom).offset(0)
                    make.height.equalTo(0.5)
                }
            }
        }
        
    }
    
    func getHeightBarProposional(uicontroll: UIViewController) -> CGFloat{
        return ((uicontroll.navigationController?.navigationBar.frame.size.height)! * 2)+5
    }
}

extension UIButton {
    
    func setDefaultButton() {
        self.backgroundColor = .clear
        self.layer.cornerRadius = 4
        self.layer.borderWidth = 0
        self.contentEdgeInsets = UIEdgeInsets.init(top: 0,left: 10,bottom: 0,right: 10)
    }
}

extension UITextField {
    
    func setDefaultTextField(strPlaceHolder: String) {
        self.attributedPlaceholder = NSAttributedString(string: strPlaceHolder, attributes: [NSAttributedString.Key.foregroundColor : UIColor.gray])
        self.font = UIFont.systemFont(ofSize: 17)
        self.borderStyle = UITextField.BorderStyle.roundedRect
        self.layer.borderWidth = 0.4
        self.layer.masksToBounds = true
        self.layer.borderColor = UIColor.lightGray.cgColor
        self.autocorrectionType = .no
        self.keyboardType = .default
        self.returnKeyType = .default
        self.clearButtonMode = .whileEditing;
        self.contentVerticalAlignment = .center
    }
}

extension UITextView {
    
    func addDoneButton(title: String, target: Any, selector: Selector) {
        
        let toolBar = UIToolbar(frame: CGRect(x: 0.0,
                                              y: 0.0,
                                              width: UIScreen.main.bounds.size.width,
                                              height: 44.0))//1
        let flexible = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)//2
        let barButton = UIBarButtonItem(title: title, style: .plain, target: target, action: selector)//3
        toolBar.setItems([flexible, barButton], animated: false)//4
        self.inputAccessoryView = toolBar//5
    }
}

extension UIImageView {
    
    func setDefaultImageView() {
        //self.layer.cornerRadius = 3
        self.clipsToBounds = true
        self.layer.borderWidth = 0.0
        //self.layer.borderColor = UIColor.lightGray.cgColor
        self.contentMode = .scaleAspectFit
        self.tintColor = UIColor.systemBlue
    }
}

extension UIImage {
    
    func imageWith(newSize: CGSize) -> UIImage {
        let image = UIGraphicsImageRenderer(size: newSize).image { _ in
            draw(in: CGRect(origin: .zero, size: newSize))
        }
        return image.withRenderingMode(renderingMode)
        
        /*
        //with keeping aspect ratio
        var scaledImageRect = CGRect.zero
        let aspectWidth:CGFloat = size.width / self.size.width;
        let aspectHeight:CGFloat = size.height / self.size.height
        let aspectRatio:CGFloat = min(aspectWidth, aspectHeight)
        scaledImageRect.size.width = self.size.width * aspectRatio
        scaledImageRect.size.height = self.size.height * aspectRatio
        scaledImageRect.origin.x = (size.width - scaledImageRect.size.width) / 2.0
        scaledImageRect.origin.y = (size.height - scaledImageRect.size.height) / 2.0
        UIGraphicsBeginImageContextWithOptions(size, false, 0);
        self.draw(in: scaledImageRect)
        let scaledImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext()
        return scaledImage!
        */
        /*
        let widthRatio = newSize.width / size.width
        let heightRatio = newSize.height / size.height
        
        let scaleFactor = min(widthRatio, heightRatio)
        
        // Compute the new image size that preserves aspect ratio
        let scaledImageSize = CGSize(
            width: size.width * scaleFactor,
            height: size.height * scaleFactor
        )

        // Draw and return the resized UIImage
        let renderer = UIGraphicsImageRenderer(
            size: scaledImageSize
        )

        let scaledImage = renderer.image { _ in
            self.draw(in: CGRect(
                origin: .zero,
                size: scaledImageSize
            ))
        }
        
        return scaledImage
         */
    }
    
    func maskWithColor(color: UIColor) -> UIImage? {
        let maskImage = cgImage!

        let width = size.width
        let height = size.height
        let bounds = CGRect(x: 0, y: 0, width: width, height: height)

        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let bitmapInfo = CGBitmapInfo(rawValue: CGImageAlphaInfo.premultipliedLast.rawValue)
        let context = CGContext(data: nil, width: Int(width), height: Int(height), bitsPerComponent: 8, bytesPerRow: 0, space: colorSpace, bitmapInfo: bitmapInfo.rawValue)!

        context.clip(to: bounds, mask: maskImage)
        context.setFillColor(color.cgColor)
        context.fill(bounds)

        if let cgImage = context.makeImage() {
            let coloredImage = UIImage(cgImage: cgImage)
            return coloredImage
        } else {
            return nil
        }
    }
}

extension UILabel {
    
    func setDefaultLabel() {
        self.textAlignment = .left
        self.font = UIFont.systemFont(ofSize: 17)
        self.textColor = UIColor.black
        self.numberOfLines = 1
        self.lineBreakMode = .byTruncatingTail
    }
    
    func setTitlePageFont() {
        self.font = UIFont(name:"ArialRoundedMTBold", size: 25)
        self.textColor = UIColor.black
    }
}

extension UIStackView {
    
    func setDefaultStackView(axis: NSLayoutConstraint.Axis) {
        self.axis = axis
        self.distribution = .fillEqually
        self.alignment = .center
        self.spacing = 0
    }
}

extension UIScrollView {
    
    func setDefaultScrollView() {
        self.backgroundColor = UIColor.white.withAlphaComponent(0.0)//transparent
        self.isDirectionalLockEnabled = true
        self.isUserInteractionEnabled = false
        self.showsHorizontalScrollIndicator = false
        self.showsVerticalScrollIndicator = false
    }
}

extension UIView {
    
    func setDefaultView() {
        self.backgroundColor = UIColor.white.withAlphaComponent(0.0)
    }
    
    func setCardView(_ backgroundClr: UIColor = UIColor.white, _ shadowClr: CGColor = UIColor.black.cgColor) {
        self.backgroundColor = backgroundClr
        self.layer.cornerRadius = 2
        self.layer.masksToBounds = false
        self.layer.shadowColor = shadowClr
        //CGSize(width: 0, height: -3) - for adding top border shadow
        //CGSize(width: 0, height: 3) - for adding bottom border shadow
        //CGSize.zero for to adding all border shadow
        self.layer.shadowOffset = CGSize(width: 0, height: 3)
        self.layer.shadowOpacity = 0.5
        self.layer.shadowPath = UIBezierPath(roundedRect: self.bounds, cornerRadius: 2).cgPath
    }
    
    func borders(for edges:[UIRectEdge], width:CGFloat = 1, color: UIColor = .black, alphaColor:CGFloat = 1) {

        if edges.contains(.all) {
            layer.borderWidth = width
            layer.borderColor = color.cgColor
        } else {
            let allSpecificBorders:[UIRectEdge] = [.top, .bottom, .left, .right]

            for edge in allSpecificBorders {
                if let v = viewWithTag(Int(edge.rawValue)) {
                    v.removeFromSuperview()
                }

                if edges.contains(edge) {
                    let v = UIView()
                    v.tag = Int(edge.rawValue)
                    v.backgroundColor = color.withAlphaComponent(alphaColor)
                    v.translatesAutoresizingMaskIntoConstraints = false
                    addSubview(v)

                    var horizontalVisualFormat = "H:"
                    var verticalVisualFormat = "V:"

                    switch edge {
                    case UIRectEdge.bottom:
                        horizontalVisualFormat += "|-(0)-[v]-(0)-|"
                        verticalVisualFormat += "[v(\(width))]-(0)-|"
                    case UIRectEdge.top:
                        horizontalVisualFormat += "|-(0)-[v]-(0)-|"
                        verticalVisualFormat += "|-(0)-[v(\(width))]"
                    case UIRectEdge.left:
                        horizontalVisualFormat += "|-(0)-[v(\(width))]"
                        verticalVisualFormat += "|-(0)-[v]-(0)-|"
                    case UIRectEdge.right:
                        horizontalVisualFormat += "[v(\(width))]-(0)-|"
                        verticalVisualFormat += "|-(0)-[v]-(0)-|"
                    default:
                        break
                    }

                    self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: horizontalVisualFormat, options: .directionLeadingToTrailing, metrics: nil, views: ["v": v]))
                    self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: verticalVisualFormat, options: .directionLeadingToTrailing, metrics: nil, views: ["v": v]))
                }
            }
        }
    }
    
    //save uiview to image
    func screenshot() -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(bounds.size, false, 0)
        defer { UIGraphicsEndImageContext() }
        drawHierarchy(in: bounds, afterScreenUpdates: true)
        return UIGraphicsGetImageFromCurrentImageContext()
    }
}

extension UIActivityIndicatorView {
    
    func setDefaultIndicatorView() {
        self.hidesWhenStopped = true
        self.style = UIActivityIndicatorView.Style.medium
        self.color = UIColor.white
    }
}

extension UICollectionView {
    
    func setDefaultCollectionView(paging: Bool, _ showsHorizontalIndicator: Bool = false, _ showsVerticalIndicator: Bool = false) {
        self.backgroundColor = UIColor.white
        self.isUserInteractionEnabled = true
        self.isScrollEnabled = true
        // isPagingEnabled means is the collection view not animate but create paging
        self.isPagingEnabled = paging
        self.showsHorizontalScrollIndicator = showsHorizontalIndicator
        self.showsVerticalScrollIndicator = showsVerticalIndicator
    }
}

extension NSAttributedString {
    
    func withLineSpacing(_ spacing: CGFloat) -> NSAttributedString {

        let attributedString = NSMutableAttributedString(attributedString: self)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineBreakMode = .byTruncatingTail
        paragraphStyle.lineSpacing = spacing
        attributedString.addAttribute(.paragraphStyle,
                                      value: paragraphStyle,
                                      range: NSRange(location: 0, length: string.count))
        return NSAttributedString(attributedString: attributedString)
    }
}
