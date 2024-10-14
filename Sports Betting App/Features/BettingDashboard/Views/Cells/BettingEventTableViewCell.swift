//
//  BettingEventTableViewCell.swift
//  Sports Betting App
//
//  Created by Ahmet Ekti on 10/5/24.
//

import UIKit

class BettingEventTableViewCell: UITableViewCell {
    
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var headerViewTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var headerViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var headerViewBottomConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var sportTitleLabel: UILabel!
    @IBOutlet weak var eventTitleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var homeWinView: UIView!
    @IBOutlet weak var drawView: UIView!
    @IBOutlet weak var awayWinView: UIView!
    
    @IBOutlet weak var homeWinOddsLabel: UILabel!
    @IBOutlet weak var drawOddsLabel: UILabel!
    @IBOutlet weak var awayWinOddsLabel: UILabel!
    
    @IBOutlet weak var homeWinLabel: UILabel!
    @IBOutlet weak var drawLabel: UILabel!
    @IBOutlet weak var awayWinLabel: UILabel!
    @IBOutlet weak var oddsStackView: UIStackView!
    
    @IBOutlet weak var eventBodyView: UIView!
    
    private var widthConstraints: [NSLayoutConstraint] = []
    
    var viewModel: BettingEventCellViewModel?
    var addToBasketHandler: ((BettingEvent, Outcome, String) -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
        setupGestures()
    }
    
    private func setupUI() {
        selectionStyle = .none
        eventBodyView.layer.cornerRadius = 8
        
        [homeWinView, drawView, awayWinView].forEach { view in
            view?.layer.cornerRadius = 4
            view?.layer.borderWidth = 1
            view?.layer.borderColor = Theme.Colors.border.cgColor
            view?.clipsToBounds = true
        }
    }
    
    private func setupGestures() {
        let homeWinTap = UITapGestureRecognizer(target: self, action: #selector(homeWinTapped))
        homeWinView.addGestureRecognizer(homeWinTap)
        
        let drawTap = UITapGestureRecognizer(target: self, action: #selector(drawTapped))
        drawView.addGestureRecognizer(drawTap)
        
        let awayWinTap = UITapGestureRecognizer(target: self, action: #selector(awayWinTapped))
        awayWinView.addGestureRecognizer(awayWinTap)
    }
    
    func configure(with viewModel: BettingEventCellViewModel, isSelected: (String) -> Bool) {
        self.viewModel = viewModel
        
        dateLabel.text = viewModel.formattedDate
        sportTitleLabel.text = viewModel.sportTitle
        eventTitleLabel.text = viewModel.eventTitle
        
        let homeWinInfo = viewModel.outcomeInfo(for: .homeWin)
        homeWinView.isHidden = !homeWinInfo.isAvailable
        homeWinOddsLabel.text = homeWinInfo.price
        homeWinLabel.text = homeWinInfo.text
        
        let drawInfo = viewModel.outcomeInfo(for: .draw)
        drawView.isHidden = !drawInfo.isAvailable
        drawOddsLabel.text = drawInfo.price
        drawLabel.text = drawInfo.text
        
        let awayWinInfo = viewModel.outcomeInfo(for: .awayWin)
        awayWinView.isHidden = !awayWinInfo.isAvailable
        awayWinOddsLabel.text = awayWinInfo.price
        awayWinLabel.text = awayWinInfo.text
        
        updateStackViewDistribution()
        
        if viewModel.shouldHighlight {
            headerView.isHidden = true
            headerViewHeightConstraint.priority = .defaultHigh
            headerViewTopConstraint.constant = 0.0
            headerViewBottomConstraint.constant = 0.0
        } else {
            headerView.isHidden = false
            headerViewHeightConstraint.priority = .defaultLow
            headerViewTopConstraint.constant = 8.0
            headerViewBottomConstraint.constant = 4.0
        }

        updateSelectionState(isSelected: isSelected)
    }
    
    private func updateSelectionState(isSelected: (String) -> Bool) {
        updateOutcomeView(homeWinView,oddsLabel: homeWinOddsLabel,textLabel: homeWinLabel, isSelected: isSelected(BettingOutcome.homeWin.code))
        updateOutcomeView(drawView,oddsLabel: drawOddsLabel,textLabel: drawLabel, isSelected: isSelected(BettingOutcome.draw.code))
        updateOutcomeView(awayWinView,oddsLabel: awayWinOddsLabel,textLabel: awayWinLabel, isSelected: isSelected(BettingOutcome.awayWin.code))
    }
    
    private func updateOutcomeView(_ view: UIView, oddsLabel : UILabel, textLabel : UILabel , isSelected: Bool) {
        if isSelected {
            textLabel.backgroundColor = .clear
            oddsLabel.backgroundColor = Theme.Colors.selectedRatio
            
            textLabel.textColor = Theme.Colors.secondaryText
            oddsLabel.textColor = Theme.Colors.secondaryText
            
            view.layer.borderColor = Theme.Colors.selectedRatio.cgColor
        } else {
            textLabel.backgroundColor = Theme.Colors.ratioBackground
            oddsLabel.backgroundColor = .clear
            
            textLabel.textColor = Theme.Colors.primaryText
            oddsLabel.textColor = Theme.Colors.secondaryText
            
            view.layer.borderColor = Theme.Colors.border.cgColor
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        homeWinView.backgroundColor = .clear
        drawView.backgroundColor = .clear
        awayWinView.backgroundColor = .clear
        homeWinView.layer.borderColor = Theme.Colors.border.cgColor
        drawView.layer.borderColor = Theme.Colors.border.cgColor
        awayWinView.layer.borderColor = Theme.Colors.border.cgColor
    }
    
    private func updateStackViewDistribution() {
        let visibleViews = [homeWinView, drawView, awayWinView].filter { !$0.isHidden }
        
        NSLayoutConstraint.deactivate(widthConstraints)
        widthConstraints.removeAll()
        
        if visibleViews.count == 3 {
            oddsStackView.distribution = .fillEqually
        } else {
            oddsStackView.distribution = .fillProportionally
            visibleViews.forEach { view in
                let constraint = view.widthAnchor.constraint(equalTo: oddsStackView.widthAnchor, multiplier: 0.92 / CGFloat(visibleViews.count))
                constraint.isActive = true
                widthConstraints.append(constraint)
            }
        }
    }
    
    @objc private func homeWinTapped() {
        guard let viewModel = viewModel,
              let outcome = viewModel.odds.homeOutcome else { return }
        addToBasketHandler?(viewModel.event, outcome, BettingOutcome.homeWin.code)
    }
    
    @objc private func drawTapped() {
        guard let viewModel = viewModel,
              let outcome = viewModel.odds.drawOutcome else { return }
        addToBasketHandler?(viewModel.event, outcome, BettingOutcome.draw.code)
    }
    
    @objc private func awayWinTapped() {
        guard let viewModel = viewModel,
              let outcome = viewModel.odds.awayOutcome else { return }
        addToBasketHandler?(viewModel.event, outcome, BettingOutcome.awayWin.code)
    }
}
