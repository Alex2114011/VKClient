//
//  NewsFeedTavleViewCellView.swift
//  VKClient
//
//  Created by Alex on 02.04.2022.
//

import UIKit

final class CustomTextPostTableCellView: UIView {

    //MARK: - Public property

    lazy var rootContentView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBackground
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var groupImage: UIImageView = {
        let image = UIImageView()
        image.layer.cornerRadius = 25
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()

    lazy var groupName: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 13, weight: .regular)
        label.textColor = UIColor(named: CustomColors.textColor.rawValue)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    lazy var contextButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "note.text.badge.plus"), for: .normal)
        button.tintColor = UIColor(named: CustomColors.activeElements.rawValue)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    lazy var postTextView: UITextView = {
        let textView = UITextView()
        textView.textContainerInset = UIEdgeInsets.zero
        textView.textContainer.lineFragmentPadding = 0
        textView.dataDetectorTypes = .link
        textView.scrollsToTop = false
        textView.isEditable = false
        textView.isSelectable = true
        textView.isScrollEnabled = false
        textView.font = .systemFont(ofSize: 14, weight: .regular)
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()

    lazy var moreButton: UIButton = {
        let button = UIButton(type: .system)
        button.titleLabel?.font = .systemFont(ofSize: 14, weight: .regular)
        button.setTitle("Показать полностью...", for: .normal)
        button.tintColor = UIColor(named: CustomColors.activeElements.rawValue)
        button.isHidden = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    lazy var likesButton: CustomFiledButton = {
        let button = CustomFiledButton(frame: .zero, imageName: .heart, count: "")
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    lazy var comentsButton: CustomFiledButton = {
        let button = CustomFiledButton(frame: .zero, imageName: .comment, count: "")
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    lazy var viewsButton: CustomFiledButton = {
        let button = CustomFiledButton(frame: .zero, imageName: .views, count: "")
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    //MARK: - Initialisation

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: - Private methods

extension CustomTextPostTableCellView {
    private func setupUI() {
        addSubview(rootContentView)
        rootContentView.addSubviews([groupImage,
                                     groupName,
                                     dateLabel,
                                     contextButton,
                                     postTextView,
                                     moreButton,
                                     likesButton,
                                     comentsButton,
                                     viewsButton])

        NSLayoutConstraint.activate([rootContentView.topAnchor.constraint(equalTo: topAnchor),
                                     rootContentView.leadingAnchor.constraint(equalTo: leadingAnchor),
                                     rootContentView.trailingAnchor.constraint(equalTo: trailingAnchor),
                                     rootContentView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20),

                                     groupImage.topAnchor.constraint(equalTo: rootContentView.topAnchor, constant: 20),
                                     groupImage.leadingAnchor.constraint(equalTo: rootContentView.leadingAnchor, constant: 20),
                                     groupImage.widthAnchor.constraint(equalToConstant: 50),
                                     groupImage.heightAnchor.constraint(equalTo: groupImage.widthAnchor),

                                     groupName.topAnchor.constraint(equalTo: groupImage.topAnchor),
                                     groupName.leadingAnchor.constraint(equalTo: groupImage.trailingAnchor, constant: 10),
                                     groupName.trailingAnchor.constraint(equalTo: contextButton.leadingAnchor, constant: -10),

                                     contextButton.topAnchor.constraint(equalTo: rootContentView.topAnchor, constant: 20),
                                     contextButton.trailingAnchor.constraint(equalTo: rootContentView.trailingAnchor, constant: -20),
                                     contextButton.heightAnchor.constraint(equalToConstant: 25),
                                     contextButton.widthAnchor.constraint(equalTo: contextButton.heightAnchor),

                                     dateLabel.topAnchor.constraint(equalTo: groupName.bottomAnchor, constant: 6),
                                     dateLabel.leadingAnchor.constraint(equalTo: groupName.leadingAnchor),
                                     dateLabel.trailingAnchor.constraint(equalTo: groupName.trailingAnchor),

                                     postTextView.topAnchor.constraint(equalTo: groupImage.bottomAnchor, constant: 10),
                                     postTextView.leadingAnchor.constraint(equalTo: rootContentView.leadingAnchor, constant: 20),
                                     postTextView.trailingAnchor.constraint(equalTo: rootContentView.trailingAnchor, constant: -20),

                                     moreButton.topAnchor.constraint(equalTo: postTextView.bottomAnchor, constant: 10),
                                     moreButton.leadingAnchor.constraint(equalTo: rootContentView.leadingAnchor, constant: 20),
                                     moreButton.heightAnchor.constraint(equalToConstant: 20),

                                     likesButton.leadingAnchor.constraint(equalTo: rootContentView.leadingAnchor, constant: 20),
                                     likesButton.topAnchor.constraint(equalTo: moreButton.bottomAnchor, constant: 10),
                                     likesButton.bottomAnchor.constraint(lessThanOrEqualTo: rootContentView.bottomAnchor, constant: -20),

                                     comentsButton.leadingAnchor.constraint(equalTo: likesButton.trailingAnchor, constant: 10),
                                     comentsButton.topAnchor.constraint(equalTo: likesButton.topAnchor),
                                     comentsButton.bottomAnchor.constraint(lessThanOrEqualTo: rootContentView.bottomAnchor, constant: -20),

                                     viewsButton.topAnchor.constraint(equalTo: comentsButton.topAnchor),
                                     viewsButton.trailingAnchor.constraint(equalTo: rootContentView.trailingAnchor, constant: -20),
                                     viewsButton.bottomAnchor.constraint(lessThanOrEqualTo: rootContentView.bottomAnchor, constant: -20)])
    }
}
