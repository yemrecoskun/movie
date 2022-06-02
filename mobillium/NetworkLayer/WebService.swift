//
//  Service.swift
//  mobillium
//
//  Created by yunus emre coşkun  on 1.06.2022.
//

import Foundation

public class WebService {
    
    private static let apiUrl = "https://api.themoviedb.org/3"
    private static let apiKey = "?api_key=bf3eb8a35a8c731745f49576b874adc1"
    static let imageUrl = "https://image.tmdb.org/t/p/w500"
    
    static func getMovies(_ endpoint: String,completion: @escaping (Model?) -> ()){
        URLSession.shared.dataTask(with: (URL(string: apiUrl + endpoint + apiKey))!) {( data, response, error) in
                if let error = error {
                    completion(nil)
                }
                else if let data = data{
                    let model = try? JSONDecoder().decode(Model.self, from: data)
                    if let model = model{
                        completion(model)
                    }
                }
            }.resume()
    }
    
    static func getDetailMovie(_ endpoint: String,completion: @escaping (DetailModel?) -> ()){
        let url = apiUrl + endpoint + apiKey
        URLSession.shared.dataTask(with: (URL(string: apiUrl + endpoint + apiKey))!) {( data, response, error) in
                if let error = error {
                    completion(nil)
                }
                else if let data = data{
                    let model = try? JSONDecoder().decode(DetailModel.self, from: data)
                    if let model = model{
                        completion(model)
                    }
                }
            }.resume()
    }
}
