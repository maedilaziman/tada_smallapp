//
//  DetailViewController.swift
//  TadaApp
//
//  Created by maedi laziman on 29/01/22.
//  Copyright © 2022 maedi laziman. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    var scrollView: UIScrollView!
    
    var mainContentView = UIView()
    
    var parentView: UIView!
    
    var posterMovie: UIImageView!
    
    var titleMovie: UILabel!
    
    var autolayoutScrollView: ScrollViewAutolayoutCreator!
    
    var movieData: MovieModel!
    
    var viewModel: ViewModel!
    
    init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?, movieData: MovieModel, viewModel: ViewModel, action: @escaping (()->())) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        self.movieData = movieData
        self.viewModel = viewModel
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
        titleMovie.text = movieData.original_title
        viewModel.fetchImageFromApi(url: Constants.posterMovieUrl+"w185"+movieData.poster_path, imgView: posterMovie)
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
}

extension DetailViewController {

    private func commonInit(){
        let leftCustomViewButton = UIButton(type: .system)
        var img = UIImage(systemName: "chevron.left")
        img = img?.imageWith(newSize: CGSize(width: 14, height: 18))
        leftCustomViewButton.setImage(img!.maskWithColor(color: .black), for: .normal)
        leftCustomViewButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        leftCustomViewButton.setTitle("\tDetail", for: .normal)
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
        
        posterMovie = UIImageView()
        posterMovie.image = UIImage(systemName: "photo.fill")
        posterMovie.setDefaultImageView()
        posterMovie.contentMode = UIView.ContentMode.scaleAspectFill
        posterMovie.layer.cornerRadius = 2
        
        titleMovie = UILabel()
        titleMovie.setDefaultLabel()
        titleMovie.numberOfLines = 2
        titleMovie.font = UIFont.boldSystemFont(ofSize: 14)
        titleMovie.textAlignment = .left
        
        autolayoutScrollView = ScrollViewAutolayoutCreator(superView: self.view)
        scrollView = autolayoutScrollView.scrollView
        mainContentView = autolayoutScrollView.contentView
        mainContentView.setDefaultView()
        
        parentView.addSubview(posterMovie)
        parentView.addSubview(titleMovie)
        mainContentView.addSubview(parentView)
        
        setConstraint()
        
        autolayoutScrollView.addVerticalConstraints(views: [parentView], verticalPadding: Constants.verticalPaddingContentView)
    }
    
    private func setConstraint() {
        parentView.translatesAutoresizingMaskIntoConstraints = false
        posterMovie.translatesAutoresizingMaskIntoConstraints = false
        titleMovie.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            mainContentView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 0),
            mainContentView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 0),
            
            parentView.topAnchor.constraint(equalTo: mainContentView.topAnchor, constant: 0),
            parentView.leadingAnchor.constraint(equalTo: mainContentView.leadingAnchor, constant: Constants.marginFromSide),
            parentView.trailingAnchor.constraint(equalTo: mainContentView.trailingAnchor, constant: -Constants.marginFromSide),
            parentView.heightAnchor.constraint(greaterThanOrEqualTo: self.view.heightAnchor),
            parentView.centerYAnchor.constraint(equalTo: scrollView.centerYAnchor),
            
            posterMovie.topAnchor.constraint(equalTo: parentView.topAnchor, constant: 20),
            posterMovie.heightAnchor.constraint(equalToConstant: 120),
            posterMovie.widthAnchor.constraint(equalToConstant: 120),
            posterMovie.centerXAnchor.constraint(equalTo: parentView.centerXAnchor),
            
            titleMovie.topAnchor.constraint(equalTo: posterMovie.bottomAnchor, constant: 40),
            titleMovie.centerXAnchor.constraint(equalTo: parentView.centerXAnchor),
            
        ])
    }
    
    @objc func didTapLeftBarButton(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
}
