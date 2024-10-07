//
//  BettingBasketViewController.swift
//  Sports Betting App
//
//  Created by Ahmet Ekti on 10/6/24.
//

import UIKit
import Combine

class BettingBasketViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    private let viewModel = BettingBasketViewModel.shared
    private var cancellables = Set<AnyCancellable>()
    private let emptyStateView = EmptyStateView(frame: .zero)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        bindViewModel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
        updateEmptyState()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        AnalyticsLogger.shared.logBasketViewed()
    }
    
    private func setupUI() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .clear
        tableView.register(UINib(nibName: "BasketItemTableViewCell", bundle: nil), forCellReuseIdentifier: "BasketItemTableViewCell")
        
        emptyStateView.setMessage("Kuponunda hiç maç bulunmuyor.", symbolName: "ticket")
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
    
    
    
    private func bindViewModel() {
        viewModel.$basket
            .receive(on: DispatchQueue.main)
            .sink { [weak self] basket in
                guard let self = self else { return }
                print("Basket updated in BettingBasketViewController. Total items: \(basket.items.count)")
                self.tableView.reloadData()
                self.updateEmptyState()
            }
            .store(in: &cancellables)
        
        viewModel.itemRemovedPublisher
            .receive(on: DispatchQueue.main)
            .sink { [weak self] in
                guard let self = self else { return }
                print("Item removed from basket")
                self.tableView.reloadData()
                self.updateEmptyState()
            }
            .store(in: &cancellables)
    }
    
    private func updateEmptyState() {
        emptyStateView.isHidden = !viewModel.basket.items.isEmpty
    }
    
    private func removeItem(at index: Int) {
        viewModel.removeFromBasket(at: index)
    }
}

extension BettingBasketViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let count = viewModel.basket.items.count
        print("numberOfRowsInSection called. Returning count: \(count)")
        return count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "BasketItemTableViewCell", for: indexPath) as? BasketItemTableViewCell else {
            return UITableViewCell()
        }
        
        let basketItem = viewModel.basket.items[indexPath.row]
        cell.configure(with: basketItem) { [weak self] in
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
        return "Sil"
    }
}
