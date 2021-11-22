//
//  LocationsCollectionViewController.swift
//  LocationWiki
//
//  Created by Kostiantyn Gorbunov on 22/11/2021.
//

import UIKit

protocol LocationCollectionViewDelegate: AnyObject {
    func didSelectLocation(_ location: Location)
}

class LocationsCollectionViewController: BaseCollectionViewController {

    private let viewModel: LocationListViewModel
    weak var delegate: LocationCollectionViewDelegate?

    init(viewModel: LocationListViewModel, layout: UICollectionViewLayout) {
        self.viewModel = viewModel
        super.init(collectionViewLayout: layout)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func configureCell(_ cell: LocationViewCell, at indexPath: IndexPath) {
        cell.viewModel = LocationViewModel(
            viewModel.locations[indexPath.row],
            borderSides: BorderLayer.Side.border(at: indexPath)
        )
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.locations.count
    }

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let location = viewModel.locations[indexPath.row]
        delegate?.didSelectLocation(location)
    }
}

extension LocationsCollectionViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: Constants.cellWidth(in: self.view), height: flowLayout?.itemSize.height ?? 0)
    }
}
