//
//  ImageReviewViewController.swift
//  SelfieCaptureFramework
//
//  Created by Omayma Marouf on 12/10/2024.
//

import UIKit

class ImageReviewViewController: UIViewController {
    var image: UIImage?
    weak var delegate: SelfieCaptureDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    func setupUI() {
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFit
        imageView.frame = view.bounds
        view.addSubview(imageView)

        let approveButton = UIButton()
        approveButton.setTitle("Approve", for: .normal)
        approveButton.backgroundColor = .systemGreen
        approveButton.addTarget(self, action: #selector(approveImage), for: .touchUpInside)

        let recaptureButton = UIButton()
        recaptureButton.setTitle("Recapture", for: .normal)
        recaptureButton.backgroundColor = .systemRed
        recaptureButton.addTarget(self, action: #selector(recaptureImage), for: .touchUpInside)

        let stackView = UIStackView(arrangedSubviews: [approveButton, recaptureButton])
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.frame = CGRect(x: 0, y: view.bounds.height - 70, width: view.bounds.width, height: 50)
        view.addSubview(stackView)
    }

    @objc func approveImage() {
        delegate?.didCaptureImage(image: image)
        navigationController?.popViewController(animated: true)
    }

    @objc func recaptureImage() {
        navigationController?.popViewController(animated: true)
    }
}

protocol SelfieCaptureDelegate: AnyObject {
    func didCaptureImage(image: UIImage?)
}
