import UIKit

class FavoriteMoviesViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    
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
        cell.posterImageView.image = UIImage(named: Model().showLikedItems()[indexPath.item].testPicture ?? "image2")
        cell.movieNameLabel.text = Model().showLikedItems()[indexPath.item].testTitle
        cell.movieReleaseYearLabel.text = String(Model().showLikedItems()[indexPath.item].testYear ?? 0)
        cell.movieRatingLabel.text = String(Model().showLikedItems()[indexPath.item].testRating ?? 0)
        
        return cell
    }
}
