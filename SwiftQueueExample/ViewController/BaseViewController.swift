//
//  BaseViewController.swift
//  SwiftQueueExample
//
//  Created by Nischal Hada on 6/29/19.
//  Copyright © 2019 NischalHada. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

final class BaseViewController: UIViewController {
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var uploadButton: UIButton!
    let disposeBag = DisposeBag()
    private var imageSelected: SelectPhotoModel!
    var viewModel: BaseViewModelProtocol!

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = BaseViewModel()
        uploadButton.isEnabled = false
        uploadButton.alpha = 0.4

        self.viewModel.imageAdded
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] _ in
                 print("**** added In Queue ****")
                self?.showAlert(title: "Added in queue", message: "added in queue successfully")
            })
            .disposed(by: disposeBag)

    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let navC = segue.destination as? UINavigationController,
            let photosCVC = navC.viewControllers.first as? SelectPhotoCollectionVC else {
                fatalError("Segue destination is not found")
        }
        photosCVC.selectedPhoto
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] photo in
                self?.imageSelected = photo
                self?.updateUI(with: photo.image)
            })
            .disposed(by: disposeBag)

    }

    private func updateUI(with image: UIImage) {
        self.photoImageView.image = image
        self.uploadButton.isEnabled = true
        uploadButton.alpha = 1
    }

    @IBAction func uploadImage(_ sender: Any) {
        viewModel.addInQueue(withModel: imageSelected)
    }

}
