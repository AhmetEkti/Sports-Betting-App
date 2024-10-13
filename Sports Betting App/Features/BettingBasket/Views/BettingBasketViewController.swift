//
//  BettingBasketViewController.swift
//  Sports Betting App
//
//  Created by Ahmet Ekti on 10/6/24.
//

import UIKit
import Combine

class BettingBasketViewController: UIViewController {
    
    // MARK: - Properties
    
    @IBOutlet weak var tableView: UITableView!
    
    private let viewModel = BettingBasketViewModel.shared
    private var cancellables = Set<AnyCancellable>()
    private let emptyStateView = EmptyStateView(frame: .zero)
    
    // MARK: - Lifecycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        bindViewModel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
        updateEmptyState()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        AnalyticsLogger.shared.logBasketViewed()
    }
    
    // MARK: - UI Setup
    
    private func setupUI() {
        setupTableView()
        setupEmptyStateView()
    }
    
    func settupTabbar() {
        
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .clear
        tableView.register(UINib(nibName: "BasketItemTableViewCell", bundle: nil), forCellReuseIdentifier: "BasketItemTableViewCell")
    }
    
    private func setupEmptyStateView() {
        emptyStateView.setMessage(L10n.BettingBasket.noBetsFound.localized, image: Theme.Images.ticket)
        tableView.backgroundView = emptyStateView
        emptyStateView.isHidden = true
        
        emptyStateView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            emptyStateView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            emptyStateView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            emptyStateView.widthAnchor.constraint(equalTo: self.view.widthAnchor),
            emptyStateView.heightAnchor.constraint(equalTo: self.view.heightAnchor)
        ])
    }
    
    // MARK: - Binding
    
    private func bindViewModel() {
        viewModel.$basket
            .receive(on: DispatchQueue.main)
            .sink { [weak self] basket in
                guard let self = self else { return }
                self.tableView.reloadData()
                self.updateEmptyState()
            }
            .store(in: &cancellables)
        
        viewModel.itemRemovedPublisher
            .receive(on: DispatchQueue.main)
            .sink { [weak self] in
                guard let self = self else { return }
                self.tableView.reloadData()
                self.updateEmptyState()
            }
            .store(in: &cancellables)
    }
    
    // MARK: - Helper Methods
    
    private func updateEmptyState() {
        emptyStateView.isHidden = !viewModel.basket.items.isEmpty
    }
    
    private func removeItem(at index: Int) {
        viewModel.removeFromBasket(at: index)
    }
}

// MARK: - UITableViewDataSource, UITableViewDelegate

extension BettingBasketViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.basket.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "BasketItemTableViewCell", for: indexPath) as? BasketItemTableViewCell else {
            return UITableViewCell()
        }
        
        let basketItem = viewModel.basket.items[indexPath.row]
        let cellViewModel = BasketItemCellViewModel(basketItem: basketItem)
        
        cell.configure(with: cellViewModel) { [weak self] in
            self?.removeItem(at: indexPath.row)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            removeItem(at: indexPath.row)
        }
    }
    
    func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return L10n.General.remove.localized
    }
}
