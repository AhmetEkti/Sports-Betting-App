//
//  BasketItemTableViewCell.swift
//  Sports Betting App
//
//  Created by Ahmet Ekti on 10/6/24.
//

import UIKit

class BasketItemTableViewCell: UITableViewCell {
    
    // MARK: - Outlets
    
    @IBOutlet weak var eventTitleLabel: UILabel!
    @IBOutlet weak var marketTypeLabel: UILabel!
    @IBOutlet weak var oddsLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var oddsView: UIView!
    @IBOutlet weak var removeButton: UIButton!
    @IBOutlet weak var matchResultLabel: UILabel!
    
    // MARK: - Properties
    
    var removeHandler: (() -> Void)?
    private var viewModel: BasketItemCellViewModel?
    
    // MARK: - Lifecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Custom selection handling can be added here if needed
    }
    
    // MARK: - Setup
    
    private func setupUI() {
        configureOddsView()
        configureRemoveButton()
        configureSelectionStyle()
    }
    
    private func configureOddsView() {
        oddsView.layer.cornerRadius = 4
    }
    
    private func configureRemoveButton() {
        removeButton.addTarget(self, action: #selector(removeButtonTapped), for: .touchUpInside)
    }
    
    private func configureSelectionStyle() {
        selectionStyle = .none
    }
    
    // MARK: - Configuration
    
    func configure(with viewModel: BasketItemCellViewModel, removeHandler: @escaping () -> Void) {
        self.viewModel = viewModel
        self.removeHandler = removeHandler
        
        updateUI()
    }
    
    private func updateUI() {
        guard let viewModel = viewModel else { return }
        
        eventTitleLabel.text = viewModel.eventTitle
        marketTypeLabel.text = viewModel.marketType
        oddsLabel.text = viewModel.odds
        dateLabel.text = viewModel.date
        matchResultLabel.text = viewModel.matchResult
    }
    
    // MARK: - Actions
    
    @objc private func removeButtonTapped() {
        removeHandler?()
    }
}
