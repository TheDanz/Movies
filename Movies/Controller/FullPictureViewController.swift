import UIKit
import RealmSwift

class FullPictureViewController: UIViewController {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var numberOfPictureLabel: UILabel!
    var screenshotNumber: Int = Int()
    var receivedIndex: Int = Int()
    var address = "https://image.tmdb.org/t/p/w500"
    let service = URLService()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let count = Model.movieObjects?[receivedIndex].screenshots.count {
            numberOfPictureLabel.text = "\(screenshotNumber + 1) / \(count)"
        }
        
        guard let unwrFilmPic = Model.movieObjects?[receivedIndex].screenshots[screenshotNumber],
              let posterURL = URL(string: address + unwrFilmPic) else {
            return
        }
        
        service.getSetPoster(url: posterURL) { image in
            self.imageView.image = image
        }
    }
}
