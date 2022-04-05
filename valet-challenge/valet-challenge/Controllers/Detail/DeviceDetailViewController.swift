//
//  DeviceDetailViewController.swift
//  valet-challenge
//
//  Created by Luiz Felipe Aires Soares on 2022-04-04.
//

import UIKit

protocol DeviceDetailVCProtocol: AnyObject {
    
    init(viewModel: DeviceDetailViewModelProtocol)
    
    func showDevice()
    
}

class DeviceDetailViewController: UIViewController, DeviceDetailVCProtocol {

    // MARK: - Properties/Variables
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        return stackView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .boldSystemFont(ofSize: 16)
        return label
    }()
    
    private lazy var typeLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 14.0)
        return label
    }()
    
    private lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 14.0)
        return label
    }()
    
    private lazy var descLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = .italicSystemFont(ofSize: 14.0)
        return label
    }()
    
    private let viewModel: DeviceDetailViewModelProtocol
    
    // MARK: - Init
    
    required init(viewModel: DeviceDetailViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = viewModel.device.title
        
        view.backgroundColor = .white
        
        setupSubviews()
        setupImageViewConstraints()
        setupStackViewConstraints()
        
        viewModel.assignView(self)
    }
    
    // MARK: - Protocol Functions
    
    func showDevice() {
        imageView.downloadImage(viewModel.device.imageUrl, placeholder: UIImage(systemName: "square.dashed"))
        titleLabel.text = viewModel.device.title
        typeLabel.text = viewModel.device.type
        priceLabel.text = "\(viewModel.device.currency) \(viewModel.device.price)"
        descLabel.text = viewModel.device.desc
    }
    
    // MARK: - Private functions
    
    private func setupSubviews() {
        view.addSubview(imageView)
        view.addSubview(stackView)
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(typeLabel)
        stackView.addArrangedSubview(priceLabel)
        stackView.addArrangedSubview(descLabel)
    }
    
    private func setupImageViewConstraints() {
        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            imageView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.32),
            imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor, multiplier: 1)
        ])
    }
    
    private func setupStackViewConstraints() {
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16)
        ])
    }

}
