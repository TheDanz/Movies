import UIKit

class FavoriteMoviesViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        
        let xibFavoriteCell = UINib(nibName: "FavoriteFilmViewCell", bundle: nil)
        collectionView.register(xibFavoriteCell, forCellWithReuseIdentifier: "FavoriteFilmViewCell")
        collectionView.reloadData()
    }
}

extension FavoriteMoviesViewController: UICollectionViewDelegate {
    
}

extension FavoriteMoviesViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        <#code#>
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FavoriteFilmViewCell", for: indexPath) as? FavoriteMovieCollectionViewCell else { return UICollectionViewCell() }
        
        return cell
    }
}
