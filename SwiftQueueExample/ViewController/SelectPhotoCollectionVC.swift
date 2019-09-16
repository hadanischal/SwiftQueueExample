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

class SelectPhotoCollectionVC: UICollectionViewController {

    @IBOutlet weak var cancelButton: UIBarButtonItem!

    var viewModel: SelectPhotoViewModelProtocol!
    private var imageList = [ImageModel]()

    //Return selected photo to BaseViewcontroller
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
        viewModel.photoCameraStatus
        .asDriver(onErrorJustReturn: .denied)
            .drive(onNext: { [weak self] status in
                print("status:", status)
                self?.alertPhotoAccessNeeded()
            }).disposed(by: disposeBag)

        viewModel.handelAuthorizationStatus()
//        viewModel.fetchImage()
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
        viewModel.getDisplayImage(withModel: self.imageList[indexPath.row])
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { model in
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

extension SelectPhotoCollectionVC {
    // MARK: - Alert Photo Access Needed
    // TODO: Manage Alert properly

    private func alertPhotoAccessNeeded() {
        let settingsAppURL = URL(string: UIApplication.openSettingsURLString)!
        let appName = Bundle.main.displayName ?? "This app"
        self.alert(title: "This feature requires photo access",
                   message: "In iPhone settings, tap \(appName) and turn on Photos",
            actions: [AlertAction(title: "Settings", type: 0, style: .default),
                      AlertAction(title: "Cancel", type: 1, style: .destructive)],
            viewController: self).observeOn(MainScheduler.instance)
            .subscribe(onNext: { index in
                print ("index: \(index)")
                if index == 0 {
                    UIApplication.shared.open(settingsAppURL)
                }
                self.dismiss(animated: true)
            }).disposed(by: disposeBag)
    }

}
