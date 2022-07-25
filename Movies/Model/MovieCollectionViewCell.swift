//
//  MovieCollectionViewCell.swift
//  Movies
//
//  Created by Danil Ryumin on 01.07.2022.
//

import UIKit

class MovieCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var posterPreviewImageView: UIImageView!
    @IBOutlet weak var movieNameLabel: UILabel!
    @IBOutlet weak var releaseYearLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    var data: Item? {
        didSet {
            guard data != nil else { return }
            posterPreviewImageView.image = UIImage(named: data?.testPicture ?? "image1")
            movieNameLabel.text = data?.testTitle
            releaseYearLabel.text = String(data?.testYear ?? 0)
            ratingLabel.text = String(data?.testRating ?? 0)
        }
    }
}
