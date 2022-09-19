import UIKit
import RealmSwift

class FullPictureViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var numberOfPictureLabel: UILabel!
    var screenshotNumber: Int = Int()
    var receivedIndex: Int = Int()
    var address = "https://image.tmdb.org/t/p/w500"
    let service = URLService()
    let model = Model()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        if let count = model.movieObjects?[receivedIndex].screenshots.count {
            numberOfPictureLabel.text = "\(screenshotNumber + 1) / \(count)"
        }
    }
}

extension FullPictureViewController: UICollectionViewDelegate {
    
}

extension FullPictureViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FullPictureCollectionViewCell", for: indexPath) as? FullPictureCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        guard let unwrFilmPic = model.movieObjects?[receivedIndex].screenshots[screenshotNumber],
              let posterURL = URL(string: address + unwrFilmPic) else {
            return UICollectionViewCell()
        }
        
        service.getSetPoster(url: posterURL) { image in
            cell.imageView.image = image
        }
        return cell
    }
}
