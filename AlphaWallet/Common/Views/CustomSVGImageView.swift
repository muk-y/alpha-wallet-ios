//
//  CustomSVGImageView.swift
//  AlphaWallet
//
//  Created by Mukesh Shakya on 30/12/2023.
//

import UIKit
import SVGKit
import Combine

class SVGImageView: UIImageView {
    
    // MARK: Properties
    private var cancellables = Set<AnyCancellable>()
    private var activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .medium)
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.hidesWhenStopped = true
        return indicator
    }()
    
    // MARK: Initializers
    init() {
        super.init(frame: .zero)
        prepareLayout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        prepareLayout()
    }
    
    // MARK: Other functions
    private func prepareLayout() {
        addSubview(activityIndicator)
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
    
    func loadSVGImage(url: String?, fallbackURL: String?, placeholderImage: UIImage) {
        showLoadingIndicator()
        if let primaryURLString = url, let primaryURL = URL(string: primaryURLString) {
            loadImage(from: primaryURL)
                .replaceError(with: nil)
                .sink { [weak self] image in
                    self?.hideLoadingIndicator()
                    if let image = image {
                        self?.image = image
                    } else {
                        self?.loadFallbackImage(fallbackURL, placeholderImage)
                    }
                }
                .store(in: &cancellables)
        } else {
            hideLoadingIndicator()
            loadFallbackImage(fallbackURL, placeholderImage)
        }
    }
    
    // MARK: Private Methods
    private func loadImage(from url: URL) -> AnyPublisher<UIImage?, Never> {
        URLSession.shared.dataTaskPublisher(for: url)
            .tryMap { data, _ in
                guard let svgImage = SVGKImage(data: data), let uiImage = svgImage.uiImage else {
                    throw NSError(domain: "Image Loading", code: 1, userInfo: nil)
                }
                return uiImage
            }
            .map { $0 }
            .replaceError(with: nil)
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    private func loadFallbackImage(_ fallbackURLString: String?, _ placeholderImage: UIImage) {
        guard let fallbackURLString = fallbackURLString, let fallbackURL = URL(string: fallbackURLString) else {
            setImageWithPlaceholder(placeholderImage)
            return
        }
        
        showLoadingIndicator()
        loadImage(from: fallbackURL)
            .sink { [weak self] image in
                self?.hideLoadingIndicator()
                if let image = image {
                    self?.image = image
                } else {
                    self?.setImageWithPlaceholder(placeholderImage)
                }
            }
            .store(in: &cancellables)
    }
    
    private func setImageWithPlaceholder(_ placeholderImage: UIImage) {
        image = placeholderImage
    }
    
    private func showLoadingIndicator() {
        activityIndicator.startAnimating()
    }
    
    func hideLoadingIndicator() {
        activityIndicator.stopAnimating()
    }
    
    deinit {
        cancellables.forEach({ $0.cancel() })
    }
    
}
