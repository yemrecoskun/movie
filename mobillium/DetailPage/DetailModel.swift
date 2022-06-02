//
//  DetailModel.swift
//  mobillium
//
//  Created by yunus emre coşkun on 2.06.2022.
//
import Foundation

// MARK: - Welcome
struct DetailModel: Decodable {
    let adult: Bool?
    let backdrop_path: String?
    let belongs_to_collection: BelongsToCollection?
    let budget: Int?
    let genres: [Genre]?
    let homepage: String?
    let id: Int?
    let imdb_id, original_language, original_title, overview: String?
    let popularity: Double?
    let poster_path: String?
    let production_companies: [ProductionCompany]?
    let production_countries: [ProductionCountry]?
    let release_date: String?
    let revenue, runtime: Int?
    let spoken_languages: [SpokenLanguage]?
    let status, tagline, title: String?
    let video: Bool?
    let vote_average: Double?
    let vote_count: Int?

}

// MARK: - BelongsToCollection
struct BelongsToCollection: Decodable {
    let id: Int?
    let name, poster_path, backdrop_path: String?

}

// MARK: - Genre
struct Genre: Decodable {
    let id: Int?
    let name: String?
}

// MARK: - ProductionCompany
struct ProductionCompany: Decodable {
    let id: Int?
    let logo_path, name, origin_country: String?

}

// MARK: - ProductionCountry
struct ProductionCountry: Decodable {
    let iso_3166_1, name: String?

}

// MARK: - SpokenLanguage
struct SpokenLanguage: Decodable {
    let english_name, iso_639_1, name: String?

}
