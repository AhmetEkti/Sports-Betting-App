//
//  BasketItemTableViewCell.swift
//  Sports Betting App
//
//  Created by Ahmet Ekti on 10/6/24.
//

import UIKit

class BasketItemTableViewCell: UITableViewCell {
    
    @IBOutlet weak var eventTitleLabel: UILabel!
    @IBOutlet weak var marketTypeLabel: UILabel!
    @IBOutlet weak var oddsLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var oddsView: UIView!
    @IBOutlet weak var removeButton: UIButton!
    
    var removeHandler: (() -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    func setupUI() {
        oddsView.layer.cornerRadius = 4
        removeButton.addTarget(self, action: #selector(removeButtonTapped), for: .touchUpInside)
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    @objc private func removeButtonTapped() {
        removeHandler?()
    }
    
    func configure(with item: BasketItem, removeHandler: @escaping () -> Void) {
        self.selectionStyle = .none
        self.removeHandler = removeHandler
        
        eventTitleLabel.text = "\(item.event.homeTeam) - \(item.event.awayTeam)"
        marketTypeLabel.text = item.marketType
        oddsLabel.text = String(format: "%.2f", item.selectedOutcome.price)
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        if let date = item.event.commenceTimeDate {
            dateLabel.text = "Bugün \(dateFormatter.string(from: date))"
        } else {
            dateLabel.text = "Bugün 00:00"
        }
    }
    
}
