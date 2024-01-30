//
//  RMEpisodesListViewController.swift
//  RickAndMortyApp
//
//  Created by Mikheil Muchaidze on 13.01.24.
//

import UIKit

/// Controller to show and search episodes
final class RMEpisodesListViewController: UIViewController {
    // MARK: - Private Properties
    
    private let viewModel = RMEpisodesListViewControllerViewModel()
    private let spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .large)
        spinner.hidesWhenStopped = true
        spinner.translatesAutoresizingMaskIntoConstraints = false
        return spinner
    }()
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(
            top: 0,
            left: 10,
            bottom: 10,
            right: 10
        )
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.isHidden = true
        collectionView.alpha = 0
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(
            RMCharacterEpisodeCollectionViewCell.self,
            forCellWithReuseIdentifier: RMCharacterEpisodeCollectionViewCell.cellIdentifier
        )
        collectionView.register(
            RMFooterLoadingCollectionReusableView.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter,
            withReuseIdentifier: RMFooterLoadingCollectionReusableView.cellIdentifier
        )
        return collectionView
    }()
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "Episodes"
        navigationItem.largeTitleDisplayMode = .never
        setupView()
        viewModel.fetchEpisodes()
    }
    
    // MARK: - Private Methods
    
    private func setupView() {
        view.addSubViews(collectionView, spinner)
        registerViewModelListener()
        addConstraints()
        setupCollectionView()
        addSearchButton()
        spinner.startAnimating()
    }
    
    private func addConstraints() {
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
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    private func registerViewModelListener() {
        viewModel.registerForData { [weak self] updateModel in
            guard let self else { return }
            switch updateModel {
            case .initialLoad:
                didLoadInitialEpisodes()
            case .paginationLoad(let index):
                didLoadMoreEpisodes(with: index)
            }
        }
    }
    
    private func navigateToEpisodeDetailWith(episode: RMEpisode) {
        let episodeDetailVC = RMEpisodeDetailViewController(url: URL(string: episode.url))
        navigationController?.pushViewController(episodeDetailVC, animated: true)
    }
    
    private func didLoadInitialEpisodes() {
        spinner.stopAnimating()
        collectionView.isHidden = false
        collectionView.reloadData() // Initial fetch
        UIView.animate(withDuration: 0.4) {
            self.collectionView.alpha = 1
        }
    }
    
    private func didLoadMoreEpisodes(with newIndexPaths: [IndexPath]) {
        collectionView.insertItems(at: newIndexPaths)
    }
}

// MARK: - UICollectionViewDataSource & general cell deqeue

extension RMEpisodesListViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.getCellCount()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: RMCharacterEpisodeCollectionViewCell.cellIdentifier,
            for: indexPath
        ) as? RMCharacterEpisodeCollectionViewCell else {
            fatalError("Unsupported cell")
        }
        cell.configure(viewModel.getCellViewModelForConfiguration(with: indexPath.row))
        return cell
    }
}

// MARK: - CollectionView footer cell deqeue

extension RMEpisodesListViewController {
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard kind == UICollectionView.elementKindSectionFooter, let footer = collectionView.dequeueReusableSupplementaryView(
            ofKind: kind,
            withReuseIdentifier: RMFooterLoadingCollectionReusableView.cellIdentifier,
            for: indexPath
        ) as? RMFooterLoadingCollectionReusableView else {
            fatalError("Unsupported")
        }
        
        footer.startAnimating()
        return footer
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        guard viewModel.getShouldShowLoadMoreIndicatorValue() else { return .zero }
        
        return CGSizeMake(collectionView.frame.width, 100)
    }
}

// MARK: - UICollectionViewDelegate, UICollectionViewDelegateFlowLayout

extension RMEpisodesListViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let bounds = UIScreen.main.bounds
        let width = (bounds.width-30)
        return CGSize(
            width: width,
            height: width * 0.3
        )
    }
}

// MARK: - UIScrollViewDelegate

extension RMEpisodesListViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard viewModel.shouldShowLoadMoreIndicator,
              !viewModel.isLoadingMore,
              let nextUrlString = viewModel.getApiInfoNextString(),
              let url = URL(string: nextUrlString)
        else { return }
        
        Timer.scheduledTimer(withTimeInterval: 0.1, repeats: false) { [weak self] t in
            guard let self else { return }
            
            let offset = scrollView.contentOffset.y
            let totalContentHeight = scrollView.contentSize.height
            let totalScrollViewHeight = scrollView.frame.size.height
            
            if offset >= (totalContentHeight - totalScrollViewHeight - 120) {
                viewModel.fetchAdditionalEpisodes(url: url)
            }
            t.invalidate()
        }
    }
}

// MARK: - CollectionView didSelect

extension RMEpisodesListViewController {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        navigateToEpisodeDetailWith(episode: viewModel.getSelectedCharacter(with: indexPath.row))
    }
}
