//
//  DetailImageViewController.swift
//  VKClient
//
//  Created by Alex on 08.04.2022.
//

import UIKit

final class DetailImageViewController: UIViewController {

    //MARK: - Private property

    private var centerYAnchor: NSLayoutConstraint?
    private var imageViewHeightConstraint: NSLayoutConstraint?
    private var imageViewWidthConstraint: NSLayoutConstraint?
    private var heightImageValue: CGFloat = 0
    private var widthImageValue: CGFloat = 0
    private var moveValue: CGFloat = 0
    private var image: UIImage

    private lazy var presentImageView: UIImageView = {
        let imageView = UIImageView()
        let panRecognizer = UIPanGestureRecognizer(target: self, action: #selector(moveImage(sender:)))
        imageView.contentMode = .scaleAspectFit
        imageView.addGestureRecognizer(panRecognizer)
        imageView.isUserInteractionEnabled = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    //MARK: - Initialization

    init(image: UIImage) {
        self.image = image
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    //MARK: - Life cicle

    override func viewDidLoad() {
        super.viewDidLoad()
        presentImageView.image = image
        setupUI()
    }
}

//MARK: - Private methods

extension DetailImageViewController {

    @objc private func moveImage(sender: UIPanGestureRecognizer) {
        if sender.state == .began {
            moveValue = sender.translation(in: presentImageView).y
        }

        if sender.state == .changed {
            let gesturePoint = sender.translation(in: presentImageView).y

            centerYAnchor?.constant += gesturePoint - moveValue
            moveValue = gesturePoint
        }

        if sender.state == .ended {
            self.dismiss(animated: false, completion: nil)
            view.alpha = 1
        }
    }

    private func setupUI() {
        view.addSubview(presentImageView)
        view.backgroundColor = .black

        centerYAnchor = NSLayoutConstraint(item: presentImageView,
                                           attribute: .centerY,
                                           relatedBy: .equal,
                                           toItem: view,
                                           attribute: .centerY,
                                           multiplier: 1, constant: moveValue)
        
        guard let centerYAnchor = centerYAnchor  else { return }
        NSLayoutConstraint.activate([presentImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                                     centerYAnchor,
                                     presentImageView.widthAnchor.constraint(lessThanOrEqualTo: view.widthAnchor)
                                    ])
    }
}
