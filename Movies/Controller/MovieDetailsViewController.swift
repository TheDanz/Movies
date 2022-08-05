import UIKit
import RealmSwift

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
        
        DispatchQueue.main.async {
            if self.model.movieObjects?[self.receivedIndex].isLiked == true {
                self.likeButton.tintColor = .red
            } else {
                self.likeButton.tintColor = .black
            }
            self.movieNameLabel.text = Model().movieObjects?[self.receivedIndex].title
            self.movieRatingLabel.text = "Рейтинг " + String(Model().movieObjects?[self.receivedIndex].rating ?? 0)
            self.posterImageView.image = UIImage(named: Model().movieObjects?[self.receivedIndex].picture ?? "image1")
            self.movieReleaseYearLabel.text = "Год " + String(Model().movieObjects?[self.receivedIndex].releaseYear ?? 0)
        }
        
        if cameFromFav {
            posterImageView.image = UIImage(named: Model().likedMovieObjects?[receivedIndex].picture ?? "image1")
            movieNameLabel.text = Model().likedMovieObjects?[receivedIndex].title
            movieReleaseYearLabel.text = String(Model().likedMovieObjects?[receivedIndex].releaseYear ?? 0)
            movieRatingLabel.text = String(Model().likedMovieObjects?[receivedIndex].rating ?? 0)
        } else {
            posterImageView.image = UIImage(named: Model().movieObjects?[receivedIndex].picture ?? "image1")
            movieNameLabel.text = Model().movieObjects?[receivedIndex].title
            movieReleaseYearLabel.text = String(Model().movieObjects?[receivedIndex].releaseYear ?? 0)
            movieRatingLabel.text = String(Model().movieObjects?[receivedIndex].rating ?? 0)
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
        model.updateLike(at: receivedIndex)
        
        if likeButton.alpha == 1 {
            likeButton.alpha = 0.45
            likeButton.tintColor = .gray
        } else {
            likeButton.alpha = 1
            likeButton.tintColor = .black
        }
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
