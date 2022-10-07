import UIKit
import RealmSwift

class PosterFullViewController: UIViewController {
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var fullPosterImageView: UIImageView!
    var address = "https://image.tmdb.org/t/p/w500"
    let urlService = URLService()
    var detailIndexPath: Int = Int()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let unwrFilmPic = Model.movieObjects?[self.detailIndexPath].picture,
              let posterURL = URL(string: self.address + unwrFilmPic) else {
            return
        }
        
        urlService.getSetPoster(url: posterURL) { image in
            self.fullPosterImageView.image = image
        }
    }
    
    @IBAction func closeButtonClick(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
