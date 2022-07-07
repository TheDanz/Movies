//
//  ViewController.swift
//  Movies
//
//  Created by Danil Ryumin on 23.06.2022.
//

import UIKit

class MainViewController: UIViewController {
    @IBOutlet weak var mainCollectionView: UICollectionView!
    @IBOutlet weak var moviesSearchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainCollectionView.dataSource = self
        mainCollectionView.delegate = self
        moviesSearchBar.delegate = self
        
        let xibCell = UINib(nibName: "MovieCollectionViewCell", bundle: nil)
        mainCollectionView.register(xibCell, forCellWithReuseIdentifier: "MovieCell")
        mainCollectionView.reloadData()
    }
}

extension MainViewController: UICollectionViewDelegate {
    
}

extension MainViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return testArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = mainCollectionView.dequeueReusableCell(withReuseIdentifier: "MovieCell", for: indexPath) as? MovieCollectionViewCell else { return UICollectionViewCell()}
        cell.posterPreviewImageView.image = UIImage(named: testArray[indexPath.row].testPicture ?? "image1")
        cell.movieNameLabel.text = testArray[indexPath.row].testMovieName
        cell.releaseYearLabel.text = "Год " + testArray[indexPath.row].testReleaseDate!
        cell.ratingLabel.text = "Рейтинг " + testArray[indexPath.row].testRating!
        return cell
    }
}

extension MainViewController: UISearchBarDelegate {
    
}

var testArray: [TestModel] = [
    TestModel(testPicture: "image1", testMovieName: "Фильм1", testReleaseDate: "2001", testRating: "1.1"),
    TestModel(testPicture: "image2", testMovieName: "Фильм2", testReleaseDate: "2002", testRating: "2.2"),
    TestModel(testPicture: "image3", testMovieName: "Фильм3", testReleaseDate: "2003", testRating: "3.3"),
    TestModel(testPicture: "image4", testMovieName: "Фильм4", testReleaseDate: "2004", testRating: "4.4"),
    TestModel(testPicture: "image5", testMovieName: "Фильм5", testReleaseDate: "2005", testRating: "5.5")

]
