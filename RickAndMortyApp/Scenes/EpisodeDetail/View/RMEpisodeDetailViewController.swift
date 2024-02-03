//
//  RMEpisodeDetailViewController.swift
//  RickAndMortyApp
//
//  Created by Mikheil Muchaidze on 27.01.24.
//

import UIKit
import Combine

/// View Controller to show details about single episode
final class RMEpisodeDetailViewController: UIViewController {
    // MARK: - Private Properties
    
    private let viewModel: RMEpisodeDetailViewViewModel
    private var collectionView: UICollectionView?
    private let spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .large)
        spinner.hidesWhenStopped = true
        spinner.translatesAutoresizingMaskIntoConstraints = false
        return spinner
    }()
    private var cancellables: Set<AnyCancellable> = []
    
    // MARK: - Init
    
    init(url: URL?) {
        self.viewModel = RMEpisodeDetailViewViewModel(enpointUrl: url)
        super.init(nibName: nil, bundle: nil)
        let collectionVIew = createCollectionView()
        self.collectionView = collectionVIew
    }
    
    required init?(coder: NSCoder) {
        fatalError("Unsuppoerted")
    }
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "Episode"
        viewModel.fetchEpisodeData()
        setupView()
    }
    
    // MARK: - Private Methods
    
    private func setupView() {
        guard let collectionView else { return }
        view.addSubViews(collectionView, spinner)
        spinner.startAnimating()
        registerViewModelListener()
        setupBarButton()
        addConstraints()
        setupCollectionView()
    }
    
    private func registerViewModelListener() {
        viewModel.$dataTuple
            .dropFirst()
            .receive(on: DispatchQueue.main)
            .sink { [weak self] dataSource in
                guard let self else { return }
                view.backgroundColor = .red
                print("update")
                spinner.stopAnimating()
            }
            .store(in: &cancellables)
    }
    
    private func setupBarButton() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .action,
            target: self,
            action: #selector(didTapShare)
        )
    }
    
    private func addConstraints() {
        guard let collectionView else { return }
        NSLayoutConstraint.activate([
            spinner.widthAnchor.constraint(equalToConstant: 100),
            spinner.heightAnchor.constraint(equalToConstant: 100),
            spinner.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            spinner.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            collectionView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            collectionView.leftAnchor.constraint(equalTo: view.leftAnchor),
            collectionView.rightAnchor.constraint(equalTo: view.rightAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor)
        ])
    }
    
    private func setupCollectionView() {
//        collectionView?.delegate = self
//        collectionView?.dataSource = self
    }
    
    private func createCollectionView() -> UICollectionView {
        let layout = UICollectionViewCompositionalLayout { sectionIndex, _ in
            self.createSection(for: sectionIndex)
        }
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.isHidden = true
        collectionView.alpha = 0
        collectionView.translatesAutoresizingMaskIntoConstraints = false
         
        return collectionView
    }
    
    private func createSection(for sectionIndex: Int) -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(
            layoutSize: .init(
                widthDimension: .fractionalWidth(1),
                heightDimension: .fractionalHeight(1)
            )
        )
        let group = NSCollectionLayoutGroup.vertical(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .absolute(100)
            ),
            subitems: [item]
        )
        let section = NSCollectionLayoutSection(group: group)
        return section
    }
    
    private func configure() {
        
    }
    
    // MARK: - ObjC Methods

    @objc
    private func didTapShare() {
        // MARK: - Share character info
    }
}
