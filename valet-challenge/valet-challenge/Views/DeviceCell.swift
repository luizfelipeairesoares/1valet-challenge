//
//  DeviceCell.swift
//  valet-challenge
//
//  Created by Luiz Felipe Aires Soares on 2022-03-31.
//

import Foundation
import UIKit

class DeviceCell: UITableViewCell {
    
    lazy var thumbImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // MARK: - CellIdentifier
    
    static let cellId = "DeviceCell"
    
    // MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupSubviews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Configure
    
    func setup(device: Device) {
        titleLabel.text = device.title
        if let imageUrl = device.imageUrl {
            thumbImageView.downloadImage(imageUrl)
        }
    }
    
    // MARK: - Private functions
    
    private func setupSubviews() {
        setupThumbImageViewConstraints()
        setupTitleLabelConstraints()
    }
    
    private func setupThumbImageViewConstraints() {
        addSubview(thumbImageView)
        NSLayoutConstraint.activate([
            thumbImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            thumbImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            thumbImageView.widthAnchor.constraint(equalToConstant: 40),
            thumbImageView.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    private func setupTitleLabelConstraints() {
        addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: thumbImageView.topAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            titleLabel.bottomAnchor.constraint(equalTo: thumbImageView.bottomAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: thumbImageView.trailingAnchor, constant: 8)
        ])
    }
    
}
