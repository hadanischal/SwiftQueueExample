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

class BaseViewController: UIViewController {
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

        uploadButton.rx.tap
            .bind { [weak self] _ in
                self?.viewModel.uploadImage(withModel: self?.imageSelected)
        }.disposed(by: disposeBag)
     }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let navC = segue.destination as? UINavigationController,
            let photosCVC = navC.viewControllers.first as? SelectPhotoCollectionVC else {
                fatalError("Segue destination is not found")
        }
        photosCVC.selectedPhoto.subscribe(onNext: { [weak self] photo in
            DispatchQueue.main.async {
                self?.imageSelected = photo
                self?.updateUI(with: photo.image)
            }

        }).disposed(by: disposeBag)

    }

    private func updateUI(with image: UIImage) {
        self.photoImageView.image = image
        self.uploadButton.isEnabled = true
        uploadButton.alpha = 1
    }
}
