//
//  NewsFeedImageTableViewCell.swift
//  VKClient
//
//  Created by Alex on 07.04.2022.
//

import UIKit

final class NewsFeedImageTableViewCell: UITableViewCell {

    //MARK: - Callback

    var updateRow:(()->())?
    var passImage:((UIImage)->())?
    var showPostSavesMessage:(()->())?

    //MARK: - Private property

    private var viewModel: NewsFeedImageTableViewCellModel?

    private lazy var customViewCell: CustomImagePostTableCellView = {
        let view = CustomImagePostTableCellView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    //MARK: - Initialisation

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
        print("init \(self)")
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: - AbstractCell

extension NewsFeedImageTableViewCell: AbstractCell {

    func configureCell(with object: AbstractModelCell) {
        guard let model = object as? NewsFeedImageTableViewCellModel else { return }
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

        if let postImageURL = URL(string: model.imageURLString) {
            let imageLoader = ImageLoader()
            imageLoader.loadImage(by: postImageURL) { [weak self] image in
                guard let self = self else { return }
                self.customViewCell.postImageView.image = image
            }
        }
        customViewCell.moreButton.addTarget(self, action: #selector(didTapMoreButton), for: .touchUpInside)
        customViewCell.saveFavoritesButton.addTarget(self, action: #selector(savePost), for: .touchUpInside)
    }
}

//MARK: - Private methods

extension NewsFeedImageTableViewCell {

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
        self.viewModel?.change(height: (viewModel.staticCellHeight) + (height) - viewModel.staticLabelHeight)
        updateRow?()
        customViewCell.moreButton.isHidden = true
    }

    @objc private func presentImage(){
        guard let image = customViewCell.postImageView.image else { return }
        passImage?(image)
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
        postsModel.imagePost = customViewCell.postImageView.image?.pngData()
        postsModel.imageGroup = customViewCell.groupImage.image?.pngData()
        postsModel.heightTextLabel = Float(viewModel.heightTextLabel ?? 0)
        postsModel.isMoreButtonHidden = viewModel.isMoreButtonHidden

        CoreDataStack.shared.saveContext()
        showPostSavesMessage?()
    }
}
