import UIKit
import RealmSwift

class FavoriteMoviesViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    var model = Model()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        let xibFavoriteCell = UINib(nibName: "FavoriteMovieCollectionViewCell", bundle: nil)
        
        collectionView.register(xibFavoriteCell, forCellWithReuseIdentifier: "FavoriteMovieCollectionViewCell")
        
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
}

extension FavoriteMoviesViewController: UICollectionViewDelegate {
    
}

extension FavoriteMoviesViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return model.likedMovieObjects?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FavoriteMovieCollectionViewCell", for: indexPath) as? FavoriteMovieCollectionViewCell,
              let likedItem = model.likedMovieObjects?[indexPath.item] else  {
                  return UICollectionViewCell()
              }
        cell.data = likedItem
        cell.cellIndex = indexPath.row
        return cell
    }
}
