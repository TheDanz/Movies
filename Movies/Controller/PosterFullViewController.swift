import UIKit
import RealmSwift

class PosterFullViewController: UIViewController {
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var fullPosterImageView: UIImageView!
    var address = "https://image.tmdb.org/t/p/w500"
    let urlService = URLService()
    var detailIndexPath: Int = Int()
    let model = Model()
    var isFavorited: Bool = Bool()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if isFavorited == false {
            guard let unwrFilmPic = self.model.movieObjects?[self.detailIndexPath].picture,
                  let posterURL = URL(string: self.address + unwrFilmPic) else {
                return
            }
            
            urlService.getSetPoster(url: posterURL) { image in
                self.fullPosterImageView.image = image
            }
            
        } else if isFavorited == true {
            guard let unwrFilmPic = self.model.movieObjects?[self.detailIndexPath].picture,
                  let posterURL = URL(string: self.address + unwrFilmPic) else {
                return
            }
            
            urlService.getSetPoster(url: posterURL) { image in
                self.fullPosterImageView.image = image
            }
            
        }
    }
    
    @IBAction func closeButtonClick(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
