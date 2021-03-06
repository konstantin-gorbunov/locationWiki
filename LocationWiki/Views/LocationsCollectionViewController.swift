//
//  LocationsCollectionViewController.swift
//  LocationWiki
//
//  Created by Kostiantyn Gorbunov on 22/11/2021.
//

import UIKit

protocol LocationCollectionViewDelegate: AnyObject {
    func didSelectLocation(_ location: Location)
    func didAddLocation(_ location: Location)
}

protocol LocationListViewModelUpdateDelegate: AnyObject {
    func didModelUpdated(_ viewModel: LocationListViewModel)
}

class LocationsCollectionViewController: BaseCollectionViewController {

    private var viewModel: LocationListViewModel
    weak var delegate: LocationCollectionViewDelegate?

    init(viewModel: LocationListViewModel, layout: UICollectionViewLayout) {
        self.viewModel = viewModel
        super.init(collectionViewLayout: layout)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add Location", style: .plain, target: self, action: #selector(addLocation(sender:)))
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
    
    @objc private func addLocation(sender: LocationsCollectionViewController) {
        debugPrint("addLocation \(sender)")
        alertWithThreeTextFields()
    }
    
    private func alertWithThreeTextFields() {
        let titleMsg = NSLocalizedString("New Location", comment: "New Location title")
        let secondLineMsg = NSLocalizedString("The latitude must be a number between -90 and 90 and the longitude between -180 and 180", comment: "Explanation for new location")
        let saveBtnTitle = NSLocalizedString("Save", comment: "Save button")
        
        let alert = UIAlertController(title: titleMsg, message: secondLineMsg, preferredStyle: UIAlertController.Style.alert )
        let save = UIAlertAction(title: saveBtnTitle, style: .default) { [weak self] _ in
            self?.addLocation(alert)
        }
        alert.addTextField { textField in
            textField.placeholder = NSLocalizedString("Enter latitude", comment: "Enter latitude placeholder")
        }
        alert.addTextField { textField in
            textField.placeholder = NSLocalizedString("Enter longitude", comment: "Enter longitude placeholder")
        }
        alert.addTextField { textField in
            textField.placeholder = NSLocalizedString("Enter the name", comment: "Enter the name of location placeholder")
        }
        alert.addAction(save)
        alert.addAction(UIAlertAction(title: NSLocalizedString("Cancel", comment: "Cancel button"), style: .default) { _ in })
        present(alert, animated:true, completion: nil)
    }
    
    private func addLocation(_ alert: UIAlertController) {
        guard let textFields = alert.textFields,
            let latitudeText = textFields.first?.text
            else { return }
        if latitudeText.count == 0 {
            debugPrint("latitude is empty")
            return
        }
        guard let longitudeText = textFields[safeIndex: 1]?.text else { return }
        if longitudeText.count == 0 {
            debugPrint("longitude is empty")
            return
        }
        let location = Location(name: textFields[safeIndex: 2]?.text,
                                lat: Decimal(string: latitudeText) ?? 0,
                                lon: Decimal(string: longitudeText) ?? 0)
        delegate?.didAddLocation(location)
    }
}

extension LocationsCollectionViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: Constants.cellWidth(in: self.view), height: flowLayout?.itemSize.height ?? 0)
    }
}

extension LocationsCollectionViewController: LocationListViewModelUpdateDelegate {
    
    func didModelUpdated(_ viewModel: LocationListViewModel) {
        self.viewModel = viewModel
        collectionView.reloadData()
    }
}
