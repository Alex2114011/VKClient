//
//  FavoritesPostsView.swift
//  VKClient
//
//  Created by Alex on 10.04.2022.
//

import UIKit

final class FavoritesPostsView: UIView {

    //MARK: - Public property

    lazy var favoritesPostsTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .systemGroupedBackground
        return tableView
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

extension FavoritesPostsView {
    private func setupUI() {
        addSubview(favoritesPostsTableView)
        favoritesPostsTableView.separatorStyle = .none
        NSLayoutConstraint.activate([favoritesPostsTableView.topAnchor.constraint(equalTo: topAnchor),
                                     favoritesPostsTableView.leadingAnchor.constraint(equalTo: leadingAnchor),
                                     favoritesPostsTableView.trailingAnchor.constraint(equalTo: trailingAnchor),
                                     favoritesPostsTableView.bottomAnchor.constraint(equalTo: bottomAnchor)])
    }

}
