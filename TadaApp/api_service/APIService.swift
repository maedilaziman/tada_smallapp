//
//  APIService.swift
//  TadaApp
//
//  Created by maedi laziman on 29/01/22.
//  Copyright © 2022 maedi laziman. All rights reserved.
//

import AlamofireImage
import Alamofire

class APIService: NSObject {
    
    let isNetworkAvailable = NetworkReachabilityManager()?.isReachable
    
    func fetchMovie(completion : @escaping (MovieBaseModel) -> (), errorHandle : @escaping (String) -> ()){
        AF.request(Constants.moviesFromGenreIdUrl, method: .get).responseData { response in
            switch response.result {
                case .failure(let error):
                    print(error.localizedDescription)
                    errorHandle(error.localizedDescription)
                    break
                case .success(let data):
                    if !self.isNetworkAvailable! {
                        errorHandle("No internet connection!")
                        break
                    }
                    do {
                        let getData = try JSONDecoder().decode(MovieBaseModel.self, from: data)
                        completion(getData)
                    } catch let error {
                        print(error)
                        errorHandle(error.localizedDescription)
                    }
                    break
                }
        }
    }
    
    func fetchImageFromServer(url: String, imgView: UIImageView, errorHandle : @escaping (String) -> ()) {
        if !self.isNetworkAvailable! {
            errorHandle("No internet connection!")
            return
        }
        let downloadURL = URL(string: url)!
        imgView.af.setImage(withURL: downloadURL)
    }
}
