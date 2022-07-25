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
        setFavoriteMoviesButton()
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
    
    private func setFavoriteMoviesButton() {
        let button = UIButton()
        button.setBackgroundImage(#imageLiteral(resourceName: "heart"), for: .normal)
        button.addTarget(self, action: #selector(handlerCreateNewButtonPressed), for: .touchUpInside)
        view.addSubview(button)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -40).isActive = true
        button.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -30).isActive = true
        button.heightAnchor.constraint(equalToConstant: 70).isActive = true
        button.widthAnchor.constraint(equalToConstant: 70).isActive = true
    }
    
    @objc func handlerCreateNewButtonPressed() {
        guard let FavoriteMoviesViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "FavoriteMoviesViewController") as? FavoriteMoviesViewController else { return }
        guard let navigator = navigationController else { return }
        navigator.pushViewController(FavoriteMoviesViewController, animated: true)
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
        destinationViewController.receivedIndex = model.testArray[indexPath.row].id ?? 0
        navigationController?.pushViewController(destinationViewController, animated: true)
    }
}

extension MainViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        model.search(searchTextValue: searchText)
        mainCollectionView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        model.newTestArray = model.testArray
        mainCollectionView.reloadData()
    }
}
