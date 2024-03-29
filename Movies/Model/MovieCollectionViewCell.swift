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
            
            urlService.getSetPoster(url: url) { image in
                self.posterPreviewImageView.image = image
            }
            
            movieNameLabel.text = unwrData.title
            releaseYearLabel.text = "Год: " + String(unwrData.releaseYear)
            ratingLabel.text = "Рейтинг: " + String(unwrData.rating)
        }
    }
}
