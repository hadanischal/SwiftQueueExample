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

    @IBOutlet weak var cancelButton: UIBarButtonItem!

    var viewModel: SelectPhotoViewModelProtocol!
    private var imageList = [ImageModel]()

    private let selectedPhotoSubject = PublishSubject<SelectPhotoModel>()
    var selectedPhoto: Observable<SelectPhotoModel> {
        return selectedPhotoSubject.asObservable()
    }

    private let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = SelectPhotoViewModel()

        self.cancelButton.rx.tap
            .subscribe(onNext: { [weak self] _ in
                self?.dismiss(animated: true)
            }).disposed(by: disposeBag)

        viewModel.imageList
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] image in
                self?.imageList = image
                DispatchQueue.main.async {
                    self?.collectionView.reloadData()
                }
            }).disposed(by: disposeBag)
        viewModel.fetchImage()
    }

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.imageList.count
    }

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.getSelectedImage(withModel: self.imageList[indexPath.row])
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] model in
                self?.selectedPhotoSubject.onNext(model)
                self?.dismiss(animated: true, completion: nil)
                }, onError: { error in
                    print("on error ")
                    print(error)
            }).disposed(by: disposeBag)
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCollectionCell", for: indexPath) as? PhotoCollectionCell else {
            fatalError("PhotoCollectionCell is not found")
        }
        cell.backgroundColor = UIColor.lightGray
        viewModel.getDisplayImage(withModel: self.imageList[indexPath.row])
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { model in
                print("model:", model)
                DispatchQueue.main.async {
                    cell.photoImageView.image = model.image
                }
            }, onError: { error in
                print("on error ")
                print(error)
            }).disposed(by: disposeBag)
        return cell
    }
}
