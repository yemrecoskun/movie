//
//  ViewModel.swift
//  mobillium
//
//  Created by yunus emre coşkun  on 1.06.2022.
//

import Foundation

public class ViewModel {
    
    var tableModel : Model?
    var collectionModel : Model?
    
    
    var timer = Timer()
    var counter = 1
    var movieId = 0
    func numberOfRowsTableModel() -> Int {
        return tableModel?.results?.count ?? 0
    }
    
    func selectRowsTableModel(_ index : Int) -> Result? {
        return tableModel?.results?[index]
    }
    
    func numberOfRowsCollectionModel() -> Int {
        return collectionModel?.results?.count ?? 0
    }
    
    func selectRowsCollectionModel(_ index : Int) -> Result? {
        return collectionModel?.results?[index]
    }
    
    func getAllTableModel(completion: @escaping (Model?) -> ()){
        WebService.getMovies(Endpoints.movieUpcoming.rawValue, completion: {model in
            self.tableModel = model
            completion(model)
        })
    }
    
    func getAllCollectionModel(completion: @escaping (Model?) -> ()){
        WebService.getMovies(Endpoints.movieNowPlaying.rawValue, completion: {model in
            self.collectionModel = model
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
