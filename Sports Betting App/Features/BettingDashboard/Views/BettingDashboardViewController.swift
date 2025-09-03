//
//  BettingDashboardViewController.swift
//  Sports Betting App
//
//  Created by Ahmet Ekti on 10/5/24.
//

import UIKit
import Combine

class BettingDashboardViewController: UIViewController {
    
    // MARK: - Properties
    
    private let viewModel = BettingDashboardViewModel()
    private let basketViewModel = BettingBasketViewModel.shared
    
    private var cancellables = Set<AnyCancellable>()
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    private let refreshControl = UIRefreshControl()
    
    private let emptyStateView = EmptyStateView(frame: .zero)
    
    // MARK: - Lifecycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        bindViewModel()
        bindBasketViewModel()
        viewModel.fetchBettingEvents()
    }
    
    // MARK: - UI Setup
    
    private func setupUI() {
        setupTabbar()
        setupTableView()
        setupRefreshControl()
        setupSearchBar()
        setupEmptyStateView()
        setupKeyboardDismissal()
    }
    
    func setupTabbar() {
        guard let tabBarItem = self.tabBarController?.tabBar.items?[0] else { return }
        tabBarItem.title = L10n.Tabbar.bettingList.localized
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .clear
        tableView.register(UINib(nibName: "BettingEventTableViewCell", bundle: nil), forCellReuseIdentifier: "BettingEventTableViewCell")
    }
    
    private func setupRefreshControl() {
        refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        refreshControl.tintColor = .white
        tableView.refreshControl = refreshControl
    }
    
    private func setupSearchBar() {
        customizeSearchBar()
        searchBar.delegate = self
        searchBar.placeholder = L10n.BettingDashboard.searchPlaceholderText.localized
    }
    
    private func customizeSearchBar() {
        if let textField = searchBar.value(forKey: "searchField") as? UITextField {
            textField.backgroundColor = .white
            textField.textColor = .black
            
            if let placeholderLabel = textField.value(forKey: "placeholderLabel") as? UILabel {
                placeholderLabel.textColor = .darkGray
            }
        }
    }
    
    private func setupEmptyStateView() {
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
    
    private func setupKeyboardDismissal() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
    }
    
    // MARK: - Binding
    
    private func bindViewModel() {
        viewModel.$filteredBettingEvents
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.tableView.reloadData()
            }
            .store(in: &cancellables)
        
        viewModel.$errorMessage
            .receive(on: DispatchQueue.main)
            .sink { [weak self] errorMessage in
                if let errorMessage = errorMessage {
                    self?.showAlert(message: errorMessage)
                }
            }
            .store(in: &cancellables)
        
        viewModel.$isLoading
            .receive(on: DispatchQueue.main)
            .sink { [weak self] isLoading in
                if isLoading {
                    self?.refreshControl.beginRefreshing()
                } else {
                    self?.refreshControl.endRefreshing()
                }
            }
            .store(in: &cancellables)
    }
    
    private func bindBasketViewModel() {
        basketViewModel.basket.$items
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.tableView.reloadData()
                self?.updateTabBarItem()
            }
            .store(in: &cancellables)
    }
    
    // MARK: - Helper Methods
    
    @objc private func refreshData() {
        searchBar.text = nil
        viewModel.fetchBettingEvents()
    }
    
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
    
    private func updateEmptyState() {
        if let searchText = searchBar.text {
            emptyStateView.setMessage(L10n.BettingDashboard.noMatchesFound(searchText), image: Theme.Images.magnifyingglass)
        }
        
        emptyStateView.isHidden = !viewModel.filteredBettingEvents.isEmpty
    }
    
    private func showAlert(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
    
    private func updateTabBarItem() {
        guard let tabBarItem = self.tabBarController?.tabBar.items?[1] else { return }
        
        let totalMatches = basketViewModel.basket.totalMatches
        let totalOdds = basketViewModel.basket.totalOdds
        
        if totalMatches == 0 {
            tabBarItem.title = L10n.Tabbar.basketList(0, 0.0)
        } else {
            tabBarItem.title =  L10n.Tabbar.basketList(totalMatches, totalOdds)
        }
    }
}

// MARK: - UITableViewDataSource, UITableViewDelegate

extension BettingDashboardViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.filteredBettingEvents.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "BettingEventTableViewCell", for: indexPath) as? BettingEventTableViewCell else {
            return UITableViewCell()
        }
        
        let cellViewModel = viewModel.filteredBettingEvents[indexPath.row]
        
        cell.configure(with: cellViewModel) { [weak self] marketType in
            guard let self = self else { return false }
            return self.basketViewModel.isOutcomeSelected(event: cellViewModel.event, marketType: marketType)
        }
        
        cell.addToBasketHandler = { [weak self] (event, outcome, marketType) in
            DispatchQueue.main.async {
                self?.basketViewModel.addToBasket(event: event, outcome: outcome, marketType: marketType)
            }
        }
        return cell
    }
}

// MARK: - UISearchBarDelegate

extension BettingDashboardViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.filterEvents(with: searchText)
        updateEmptyState()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let searchText = searchBar.text, searchText != "" {
            AnalyticsLogger.shared.logSearch(query: searchText)
        }
        searchBar.resignFirstResponder()
    }
}
