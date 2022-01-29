//
//  HomeCollViewCell.swift
//  TadaApp
//
//  Created by maedi laziman on 29/01/22.
//  Copyright © 2022 maedi laziman. All rights reserved.
//

import UIKit
import SnapKit

class HomeCollViewCell: UICollectionViewCell {
    
    var parentView: UIView!
    
    var posterMovie: UIImageView!
    
    var titleMovie: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        commonInit()
    }
}

extension HomeCollViewCell {
    
    private func commonInit() {
        parentView = UIView()
        parentView.borders(for: [.bottom], width: 1, color: .gray, alphaColor: 1.0)
        
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
        
        parentView.addSubview(posterMovie)
        parentView.addSubview(titleMovie)
        self.addSubview(parentView)
        
        setConstraint()
    }
    
    func configure(model: MovieModel, viewModel: ViewModel){
        viewModel.fetchImageFromApi(url: Constants.posterMovieUrl+"w185"+model.poster_path, imgView: posterMovie)
        titleMovie.text = model.original_title
    }
    
    private func setConstraint(){
        parentView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.leading.equalTo(self.snp.leading).offset(10)
            make.trailing.equalTo(self.snp.trailing).offset(-10)
        }
        
        posterMovie.snp.makeConstraints { make in
            make.top.equalTo(parentView.snp.top).offset(0)
            make.leading.equalTo(parentView.snp.leading).offset(0)
            make.width.equalTo(Constants.widthCellRowMovie)
            make.height.equalTo(Constants.widthCellRowMovie)
        }
        
        titleMovie.snp.makeConstraints { make in
            make.leading.equalTo(posterMovie.snp.trailing).offset(10)
            make.trailing.equalTo(parentView.snp.trailing).offset(0)
            make.centerY.equalTo(posterMovie.snp.centerY)
        }
    }
}
