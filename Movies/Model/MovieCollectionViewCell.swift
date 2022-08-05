import UIKit
import RealmSwift

class MovieCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var posterPreviewImageView: UIImageView!
    @IBOutlet weak var movieNameLabel: UILabel!
    @IBOutlet weak var releaseYearLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    var data: MovieObject? {
        didSet {
            guard data != nil else { return }
            posterPreviewImageView.image = UIImage(named: data?.picture ?? "image1")
            movieNameLabel.text = data?.title
            releaseYearLabel.text = String(data?.releaseYear ?? 0)
            ratingLabel.text = String(data?.rating ?? 0)
        }
    }
}
