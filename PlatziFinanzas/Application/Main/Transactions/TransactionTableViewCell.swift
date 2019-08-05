//
//  TransactionTableViewCell.swift
//  DemoApp
//
//  Created by julio vargas bautista on 7/11/19.
//  Copyright © 2019 Platzi. All rights reserved.
//

import UIKit

class TransactionTableViewCell: UITableViewCell {
    @IBOutlet weak var transactionNameLabel: UILabel!
    @IBOutlet weak var TransactionDescriptionLabel: UILabel!
    @IBOutlet weak var transactionValueLabel: UILabel!
    @IBOutlet weak var transactionDateLabel: UILabel!
    @IBOutlet weak var transactionTimeLabel: UILabel!
    
    var viewModel: TransactionViewModel!{
        didSet{
            setUpView()
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func setUpView() {
        transactionNameLabel.text = viewModel.name
        transactionDateLabel.text = viewModel.date
        transactionTimeLabel.text = viewModel.time
        transactionValueLabel.text = viewModel.value
    }

}
