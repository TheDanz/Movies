import UIKit
import RealmSwift

class MovieDetailsViewController: UIViewController, UIViewControllerTransitioningDelegate, UICollectionViewDelegate {
    var receivedIndex: Int = Int()
    var model = Model()
    var address = "https://image.tmdb.org/t/p/w500"
    let service = URLService()
    var transtition: RoundingTransition = RoundingTransition()
    
    @IBOutlet weak var movieNameLabel: UILabel!
    @IBOutlet weak var movieRatingLabel: UILabel!
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var movieReleaseYearLabel: UILabel!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var backdropsCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        backdropsCollectionView.dataSource = self
        backdropsCollectionView.delegate = self
        backdropsCollectionView.layer.borderWidth = 2.4
        backdropsCollectionView.layer.borderColor = UIColor.systemTeal.cgColor
        let layout = backdropsCollectionView.collectionViewLayout as? UICollectionViewFlowLayout
        layout?.minimumLineSpacing = 10
        
        likeButton.tintColor = .lightGray
        
        DispatchQueue.main.async {
            guard let unwrFilmPic = Model.movieObjects?[self.receivedIndex].picture,
                  let posterURL = URL(string: self.address + unwrFilmPic) else { return }
 
            self.service.getSetPoster(url: posterURL) { image in
                self.posterImageView.image = image
            }
            
            self.movieNameLabel.text = Model.movieObjects?[self.receivedIndex].title
            self.movieReleaseYearLabel.text = "Год: " + String(Model.movieObjects?[self.receivedIndex].releaseYear ?? 0000)
            self.movieRatingLabel.text = "Рейтинг: " + String(Model.movieObjects?[self.receivedIndex].rating ?? 0)
            self.descriptionTextView.text = Model.movieObjects?[self.receivedIndex].about
            
            if let objects = self.model.likedMovieObjects {
                for object in objects {
                    if object.id == Model.movieObjects?[self.receivedIndex].id {
                        self.likeButton.tintColor = .red
                        break
                    }
                }
            }
        }
    }
    
    @IBAction func backdropsButtonClick(_ sender: Any) {
        guard let destinationViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MoviePicturesVC") as? MoviePicturesViewController else { return }
        destinationViewController.receivedIndex = self.receivedIndex
        guard let navigator = navigationController else { return }
        navigator.pushViewController(destinationViewController, animated: true)
    }
    
    @IBAction func likeButtonClick(_ sender: Any) {
        if likeButton.tintColor == .lightGray {
            model.updateLike(at: receivedIndex)
            likeButton.tintColor = .red
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destinationViewController = segue.destination as? PosterFullViewController else { return }
        destinationViewController.detailIndexPath = receivedIndex
        destinationViewController.transitioningDelegate = self
        destinationViewController.modalPresentationStyle = .custom
    }
}

extension MovieDetailsViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Model.movieObjects?[receivedIndex].screenshots.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = backdropsCollectionView.dequeueReusableCell(withReuseIdentifier: "BackdropsCVC", for: indexPath) as? BackdropsCollectionViewCell else {
            return UICollectionViewCell()
        }
        guard let url = URL(string: address + (Model.movieObjects?[receivedIndex].screenshots[indexPath.row])!) else {
            return UICollectionViewCell()
        }
        service.getSetPoster(url: url) { image in
            cell.imageView.image = image
        }
        return cell
    }
}
