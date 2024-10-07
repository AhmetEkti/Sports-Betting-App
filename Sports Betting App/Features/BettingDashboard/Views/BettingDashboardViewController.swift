//
//  BettingDashboardViewController.swift
//  Sports Betting App
//
//  Created by Ahmet Ekti on 10/5/24.
//

import UIKit
import Combine

class BettingDashboardViewController: UIViewController {
    
    private let viewModel = BettingDashboardViewModel()
    private let basketViewModel = BettingBasketViewModel.shared

    private var cancellables = Set<AnyCancellable>()
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    private let refreshControl = UIRefreshControl()
    
    private let emptyStateView = EmptyStateView(frame: .zero)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        bindViewModel()
        bindBasketViewModel()
        viewModel.fetchBettingEvents()
        setupTapGesture()
    }
    
    private func setupUI() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .clear
        tableView.register(UINib(nibName: "BettingEventTableViewCell", bundle: nil), forCellReuseIdentifier: "BettingEventTableViewCell")
        
        refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        refreshControl.tintColor = .white
        tableView.refreshControl = refreshControl
        
        customizeSearchBar()
        searchBar.delegate = self
        
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
    
    private func customizeSearchBar() {
        searchBar.backgroundColor = Theme.Colors.navigationBarBackground
        
        searchBar.searchBarStyle = .minimal
        searchBar.setBackgroundImage(UIImage(), for: .any, barMetrics: .default)
        
        if let textField = searchBar.value(forKey: "searchField") as? UITextField {
            textField.backgroundColor = .white
            textField.textColor = .black
            
            if let placeholderLabel = textField.value(forKey: "placeholderLabel") as? UILabel {
                placeholderLabel.textColor = .darkGray
            }
        }
        
        UIBarButtonItem.appearance(whenContainedInInstancesOf: [UISearchBar.self]).setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.black], for: .normal)
    }
    
    private func setupTapGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
    
    private func bindViewModel() {
        viewModel.$filteredBettingEvents
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.tableView.reloadData()
                self?.refreshControl.endRefreshing()
                
            }
            .store(in: &cancellables)
        
        viewModel.$errorMessage
            .receive(on: DispatchQueue.main)
            .sink { [weak self] errorMessage in
                if let errorMessage = errorMessage {
                    self?.showAlert(message: errorMessage)
                }
                self?.refreshControl.endRefreshing()
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
        basketViewModel.itemRemovedPublisher
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.tableView.reloadData()
                self?.updateTabBarItem()
            }
            .store(in: &cancellables)
    }
    
    @objc private func refreshData() {
        searchBar.text = nil
        viewModel.fetchBettingEvents()
    }
    
    
    private func updateEmptyState() {
        
        if let searchText = searchBar.text {
            emptyStateView.setMessage("\"\(searchText)\" araması için\nSonuç Bulunamadı.", symbolName: "magnifyingglass")
        }
        
        emptyStateView.isHidden = !viewModel.filteredBettingEvents.isEmpty
    }
    
    private func showAlert(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}

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
                self?.updateTabBarItem()
                self?.tableView.reloadRows(at: [indexPath], with: .none)
            }
        }
        return cell
    }
    
    private func updateTabBarItem() {
        
        guard let tabBarItem = self.tabBarController?.tabBar.items?[1] else { return }
        
        let totalMatches = basketViewModel.basket.totalMatches
        let totalOdds = basketViewModel.basket.totalOdds
        
        if totalMatches == 0 {
            tabBarItem.title = "0 Maç - 0.0 Oran"
        } else {
            tabBarItem.title = String(format: "%d Maç - %.2f Oran", totalMatches, totalOdds)
        }
    }
}

extension BettingDashboardViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.filterEvents(with: searchText)
        updateEmptyState()
        
        AnalyticsLogger.shared.logSearch(query: searchText)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
}


