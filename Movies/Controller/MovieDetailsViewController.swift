import UIKit

class MovieDetailsViewController: UIViewController, UIViewControllerTransitioningDelegate {
    var receivedIndex: Int = Int()
    var cameFromFav: Bool = Bool()
    var model = Model()
    var transtition: RoundingTransition = RoundingTransition()
    @IBOutlet weak var movieNameLabel: UILabel!
    @IBOutlet weak var movieRatingLabel: UILabel!
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var movieReleaseYearLabel: UILabel!
    @IBOutlet weak var likeButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        movieNameLabel.text = Model().testArray[receivedIndex].testTitle
        movieRatingLabel.text = "Рейтинг " + String(Model().testArray[receivedIndex].testRating ?? 0)
        posterImageView.image = UIImage(named: Model().testArray[receivedIndex].testPicture ?? "image1")
        movieReleaseYearLabel.text = "Год " + String(Model().testArray[receivedIndex].testYear!)
        
        if cameFromFav {
            posterImageView.image = UIImage(named: Model().likedMoviesArray[receivedIndex].testPicture ?? "image1")
            movieNameLabel.text = Model().likedMoviesArray[receivedIndex].testTitle
            movieReleaseYearLabel.text = String(Model().likedMoviesArray[receivedIndex].testYear ?? 0)
            movieRatingLabel.text = String(Model().likedMoviesArray[receivedIndex].testRating ?? 0)
        } else {
            posterImageView.image = UIImage(named: Model().testArray[receivedIndex].testPicture ?? "image1")
            movieNameLabel.text = Model().testArray[receivedIndex].testTitle
            movieReleaseYearLabel.text = String(Model().testArray[receivedIndex].testYear ?? 0)
            movieRatingLabel.text = String(Model().testArray[receivedIndex].testRating ?? 0)
        }
        
        if model.testArray[receivedIndex].isLiked == true {
            likeButton.tintColor = .red
        } else {
            likeButton.tintColor = .black
        }
    }
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transtition.transitionProfile = .show
        transtition.start = posterImageView.center
        transtition.roundColor = UIColor.lightGray
        return transtition
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transtition.transitionProfile = .cancel
        transtition.start = posterImageView.center
        transtition.roundColor = UIColor.lightGray
        return transtition
    }
    
    @IBAction func likeButtonClick(_ sender: Any) {

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destinationViewController = segue.destination as? PosterFullViewController else { return }
        destinationViewController.detailIndexPath = receivedIndex
        destinationViewController.transitioningDelegate = self
        destinationViewController.modalPresentationStyle = .custom
    }
    
    @IBAction func tapGestureAction(_ sender: UITapGestureRecognizer) {
        
    }
}
