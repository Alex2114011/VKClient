//
//  FavoritesTextPostsViewCell.swift
//  VKClient
//
//  Created by Alex on 10.04.2022.
//

import UIKit

final class FavoritesTextPostsTableViewCell: UITableViewCell {

    //MARK: - Private property

    private var viewModel: FavoritesTextPostViewModelCell?
    var updateRow:(()->())?

    lazy private var customViewCell: CustomTextPostTableCellView = {
        let view = CustomTextPostTableCellView()
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

extension FavoritesTextPostsTableViewCell {

    private func setupUI() {
        selectionStyle = .none
        backgroundColor = .clear
        contentView.addSubview(customViewCell)
        NSLayoutConstraint.activate([customViewCell.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor),
                                     customViewCell.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
                                     customViewCell.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
                                     customViewCell.bottomAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.bottomAnchor)])
    }

    @objc private func didTapMoreButton() {
        guard let viewModel = viewModel, let height = viewModel.heightTextLabel else { return }
        self.viewModel?.change(height: viewModel.staticCellHeight + (height - viewModel.staticLabelHeight))
        updateRow?()
        customViewCell.moreButton.isHidden = true
    }
}

//MARK: - AbstractCell

extension FavoritesTextPostsTableViewCell: AbstractCell {

    func configureCell(with object: AbstractModelCell) {
        guard let model = object as? FavoritesTextPostViewModelCell else { return }
        viewModel = model
        guard let viewModel = viewModel else { return }

        customViewCell.moreButton.isHidden = true
        customViewCell.moreButton.isHidden = viewModel.isMoreButtonHidden

        customViewCell.groupName.text = viewModel.groupName
        customViewCell.postTextView.text = viewModel.textPost
        customViewCell.dateLabel.text = viewModel.datePost
        customViewCell.likesButton.button.setTitle(viewModel.likeCounts, for: .normal)
        customViewCell.comentsButton.button.setTitle(viewModel.commentsCount, for: .normal)
        customViewCell.viewsButton.button.setTitle(viewModel.viewsCount, for: .normal)
        customViewCell.groupImage.image = viewModel.imageGroup

        customViewCell.moreButton.addTarget(self, action: #selector(didTapMoreButton), for: .touchUpInside)
        
    }
}
