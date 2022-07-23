//
//  MovieDetailsViewController.swift
//  Movies
//
//  Created by Danil Ryumin on 24.06.2022.
//

import UIKit

class MovieDetailsViewController: UIViewController, UIViewControllerTransitioningDelegate {
    var receivedIndex: Int = Int()
    var transtition: RoundingTransition = RoundingTransition()
    @IBOutlet weak var movieNameLabel: UILabel!
    @IBOutlet weak var movieRatingLabel: UILabel!
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var movieReleaseYearLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        movieNameLabel.text = testArray[receivedIndex].testMovieName
        movieRatingLabel.text = "Рейтинг " + testArray[receivedIndex].testRating!
        posterImageView.image = UIImage(named: testArray[receivedIndex].testPicture ?? "image1")
        movieReleaseYearLabel.text = "Год " + testArray[receivedIndex].testReleaseDate!
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
