//
//  LocationViewCell.swift
//  LocationWiki
//
//  Created by Kostiantyn Gorbunov on 22/11/2021.
//

import UIKit

class LocationViewCell: UICollectionViewCell, NibInstantiatable {

    @IBOutlet private weak var borderedView: BorderedView? {
        didSet {
            borderedView?.borderColor = UIColor.darkGray.cgColor
        }
    }
    @IBOutlet private weak var nameLabel: UILabel?
    @IBOutlet private weak var locationLabel: UILabel?

    var viewModel: LocationViewModel? {
        didSet {
            guard let viewModel = viewModel else {
                return
            }
            nameLabel?.text = viewModel.name
            locationLabel?.text = viewModel.coordinate
            borderedView?.borderSides = viewModel.borderSides
        }
    }
}
