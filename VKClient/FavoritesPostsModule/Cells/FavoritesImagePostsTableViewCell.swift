//
//  FavoritesImagesPostsViewCell.swift
//  VKClient
//
//  Created by Alex on 10.04.2022.
//

import UIKit

final class FavoritesImagePostsTableViewCell: UITableViewCell {

    //MARK: - Callback

    var updateRow:(()->())?
    var passImage:((UIImage)->())?

    //MARK: - Private property

    private var viewModel: FavoritesImagePostsViewModelCell?

    private lazy var customViewCell: CustomImagePostTableCellView = {
        let view = CustomImagePostTableCellView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    //MARK: - Initialisation

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: - Private methods

extension FavoritesImagePostsTableViewCell {

    private func setupUI() {
        selectionStyle = .none
        backgroundColor = .clear
        contentView.addSubview(customViewCell)
        NSLayoutConstraint.activate([customViewCell.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor),
                                     customViewCell.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
                                     customViewCell.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
                                     customViewCell.bottomAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.bottomAnchor)])


        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(presentImage))
        customViewCell.postImageView.addGestureRecognizer(tapRecognizer)
        customViewCell.postImageView.isUserInteractionEnabled = true
    }

    @objc private func didTapMoreButton() {
        guard let viewModel = viewModel, let height = viewModel.heightTextLabel else { return }
        self.viewModel?.change(height: (viewModel.staticCellHeight) + (height - viewModel.staticLabelHeight))
        updateRow?()
        customViewCell.moreButton.isHidden = true
    }

    @objc private func presentImage() {
        guard let image = customViewCell.postImageView.image else { return }
        passImage?(image)
    }
}


//MARK: - AbstractCell

extension FavoritesImagePostsTableViewCell: AbstractCell {

    func configureCell(with object: AbstractModelCell) {
        guard let model = object as? FavoritesImagePostsViewModelCell else { return }
        viewModel = model
        guard let viewModel = viewModel else { return }
        customViewCell.moreButton.isHidden = true
        customViewCell.moreButton.isHidden = viewModel.isMoreButtonHidden

        customViewCell.groupName.text = model.groupName
        customViewCell.postTextView.text = model.textPost
        customViewCell.dateLabel.text = model.datePost
        customViewCell.likesButton.button.setTitle(model.likeCounts, for: .normal)
        customViewCell.comentsButton.button.setTitle(model.commentsCount, for: .normal)
        customViewCell.viewsButton.button.setTitle(model.viewsCount, for: .normal)
        customViewCell.groupImage.image = model.imageGroup
        customViewCell.postImageView.image = model.imagePost

        customViewCell.moreButton.addTarget(self, action: #selector(didTapMoreButton), for: .touchUpInside)
        customViewCell.saveFavoritesButton.isHidden = true
    }
}

