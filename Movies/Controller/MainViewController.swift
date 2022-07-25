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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let destinationViewController = storyboard?.instantiateViewController(withIdentifier: "MovieDetailsViewController") as? MovieDetailsViewController else { return }
        destinationViewController.receivedIndex = indexPath.row
        navigationController?.pushViewController(destinationViewController, animated: true)
    }
}

extension MainViewController: UISearchBarDelegate {
    
}
