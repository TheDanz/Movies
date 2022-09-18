import UIKit
import RealmSwift

class MovieDetailsViewController: UIViewController, UIViewControllerTransitioningDelegate {
    var receivedIndex: Int = Int()
    var cameFromFav: Bool = Bool()
    var model = Model()
    var address = "https://image.tmdb.org/t/p/w500"
    let service = URLService()
    var transtition: RoundingTransition = RoundingTransition()
    @IBOutlet weak var movieNameLabel: UILabel!
    @IBOutlet weak var movieRatingLabel: UILabel!
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var movieReleaseYearLabel: UILabel!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var framesCollectionView: UICollectionView!
    @IBOutlet weak var descriptionTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
  
        framesCollectionView.dataSource = self
        framesCollectionView.delegate = self
 
        framesCollectionView.layer.borderWidth = 2.4
        framesCollectionView.layer.borderColor = UIColor.darkGray.cgColor
        
        DispatchQueue.main.async {
            if self.cameFromFav == false {
                guard let unwrFilmPic = self.model.movieObjects?[self.receivedIndex].picture,
                      let posterURL = URL(string: self.address + unwrFilmPic) else {
                return
                }
 
                self.service.getSetPoster(url: posterURL) { image in
                    self.posterImageView.image = image
                }
            
                self.movieNameLabel.text = self.model.movieObjects?[self.receivedIndex].title
                self.movieReleaseYearLabel.text = String(self.model.movieObjects?[self.receivedIndex].releaseYear ?? 0000)
                self.movieRatingLabel.text = String(self.model.movieObjects?[self.receivedIndex].rating ?? 0)
            
                self.descriptionTextView.text = self.model.movieObjects?[self.receivedIndex].about
                
                self.likeButton.alpha = 0.45
                self.likeButton.tintColor = .gray
                
            
                } else if self.cameFromFav == true {
                    guard let unwrFilmPic = self.model.likedMovieObjects?[self.receivedIndex].picture,
                          let posterURL = URL(string: self.address + unwrFilmPic) else {
                        return
                    }
 
                    self.service.getSetPoster(url: posterURL) { image in
                        self.posterImageView.image = image
                    }
            
                    self.movieNameLabel.text = self.model.likedMovieObjects?[self.receivedIndex].title
                    self.movieReleaseYearLabel.text = String(self.model.likedMovieObjects?[self.receivedIndex].releaseYear ?? 0000)
                    self.movieRatingLabel.text = String(self.model.likedMovieObjects?[self.receivedIndex].rating ?? 0)
            
                    self.descriptionTextView.text = self.model.likedMovieObjects?[self.receivedIndex].about
            
                    if self.model.likedMovieObjects?[self.receivedIndex].isLiked == true {
                        self.likeButton.alpha = 1
                        self.likeButton.tintColor = .black
                    }
                }
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
        return model.movieObjects?[receivedIndex].screenshots.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = framesCollectionView.dequeueReusableCell(withReuseIdentifier: "FramesCollectionViewCell", for: indexPath) as? FramesCollectionViewCell else { return UICollectionViewCell() }
        guard let url = URL(string: address + (model.movieObjects?[receivedIndex].screenshots[indexPath.row])!) else {
            return UICollectionViewCell()
        }
        service.getSetPoster(url: url) { image in
            cell.imageView.image = image
        }
        return cell
    }
}
