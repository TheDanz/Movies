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
    @IBOutlet weak var framesCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        framesCollectionView.delegate = self
        framesCollectionView.dataSource = self
        
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
    
    @IBAction func framesButtonClick(_ sender: Any) {
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

extension MovieDetailsViewController: UICollectionViewDelegate {
    
}

extension MovieDetailsViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = framesCollectionView.dequeueReusableCell(withReuseIdentifier: "FramesCollectionViewCell", for: indexPath)
        return cell
    }
}
