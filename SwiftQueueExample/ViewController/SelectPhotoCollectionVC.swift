//
//  SelectPhotoCollectionVC.swift
//  SwiftQueueExample
//
//  Created by Nischal Hada on 6/29/19.
//  Copyright © 2019 NischalHada. All rights reserved.
//

import UIKit
import Photos
import RxSwift
import RxCocoa

private let reuseIdentifier = "PhotoCollectionCell"

class SelectPhotoCollectionVC: UICollectionViewController {

    private let selectedPhotoSubject = PublishSubject<UIImage>()
    var selectedPhoto: Observable<UIImage> {
        return selectedPhotoSubject.asObservable()
    }

    private var images = [PHAsset]()

    override func viewDidLoad() {
        super.viewDidLoad()
        populatePhotos()
    }

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.images.count
    }

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        let selectedAsset = self.images[indexPath.row]
        PHImageManager.default().requestImage(for: selectedAsset, targetSize: CGSize(width: 300, height: 300), contentMode: .aspectFit, options: nil) { [weak self] image, info in

            guard let info = info else { return }

            let isDegradedImage = info["PHImageResultIsDegradedKey"] as! Bool

            if !isDegradedImage {

                if let image = image {
                    self?.selectedPhotoSubject.onNext(image)
                    self?.dismiss(animated: true, completion: nil)
                }

            }

        }

    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCollectionCell", for: indexPath) as? PhotoCollectionCell else {
            fatalError("PhotoCollectionCell is not found")
        }

        let asset = self.images[indexPath.row]
        let manager = PHImageManager.default()

        manager.requestImage(for: asset, targetSize: CGSize(width: 100, height: 100), contentMode: .aspectFit, options: nil) { image, _ in

            DispatchQueue.main.async {
                cell.photoImageView.image = image
            }

        }

        return cell

    }

    private func populatePhotos() {

        PHPhotoLibrary.requestAuthorization { [weak self] status in

            if status == .authorized {

                // access the photos from photo library
                let assets = PHAsset.fetchAssets(with: PHAssetMediaType.image, options: nil)

                assets.enumerateObjects { (object, _, _) in
                    self?.images.append(object)
                }

                self?.images.reverse()
                DispatchQueue.main.async {
                    self?.collectionView.reloadData()
                }

            }

        }

    }

}
