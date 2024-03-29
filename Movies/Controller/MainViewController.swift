import UIKit
import RealmSwift

class MainViewController: UIViewController, UICollectionViewDelegate {
    @IBOutlet weak var mainCollectionView: UICollectionView!
    var searchController = UISearchController()
    let model = Model()
    let service = URLService()
    let realm = try? Realm()
    let isFromSearchBar: Bool = false
    @IBOutlet weak var sortButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        model.fillUpMovieObjects()
        
        mainCollectionView.dataSource = self
        mainCollectionView.delegate = self

        searchController.searchBar.delegate = self
        searchController.searchBar.placeholder = "Найти фильм"
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        
        let xibCell = UINib(nibName: "MovieCollectionViewCell", bundle: nil)
        mainCollectionView.register(xibCell, forCellWithReuseIdentifier: "MovieCell")

        setFavoriteMoviesButton()
        
        DispatchQueue.main.async {
            self.service.dataRequest()
        }
        mainCollectionView.reloadData()
    }
    
    @IBAction func sortButtonClick(_ sender: Any) {
        let arrowUp = UIImage(systemName: "arrow.up")
        let arrowDown = UIImage(systemName: "arrow.down")
        model.sortAscending = !model.sortAscending
        sortButton.image = model.sortAscending ? arrowDown : arrowUp
        model.ratingSort()
        DispatchQueue.main.async {
            self.mainCollectionView.reloadData()
        }
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

extension MainViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Model.movieObjects?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = mainCollectionView.dequeueReusableCell(withReuseIdentifier: "MovieCell", for: indexPath) as? MovieCollectionViewCell,
              let item = Model.movieObjects?[indexPath.row] else { return UICollectionViewCell() }
        cell.data = item
        cell.layer.cornerRadius = 10
        return cell
    }
        
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let destinationViewController = storyboard?.instantiateViewController(withIdentifier: "MovieDetailsViewController") as? MovieDetailsViewController else { return }
        destinationViewController.receivedIndex = indexPath.row
        navigationController?.pushViewController(destinationViewController, animated: true)
    }
}

extension MainViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        model.search(searchTextValue: searchText)
        
        if searchBar.text?.count == 0 {
            model.fillUpMovieObjects()
            let arrowUpRightAndArrowDownLeft = UIImage(systemName: "arrow.up.right.and.arrow.down.left.rectangle")
            sortButton.image = arrowUpRightAndArrowDownLeft
        }
        
        DispatchQueue.main.async {
            self.mainCollectionView.reloadData()
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        model.fillUpMovieObjects()
        
        let arrowUpRightAndArrowDownLeft = UIImage(systemName: "arrow.up.right.and.arrow.down.left.rectangle")
        sortButton.image = arrowUpRightAndArrowDownLeft

        DispatchQueue.main.async {
            self.mainCollectionView.reloadData()
        }
    }
}
