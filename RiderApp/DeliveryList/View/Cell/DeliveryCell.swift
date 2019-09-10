//
//  DeliveryCell.swift
//  RiderApp
//
//  Created by MANISH PATHAK on 9/6/19.
//

import UIKit
import Kingfisher

class DeliveryCell: UITableViewCell {
    var deliveryLabel: UILabel!
    var deliveryImageView: UIImageView!
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        deliveryLabel = UILabel()
        deliveryImageView = UIImageView()
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        initViews()
        setupConstraints()
    }
    
    func initViews() {
        deliveryImageView = UIImageView(frame: .zero)
        deliveryImageView.translatesAutoresizingMaskIntoConstraints = false
        deliveryImageView.contentMode = .scaleToFill
        deliveryImageView.clipsToBounds = true
        deliveryImageView.layer.borderWidth = Constants.AppUI.DeliveryCell.borderWidth
        deliveryImageView.layer.borderColor = Constants.AppUI.DeliveryCell.borderColor
        contentView.addSubview(deliveryImageView)
        
        deliveryLabel = UILabel(frame: .zero)
        deliveryLabel.numberOfLines = Constants.AppUI.DeliveryCell.numberOfLines
        selectionStyle = .none
        deliveryLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(deliveryLabel)
    }
 
    func setupConstraints() {
        deliveryImageView.snp.makeConstraints { (make) -> Void in
            make.leading.equalTo(contentView.snp.leading).offset(Constants.AppUI.DeliveryCell.imgLeading)
            make.width.height.equalTo(Constants.AppUI.DeliveryCell.imgHeight)
            make.centerY.equalTo(contentView.snp.centerY)
        }

        deliveryLabel.snp.makeConstraints { (make) -> Void in
            make.trailing.equalTo(contentView.snp.trailing).inset(Constants.AppUI.DeliveryCell.labelTrailing)
            make.leading.equalTo(deliveryImageView.snp.trailing).offset(Constants.AppUI.DeliveryCell.labelLeading)
            make.top.bottom.greaterThanOrEqualTo(Constants.AppUI.DeliveryCell.labelTop)
            make.height.greaterThanOrEqualTo(Constants.AppUI.DeliveryCell.imgHeight)
            make.centerY.equalTo(contentView.snp.centerY)
        }
    }
    
    func populate(deliveries: [DeliveryModel], indexPath: IndexPath) {
        deliveryLabel.text = deliveries[indexPath.row].getDeliveryText()
        deliveryImageView.kf.setImage(with: deliveries[indexPath.row].getImageUrl(), options: [.transition(ImageTransition.fade(1))])
    }
}
