//
//  ListMovieViewController.swift
//  TadaApp
//
//  Created by maedi laziman on 29/01/22.
//  Copyright © 2022 maedi laziman. All rights reserved.
//

import UIKit

class ListMovieViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    var collViewMovie: UICollectionView!
    
    var layoutMovie: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
    
    var layoutPopular: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
    
    let reuseIdMovie:String = "list_movie_cell"
    
    let xibName:String = "HomeCollViewCell"
    
    var dataListItem: [MovieModel] = []
    
    var countDataCellMovie:Int = 0
    
    let sectionInsetsCell = UIEdgeInsets(top: 10, left: 10, bottom: 35, right: 10)
    
    var viewModel : ViewModel = ViewModel()
    
    let actMoveToDetail: ((MovieModel, ViewModel)->())
    
    init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?, action: @escaping ((MovieModel, ViewModel)->())) {
        self.actMoveToDetail = action
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
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        coordinator.animate(alongsideTransition: { (UIViewControllerTransitionCoordinatorContext) -> Void in
            self.layoutMovie.invalidateLayout()
        }, completion: { (UIViewControllerTransitionCoordinatorContext) -> Void in print("rotation_completed")
        })
        super.viewWillTransition(to: size, with: coordinator)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        countDataCellMovie
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdMovie, for: indexPath) as! HomeCollViewCell
        cell.configure(model: dataListItem[indexPath.row], viewModel: viewModel)
        cell.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapCellMovie(_:))))
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: Constants.widthCellRowMovie+10)
    }
}

extension ListMovieViewController {
    
    private func commonInit(){
        countDataCellMovie = dataListItem.count
        
        setLayoutCollView(layout: layoutMovie)
        collViewMovie = UICollectionView(frame: self.view.frame, collectionViewLayout: layoutMovie)
        collViewMovie.backgroundColor = .clear
        collViewMovie.dataSource = self
        collViewMovie.delegate = self
        collViewMovie.register(UINib.init(nibName: xibName, bundle: nil), forCellWithReuseIdentifier: reuseIdMovie)
        
        view.addSubview(collViewMovie)
        
        setConstraint()
        
        getMovieData()
    }
    
    private func setConstraint() {
        collViewMovie.snp.makeConstraints { make in
            make.leading.trailing.top.bottom.equalToSuperview()
        }
    }
    
    private func setLayoutCollView(layout: UICollectionViewFlowLayout) {
        layout.sectionInset = sectionInsetsCell
        layout.scrollDirection = .vertical
        layout.estimatedItemSize = .zero
        layout.minimumLineSpacing = 10
    }
    
    private func getMovieData() {
        viewModel.getMovie(ctr: self)
        viewModel.bindMovieViewModel = {
            self.dataListItem = self.viewModel.listMovieData.results
            //print("self.dataListItem: \(self.dataListItem)")
            DispatchQueue.main.async {
                self.countDataCellMovie = self.dataListItem.count
                self.collViewMovie.reloadData()
            }
        }
        
        viewModel.bindErrorDescViewModel = {
            let alert = UIAlertController(title: "Error", message: self.viewModel.errorDesc, preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    @objc func didTapCellMovie(_ sender: UITapGestureRecognizer) {
        let location = sender.location(in: self.collViewMovie)
        let indexPath = self.collViewMovie.indexPathForItem(at: location)
        self.actMoveToDetail(dataListItem[indexPath!.row], viewModel)
    }
}
