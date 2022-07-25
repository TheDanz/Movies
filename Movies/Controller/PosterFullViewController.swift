//
//  PosterFullViewController.swift
//  Movies
//
//  Created by Danil Ryumin on 17.07.2022.
//

import UIKit

class PosterFullViewController: UIViewController {
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var fullPosterImageView: UIImageView!
    var detailIndexPath: Int = Int()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fullPosterImageView.image = UIImage(named: testArray[detailIndexPath].testPicture ?? "image1")
    }
    
    @IBAction func closeButtonClick(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
