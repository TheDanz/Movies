import UIKit
import RealmSwift

class FavoriteMoviesViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    var model = Model()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        model.showLikedItems()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        let xibFavoriteCell = UINib(nibName: "FavoriteMovieCollectionViewCell", bundle: nil)
        collectionView.register(xibFavoriteCell, forCellWithReuseIdentifier: "FavoriteMovieCollectionViewCell")
        collectionView.reloadData()
    }
}

extension FavoriteMoviesViewController: UICollectionViewDelegate {
    
}

extension FavoriteMoviesViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return model.likedMoviesArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FavoriteMovieCollectionViewCell", for: indexPath) as? FavoriteMovieCollectionViewCell else { return UICollectionViewCell() }
        cell.data = self.model.likedMoviesArray[indexPath.item]
        return cell
    }
}
