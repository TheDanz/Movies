import UIKit
import RealmSwift

class FavoriteMovieCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var movieNameLabel: UILabel!
    @IBOutlet weak var movieReleaseYearLabel: UILabel!
    @IBOutlet weak var movieRatingLabel: UILabel!
    var address = "https://image.tmdb.org/t/p/w500"
    let urlService = URLService()
    var model = Model()
    var cellIndex: Int = Int()
    var data: LikedMovieObject? {
        didSet {
            guard let likedData = data,
                  let url = URL(string: address + likedData.picture) else { return }
            urlService.getSetPoster(url: url) { image in
                self.posterImageView.image = image
            }
            
            movieNameLabel.text = likedData.title
            movieReleaseYearLabel.text = "Год: " + String(likedData.releaseYear)
            movieRatingLabel.text = "Рейтинг: " + String(likedData.rating)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    @IBAction func deleteFromFavoriteClick(_ sender: Any) {
        Model.deletedIDs.append(data!.id)
        if alpha == 0.5 {
            alpha = 1
        } else if alpha == 1 {
            alpha = 0.5
        }
    }
}
