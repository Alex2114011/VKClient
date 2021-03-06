//
//  NewsFeedTextPostTableViewCell.swift
//  VKClient
//
//  Created by Alex on 02.04.2022.
//

import UIKit

final class NewsFeedPostTableViewCell: UITableViewCell {

    //MARK: - Private property

    private var viewModel: NewsFeedPostTableViewCellModel?
    var updateRow:(()->())?
    var showPostSavesMessage:(()->())?

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

extension NewsFeedPostTableViewCell {

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
        guard let height = viewModel?.heightTextLabel else { return }
        self.viewModel?.change(height: 227.5 + (height - 33.5))
        updateRow?()
        customViewCell.moreButton.isHidden = true
    }
}

//MARK: - AbstractCell

extension NewsFeedPostTableViewCell: AbstractCell {

    func configureCell(with object: AbstractModelCell) {
        guard let model = object as? NewsFeedPostTableViewCellModel else { return }
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

        if let groupImageURL = URL(string: model.imageGroupURLString) {
            let imageLoader = ImageLoader()
            imageLoader.loadImage(by: groupImageURL) { [weak self] image in
                guard let self = self else { return }
                self.customViewCell.groupImage.image = image
            }
        }

        customViewCell.moreButton.addTarget(self, action: #selector(didTapMoreButton), for: .touchUpInside)

        customViewCell.contextButton.addTarget(self, action: #selector(savePost), for: .touchUpInside)
    }

    @objc private func savePost() {
        guard let viewModel = viewModel else { return }
        let postsModel = FavoritesPosts(context: CoreDataStack.shared.managedContext)

        postsModel.staticCellHeight = Float(viewModel.staticCellHeight)
        postsModel.staticLabelHeight = Float(viewModel.staticLabelHeight)
        postsModel.groupName = viewModel.groupName
        postsModel.textPost = viewModel.textPost
        postsModel.datePost = viewModel.datePost
        postsModel.likeCounts = viewModel.likeCounts
        postsModel.commentsCount = viewModel.commentsCount
        postsModel.viewsCount = viewModel.viewsCount
        postsModel.imagePost = nil
        postsModel.imageGroup = customViewCell.groupImage.image?.pngData()
        postsModel.heightTextLabel = Float(viewModel.heightTextLabel ?? 0)
        postsModel.isMoreButtonHidden = viewModel.isMoreButtonHidden

        CoreDataStack.shared.saveContext()
        showPostSavesMessage?()
    }
}
