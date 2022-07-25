import UIKit

class FavoriteMoviesViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    var model = Model()
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
        return Model().showLikedItems().count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FavoriteMovieCollectionViewCell", for: indexPath) as? FavoriteMovieCollectionViewCell else { return UICollectionViewCell() }
        cell.data = self.model.showLikedItems()[indexPath.item]
        return cell
    }
}
