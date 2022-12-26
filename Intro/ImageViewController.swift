//
//  ImageViewController.swift
//  Intro
//
//  Created by Alief Ahmad Azies on 26/12/22.
//

import UIKit
import Alamofire

let urlString = "https://images.unsplash.com/photo-1588156979401-db3dc31817cb?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=687&q=80"

let urlStringSecond = "https://images.unsplash.com/photo-1606229365485-93a3b8ee0385?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=2574&q=80"

class ImageViewController: UIViewController {
    var imageView: UIImageView?
    var loadingView: UIActivityIndicatorView?
    var downloadButton: UIButton?
    var imageViewSecond: UIImageView?
    var loadingViewSecond: UIActivityIndicatorView?
    
    let viewModel = ViewModel()
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.backgroundColor = .red
        
        setupViews()
    }
    
    func setupViews() {
        
        // MARK: - Image View
        let imageView = UIImageView(frame: .zero)
        view.addSubview(imageView)
        imageView.backgroundColor = .yellow
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        self.imageView = imageView
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            imageView.widthAnchor.constraint(equalTo: imageView.heightAnchor, multiplier: 1, constant: 100)
        ])
        
        // MARK: - Loading View
        let loadingView = UIActivityIndicatorView(frame: .zero)
        view.addSubview(loadingView)
        loadingView.hidesWhenStopped = true
        loadingView.color = .black
        self.loadingView = loadingView
        loadingView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            loadingView.centerXAnchor.constraint(equalTo: imageView.centerXAnchor),
            loadingView.centerYAnchor.constraint(equalTo: imageView.centerYAnchor)
        ])
        
        
        // MARK: - Button
        let button = UIButton(frame: .zero)
        view.addSubview(button)
        button.setTitleColor(.white, for: .normal)
        button.setTitle("Download", for: .normal)
        self.downloadButton = button
        button.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            button.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 24),
            button.centerXAnchor.constraint(equalTo: imageView.centerXAnchor)
        ])
        button.addTarget(self, action: #selector(self.downloadButtonTapped(_:)), for: .touchUpInside)
        
        // MARK: - 2nd Image View
        let imageViewSecond = UIImageView(frame: .zero)
        view.addSubview(imageViewSecond)
        imageViewSecond.backgroundColor = .cyan
        imageViewSecond.contentMode = .scaleAspectFill
        imageViewSecond.clipsToBounds = true
        self.imageViewSecond = imageViewSecond
        imageViewSecond.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageViewSecond.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            imageViewSecond.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            imageViewSecond.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            imageViewSecond.widthAnchor.constraint(equalTo: imageViewSecond.heightAnchor, multiplier: 1, constant: 100),
            imageViewSecond.topAnchor.constraint(equalTo: button.bottomAnchor, constant: 24)
        ])
        
        // MARK: - 2nd Loading View
        let loadingViewSecond = UIActivityIndicatorView(frame: .zero)
        view.addSubview(loadingViewSecond)
        loadingViewSecond.hidesWhenStopped = true
        loadingViewSecond.color = .black
        self.loadingViewSecond = loadingViewSecond
        loadingViewSecond.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            loadingViewSecond.centerXAnchor.constraint(equalTo: imageViewSecond.centerXAnchor),
            loadingViewSecond.centerYAnchor.constraint(equalTo: imageViewSecond.centerYAnchor)
        ])
    }
    
    @objc func downloadButtonTapped(_ sender: Any) {
        downloadImage()
    }
    
    func downloadImage() {
        if let url = URL(string: urlString) {
            loadingView?.startAnimating()
            downloadButton?.setTitle("Downloading", for: .normal)
            downloadButton?.isEnabled = false
            viewModel.downloadImage(url: url) { image in
                self.loadingView?.stopAnimating()
                if let image = image {
                    self.imageView?.image = image
                }
                else {
                    print("1st image error")
                }
            }
        }
        
        if let secondUrl = URL(string: urlStringSecond) {
            loadingViewSecond?.startAnimating()
            viewModel.downloadImage(url: secondUrl) { image in
                if let image = image {
                    self.imageViewSecond?.image = image
                    self.downloadButton?.setTitle("Downloaded", for: .normal)
                    self.downloadButton?.isEnabled = false
                }
                else {
                    self.downloadButton?.setTitle("Download", for: .normal)
                    self.downloadButton?.isEnabled = true
                    }
                }
            }
        }
}
