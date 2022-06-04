//
//  Endpoints.swift
//  movie
//
//  Created by yunus emre coşkun  on 2.06.2022.
//

import Foundation

public enum Endpoints : String{
    case movieUpcoming = "/movie/upcoming"
    case movieNowPlaying = "/movie/now_playing"
    case movieDetails = "/movie/{id}"
}
