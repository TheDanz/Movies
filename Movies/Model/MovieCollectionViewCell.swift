import UIKit
import RealmSwift

class MovieCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var posterPreviewImageView: UIImageView!
    @IBOutlet weak var movieNameLabel: UILabel!
    @IBOutlet weak var releaseYearLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    var address = "https://image.tmdb.org/t/p/w500"
    let urlService = URLService()
    var data: MovieObject? {
        didSet {
            guard let unwrData = data,
                  let url = URL(string: address + unwrData.picture) else { return }
            urlService.getSetPosters(withURL: url, imageView: posterPreviewImageView)
            posterPreviewImageView.image = UIImage(named: data?.picture ?? "image1")
            movieNameLabel.text = data?.title
            releaseYearLabel.text = String(data?.releaseYear ?? 0)
            ratingLabel.text = String(data?.rating ?? 0)
        }
    }
}
