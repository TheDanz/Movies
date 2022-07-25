//
//  MovieDetailsViewController.swift
//  Movies
//
//  Created by Danil Ryumin on 24.06.2022.
//

import UIKit

class MovieDetailsViewController: UIViewController, UIViewControllerTransitioningDelegate {
    var receivedIndex: Int = Int()
    var cameFromFav: Bool = Bool()
    var transtition: RoundingTransition = RoundingTransition()
    @IBOutlet weak var movieNameLabel: UILabel!
    @IBOutlet weak var movieRatingLabel: UILabel!
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var movieReleaseYearLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        movieNameLabel.text = Model().testArray[receivedIndex].testTitle
        movieRatingLabel.text = "Рейтинг " + String(Model().testArray[receivedIndex].testRating ?? 0)
        posterImageView.image = UIImage(named: Model().testArray[receivedIndex].testPicture ?? "image1")
        movieReleaseYearLabel.text = "Год " + String(Model().testArray[receivedIndex].testYear!)
        
        if cameFromFav {
            posterImageView.image = UIImage(named: Model().showLikedItems()[receivedIndex].testPicture ?? "image1")
            movieNameLabel.text = Model().showLikedItems()[receivedIndex].testTitle
            movieReleaseYearLabel.text = String(Model().showLikedItems()[receivedIndex].testYear ?? 0)
            movieRatingLabel.text = String(Model().showLikedItems()[receivedIndex].testRating ?? 0)
        } else {
            posterImageView.image = UIImage(named: Model().testArray[receivedIndex].testPicture ?? "image1")
            movieNameLabel.text = Model().testArray[receivedIndex].testTitle
            movieReleaseYearLabel.text = String(Model().testArray[receivedIndex].testYear ?? 0)
            movieRatingLabel.text = String(Model().testArray[receivedIndex].testRating ?? 0)
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
    
    @IBAction func tapGestureAction(_ sender: UITapGestureRecognizer) {
        
    }
}
