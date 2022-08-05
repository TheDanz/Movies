import UIKit
import RealmSwift

class PosterFullViewController: UIViewController {
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var fullPosterImageView: UIImageView!
    var detailIndexPath: Int = Int()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fullPosterImageView.image = UIImage(named: Model().movieObjects?[detailIndexPath].picture ?? "image1")
    }
    
    @IBAction func closeButtonClick(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
