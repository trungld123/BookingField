//
//  ListPitchTableViewCell.swift
//  FinalProject
//
//  Created by Trung Le D. on 9/17/20.
//  Copyright © 2020 Asian Tech Co., Ltd. All rights reserved.
//

import UIKit
import SDWebImage
enum DateFormatType: String {
    // Time
    case time = "HH:mm"
    //Date with hours
    case dateWithTime = "dd-mm-yyyy HH:mm"
    //Date
    case date = "dd-MM-yyyy"
}
protocol ListPitchTableViewCellDelegate: class {
    func bookingButton(cell: ListPitchTableViewCell, id: Int)
    func handleFavoriteTableView( cell: ListPitchTableViewCell, needPerform action: ListPitchTableViewCell.Action)
}

final class ListPitchTableViewCell: UITableViewCell {
    //enum
    enum Action {
        case favorite(isFavorite: Bool)
    }
    // MARK: - IBOutlet
    @IBOutlet weak var namePitch: UILabel!
    @IBOutlet weak var address: UILabel!
    @IBOutlet weak var favoritesButton: UIButton!
    @IBOutlet weak var bookingButton: UIButton!
    @IBOutlet weak var dateBookingLabel: UILabel!
    @IBOutlet weak var imagePitch: UIImageView!
    
    // MARK: - Properties
    weak var delegate: ListPitchTableViewCellDelegate?
    var pitch: [Pitch]?
    var viewModel: ListPitchCellViewModel? {
        didSet {
            updateView()
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        imagePitch.layer.cornerRadius = 15
        namePitch.layer.cornerRadius = 15
        address.layer.cornerRadius = 15
        dateBookingLabel.layer.cornerRadius = 15
    }
    
    // MARK: - Function
    private func updateView() {
        guard let viewModel = viewModel else {
            return
        }
        let imageURl = URL(string: viewModel.imagePitch)
        imagePitch.sd_setImage(with: imageURl)
        namePitch.text = viewModel.name
        address.text = viewModel.addressOwner
        dateBookingLabel.text = viewModel.timeUser
        favoritesButton.isSelected = viewModel.isFavorite
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    @IBAction func favoriteTapped(_ sender: UIButton) {
        if let delegate = delegate {
            delegate.handleFavoriteTableView(cell: self, needPerform: .favorite(isFavorite: favoritesButton.isSelected))
        }
    }
    
    @IBAction func bookingTapped(_ sender: UIButton) {
        guard let viewModel = viewModel else { return }
        if let delegate = delegate {
            delegate.bookingButton(cell: self, id: viewModel.id)
        }
    }
}
