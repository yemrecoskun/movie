//
//  DetailViewModel.swift
//  movie
//
//  Created by yunus emre coşkun  on 2.06.2022.
//

import Foundation

class DetailViewModel {
    var movieId = 0
    
    func getDetailMovie(completion: @escaping (DetailModel?) -> ()){
        WebService.getDetailMovie(Endpoints.movieDetails.rawValue.replacingOccurrences(of: "{id}", with: String(movieId)), completion: {model in
            completion(model)
        })
    }
    
    
    func getImgUrl(_ urlString: String) -> URL?  {
        return URL(string: WebService.imageUrl + urlString)
    }
    
    func dateFormatter(_ date: String) -> String {
        return date.replacingOccurrences(of: "-", with: ".")
    }
}
