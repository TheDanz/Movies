//
//  ViewController.swift
//  Movies
//
//  Created by Danil Ryumin on 23.06.2022.
//

import UIKit

class MainViewController: UIViewController {
    @IBOutlet weak var mainCollectionView: UICollectionView!
    var searchController = UISearchController()
    let model = Model()
    @IBOutlet weak var sortButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        model.newTestArray = model.testArray
        
        mainCollectionView.dataSource = self
        mainCollectionView.delegate = self

        searchController.searchBar.delegate = self
        searchController.searchBar.placeholder = "Найти фильм"
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        
        let xibCell = UINib(nibName: "MovieCollectionViewCell", bundle: nil)
        mainCollectionView.register(xibCell, forCellWithReuseIdentifier: "MovieCell")
        model.ratingSort()
        mainCollectionView.reloadData()
    }
    @IBAction func sortButtonClick(_ sender: Any) {
        let arrowUp = UIImage(systemName: "arrow.up")
        let arrowDown = UIImage(systemName: "arrow.down")
        model.sortAscending = !model.sortAscending
        sortButton.image = model.sortAscending ? arrowUp : arrowDown
        model.ratingSort()
        mainCollectionView.reloadData()
    }
}

extension MainViewController: UICollectionViewDelegate {
    
}

extension MainViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return model.newTestArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = mainCollectionView.dequeueReusableCell(withReuseIdentifier: "MovieCell", for: indexPath) as? MovieCollectionViewCell else { return UICollectionViewCell()}
//        cell.posterPreviewImageView.image = UIImage(named: Model().testArray[indexPath.row].testPicture ?? "image1")
//        cell.movieNameLabel.text = Model().testArray[indexPath.row].testTitle
//        cell.releaseYearLabel.text = "Год " + String(Model().testArray[indexPath.row].testYear ?? 0)
//        cell.ratingLabel.text = "Рейтинг " + String(Model().testArray[indexPath.row].testRating ?? 0)
        cell.data = self.model.newTestArray[indexPath.item]
        return cell
    }
        
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let destinationViewController = storyboard?.instantiateViewController(withIdentifier: "MovieDetailsViewController") as? MovieDetailsViewController else { return }
        destinationViewController.receivedIndex = model.newTestArray[indexPath.row].id ?? 0
        navigationController?.pushViewController(destinationViewController, animated: true)
    }
}

extension MainViewController: UISearchBarDelegate {
    
}
