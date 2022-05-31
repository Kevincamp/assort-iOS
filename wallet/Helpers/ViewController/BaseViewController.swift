//
//  BaseViewController.swift
//  wallet
//
//  Created by Kevin Campuzano on 5/3/22.
//

import Foundation
import UIKit

class BaseViewController: UIViewController {
    
    @IBOutlet weak var contentView: UIView!
    
    lazy var progressHUDStackView: UIStackView = {
        let stackView = UIStackView(frame: .zero)
        stackView.axis = .vertical
        stackView.spacing = -7.0
        stackView.isHidden = true
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    lazy var progressHUD: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.color = .darkGray
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        return activityIndicator
    }()
    
    // MARK: - Overrides

    override func loadView() {
        super.loadView()
        setup()
        setupUI()
    }
    
    // MARK: - Public functions

    func showProgressHUD(_ show: Bool) {
        progressHUDStackView.isHidden = !show
        progressHUD.isHidden = !show
        if show {
            progressHUD.startAnimating()
        } else {
            progressHUD.stopAnimating()
        }
    }
    
    // MARK: - Private functions
    
    private func setup() {
        progressHUDStackView.addArrangedSubview(progressHUD)
    }

    private func setupUI() {
        view.addSubview(progressHUDStackView)

        NSLayoutConstraint.activate([
            progressHUDStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            progressHUDStackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            progressHUD.widthAnchor.constraint(equalToConstant: 168),
            progressHUD.heightAnchor.constraint(equalToConstant: 68),
        ])
    }
    
}



// MARK: - BaseViewProtocol

extension BaseViewController: BaseViewProtocol {
    func shouldShowLoader(_ show: Bool) {
        contentView.isHidden = show
        showProgressHUD(show)
    }

    func shouldShowNoInternetView(_ show: Bool) {
        contentView.isHidden = show
    }
}
