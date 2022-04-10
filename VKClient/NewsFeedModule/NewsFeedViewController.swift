//
//  FeedViewController.swift
//  VKClient
//
//  Created by Alex on 30.03.2022.
//

import UIKit

final class NewsFeedViewController: UIViewController {
    
    //MARK: - Private property
    
    private var viewModel: NewsFeedViewModel
    
    private lazy var newsFeedView: NewsFeedView = {
        let view = NewsFeedView()
        return view
    }()
    
    //MARK: - Initialisation
    
    init(viewModel: NewsFeedViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Life cycle
    
    override func loadView() {
        self.view = newsFeedView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Новости"
        navigationController?.hidesBarsOnSwipe = true
        configureTableView()
        viewModel.fetchNews()
        reloadTable()
        updateTable()
    }
}

//MARK: - Private methods

extension NewsFeedViewController {
    private func configureTableView() {
        newsFeedView.newsFeedTableView.delegate = self
        newsFeedView.newsFeedTableView.dataSource = self
        newsFeedView.newsFeedTableView.register(cell: NewsFeedPostTableViewCell.self)
        newsFeedView.newsFeedTableView.register(cell: NewsFeedImageTableViewCell.self)
    }
    
    private func reloadTable() {
        viewModel.reloadTable = { [weak self] in
            guard let self = self else { return }
            self.newsFeedView.newsFeedTableView.reloadData()
        }
    }
    
    private func updateTable() {
        viewModel.updataTable = { [weak self] index in
            guard let self = self else { return }
            self.newsFeedView.newsFeedTableView.performBatchUpdates({
                self.newsFeedView.newsFeedTableView.insertRows(at: index, with: .automatic)
            }, completion: nil)
        }
    }
    
    private func presentDetailViewController(with image: UIImage) {
        let vc = DetailImageViewController(image: image)
        vc.modalPresentationStyle = .custom
        vc.modalTransitionStyle = .crossDissolve
        self.present(vc, animated: true, completion: nil)
    }
}

//MARK: - UITableViewDataSource

extension NewsFeedViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.viewCellModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = viewModel.viewCellModels[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: item.cellIdentifier(), for: indexPath) as! AbstractCell
        cell.configureCell(with: item)
        cell.updateRow = {
            tableView.beginUpdates()
            tableView.endUpdates()
        }

        let imageCell = cell as? NewsFeedImageTableViewCell
        let textCell = cell as? NewsFeedPostTableViewCell
        
        imageCell?.passImage = {[weak self] image in
            guard let self = self else { return }
            self.presentDetailViewController(with: image)
        }
        imageCell?.showPostSavesMessage = { [weak self] in
            guard let self = self else { return }
            self.showToast(message: "Пост сохранен в избранное")
        }
        textCell?.showPostSavesMessage = { [weak self] in
            guard let self = self else { return }
            self.showToast(message: "Пост сохранен в избранное")
        }
        return cell
    }
}

//MARK: - UITableViewDelegate

extension NewsFeedViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row - 3 >= viewModel.viewCellModels.count - 4 {
            viewModel.fetchNextNews()
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let item = viewModel.viewCellModels[indexPath.row].height()
        switch item {
        case .value(let height):
            return CGFloat(height)
        }
    }
}
