//
//  ViewModel.swift
//  TadaApp
//
//  Created by maedi laziman on 29/01/22.
//  Copyright © 2022 maedi laziman. All rights reserved.
//
import UIKit

class ViewModel {
    
    private var popWhileLoadObject: UIView!
    
    private var apiService: APIService = APIService()
    
    private(set) var listMovieData : MovieBaseModel! {
        didSet {
            self.bindMovieViewModel()
        }
    }
    
    var bindMovieViewModel : (() -> ()) = {}
    
    var bindErrorDescViewModel: (() -> ()) = {}
    
    func allListMovie() -> MovieBaseModel {
        return self.listMovieData
    }
    
    private(set) var errorDesc : String! {
        didSet {
            self.bindErrorDescViewModel()
        }
    }
    
    func getMovie(ctr: UIViewController) {
        popWhileLoadObject = Helper.showInfoWhileLoadObject(view : ctr.view, isContentMainView: true, message : "Loading data..")
        apiService.fetchMovie(completion: {(itemData) in
            DispatchQueue.main.async {
                Helper.hideInfoWhileLoadObject(view : self.popWhileLoadObject)
            }
            self.listMovieData = itemData
            
        }, errorHandle: { (errorDesc) in
            DispatchQueue.main.async {
                Helper.hideInfoWhileLoadObject(view : self.popWhileLoadObject)
            }
            self.errorDesc = errorDesc
        })
    }
    
    func fetchImageFromApi(url: String, imgView: UIImageView) {
        apiService.fetchImageFromServer(url: url, imgView: imgView, errorHandle: { (errorDesc) in
            self.errorDesc = errorDesc
        })
    }
}
