//
//  JSONModel.swift
//  Movies
//
//  Created by Danil Ryumin on 24.06.2022.
//

import Foundation

class JSONModel: Codable {
    var original_title: String?
    var poster_path: String?
    var release_date: String?
    var overview: String?
    var vote_average: Double?
    var backdrop_path: String?
}

class TestModel {
    var testPicture: String?
    var testMovieName: String?
    var testReleaseDate: String?
    var testRating: String?
    
    init(testPicture: String?, testMovieName: String?, testReleaseDate: String?, testRating: String?) {
        self.testPicture = testPicture
        self.testMovieName = testMovieName
        self.testReleaseDate = testReleaseDate
        self.testRating = testRating
    }
}
