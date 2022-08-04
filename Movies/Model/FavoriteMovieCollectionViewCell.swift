import UIKit
import RealmSwift

class FavoriteMovieCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var movieNameLabel: UILabel!
    @IBOutlet weak var movieReleaseYearLabel: UILabel!
    @IBOutlet weak var movieRatingLabel: UILabel!
    var data: Item? {
        didSet {
            guard data != nil else { return }
            posterImageView.image = UIImage(named: data?.testPicture ?? "image1")
            movieNameLabel.text = data?.testTitle
            movieReleaseYearLabel.text = String(data?.testYear ?? 0)
            movieRatingLabel.text = String(data?.testRating ?? 0)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
