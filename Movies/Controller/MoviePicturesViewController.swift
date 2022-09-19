import UIKit
import RealmSwift

class MoviePicturesViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    @IBOutlet weak var collectionView: UICollectionView!
    let model = Model()
    var receivedIndex: Int = Int()
    var address = "https://image.tmdb.org/t/p/w500"
    let service = URLService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return model.movieObjects?[receivedIndex].screenshots.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MoviePicturesCollectionViewCell", for: indexPath) as? MoviePicturesCollectionViewCell else { return UICollectionViewCell() }
        guard let url = URL(string: address + (model.movieObjects?[receivedIndex].screenshots[indexPath.row])!) else {
            return UICollectionViewCell()
        }
        service.getSetPoster(url: url) { image in
            cell.imageView.image = image
        }
        return cell
    }
}
