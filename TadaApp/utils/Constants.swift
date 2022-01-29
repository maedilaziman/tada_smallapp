//
//  Constants.swift
//  TadaApp
//
//  Created by maedi laziman on 29/01/22.
//  Copyright © 2022 maedi laziman. All rights reserved.
//

import UIKit

struct Constants {
    
    static let moviesFromGenreIdUrl = "https://api.themoviedb.org/3/discover/movie?api_key=1730f647ffffae52dcf04ca216128d36&with_genres=action"
    
    //default poster image path: https://image.tmdb.org/t/p/w185 
    static let posterMovieUrl = "https://image.tmdb.org/t/p/"
    
    static let appTitle = "TADA GIFT SHARING"
    
    static let defActiveTextIndicatorColor = "#FFFFFF"
    
    static let defHeightTfSearch = 40
    
    static let marginFromSuperview:CGFloat = 12
    
    static let marginFromSide:CGFloat = 50
    
    static let marginBetweenViewOrSpacing:CGFloat = 18
    
    static let widthCellRowMovie:CGFloat = 50
    
    static let verticalPaddingContentView:CGFloat = 40
}

struct Placeholder {
    
    static let userName = "Enter your User Name"
    
    static let password = "Enter valid password"
}

struct CharacterRange {
    
    static let userNameMinLength = 3
    
    static let userNameMaxLength = 10
    
    static let passwordMinLength = 6
    
    static let passwordMaxLength = 16
}
