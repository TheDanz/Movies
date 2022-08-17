import UIKit
import RealmSwift

class PosterFullViewController: UIViewController {
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var fullPosterImageView: UIImageView!
    var address = "https://image.tmdb.org/t/p/w500"
    let urlService = URLService()
    var detailIndexPath: Int = Int()
    let model = Model()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let unwrMoviePicture = self.model.movieObjects?[detailIndexPath].picture,
              let posterURL = URL(string: self.address + unwrMoviePicture) else { return }
        self.urlService.getSetPosters(withURL: posterURL, imageView: fullPosterImageView)
    }
    
    @IBAction func closeButtonClick(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
