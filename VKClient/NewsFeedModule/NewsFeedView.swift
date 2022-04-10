//
//  NewsFeedView.swift
//  VKClient
//
//  Created by Alex on 02.04.2022.
//

import Foundation
import UIKit

final class NewsFeedView: UIView {

    //MARK: - Public property

    lazy var newsFeedTableView: UITableView = {
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

extension NewsFeedView {
    private func setupUI() {
        addSubview(newsFeedTableView)
        newsFeedTableView.separatorStyle = .none
        NSLayoutConstraint.activate([newsFeedTableView.topAnchor.constraint(equalTo: topAnchor),
                                     newsFeedTableView.leadingAnchor.constraint(equalTo: leadingAnchor),
                                     newsFeedTableView.trailingAnchor.constraint(equalTo: trailingAnchor),
                                     newsFeedTableView.bottomAnchor.constraint(equalTo: bottomAnchor)])
    }
}
