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
                self?.collectionView.reloadData()
            }).disposed(by: disposeBag)
        viewModel.photoCameraStatus
            .observeOn(MainScheduler.instance)
            .flatMap { [weak self] _ -> Observable<Int> in
                return self?.alertPhotoAccessNeeded() ?? Observable.empty()
        }.subscribe(onNext: { index in
            print ("index: \(index)")
            if index == 0 {
                let settingsAppURL = URL(string: UIApplication.openSettingsURLString)!
                UIApplication.shared.open(settingsAppURL)
            }
            self.dismiss(animated: true)
        }).disposed(by: disposeBag)

        viewModel.handelAuthorizationStatus()
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
        let cell = collectionView.dequeueReusableCell(for: indexPath) as PhotoCollectionCell
        viewModel.getDisplayImage(withModel: self.imageList[indexPath.row])
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { model in
                cell.photoImageView.image = model.image
            }, onError: { error in
                print("on error ")
                print(error)
            }).disposed(by: cell.disposeBagCell)
        return cell
    }
}

extension SelectPhotoCollectionVC {
    // MARK: - Alert Photo Access Needed
    private func alertPhotoAccessNeeded() -> Observable<Int> {
        let appName = Bundle.main.displayName ?? "This app"
        let actions = [AlertAction(title: "Settings", type: 0, style: .default),
                       AlertAction(title: "Cancel", type: 1, style: .destructive)]

        return self.alert(title: "This feature requires photo access",
                          message: "In iPhone settings, tap \(appName) and turn on Photos",
                          actions: actions,
                          viewController: self)
    }

}
