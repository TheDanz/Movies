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

var testArray: [TestModel] = [
    TestModel(testPicture: "image1", testMovieName: "Фильм1", testReleaseDate: "2001", testRating: "1.1"),
    TestModel(testPicture: "image2", testMovieName: "Фильм2", testReleaseDate: "2002", testRating: "2.2"),
    TestModel(testPicture: "image3", testMovieName: "Фильм3", testReleaseDate: "2003", testRating: "3.3"),
    TestModel(testPicture: "image4", testMovieName: "Фильм4", testReleaseDate: "2004", testRating: "4.4"),
    TestModel(testPicture: "image5", testMovieName: "Фильм5", testReleaseDate: "2005", testRating: "5.5")
]
