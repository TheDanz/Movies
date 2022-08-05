import UIKit
import RealmSwift

class FavoriteMovieCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var movieNameLabel: UILabel!
    @IBOutlet weak var movieReleaseYearLabel: UILabel!
    @IBOutlet weak var movieRatingLabel: UILabel!
    var model = Model()
    var data: MovieObject? {
        didSet {
            guard data != nil else { return } 
            posterImageView.image = UIImage(named: data?.picture ?? "image1")
            movieNameLabel.text = data?.title
            movieReleaseYearLabel.text = String(data?.releaseYear ?? 0)
            movieRatingLabel.text = String(data?.rating ?? 0)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    @IBAction func deleteFromFavoriteClick(_ sender: Any) {
        guard let likedData = data else { return }
        model.updateLike(at: likedData.id)
        if alpha == 0.55 {
            alpha = 1
        } else {
            alpha = 0.55
        }
    }
}
