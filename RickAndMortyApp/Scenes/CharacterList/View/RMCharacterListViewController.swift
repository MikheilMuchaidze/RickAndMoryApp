//
//  RMCharacterListViewController.swift
//  RickAndMortyApp
//
//  Created by Mikheil Muchaidze on 14.01.24.
//

import UIKit

/// View that handles showing  list of characters, loader, etc.
final class RMCharacterListViewController: UIViewController {
    // MARK: - Private Properties
    
    private let viewModel = RMCharacterListViewControllerViewModel()
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
            RMCharacterCollectionViewCell.self,
            forCellWithReuseIdentifier: RMCharacterCollectionViewCell.cellIdentifier
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
        title = "Characters"
        navigationItem.largeTitleDisplayMode = .never
        setupView()
        viewModel.fetchCharacters()
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
                didLoadInitialCharacters()
            case .paginationLoad(let index):
                didLoadMoreCharacters(with: index)
            }
        }
    }
    
    private func navigateToCharacterDetailWith(character: RMCharacter) {
        let viewModel = RMCharacterDetailViewViewModel(character: character)
        let characterDetailVC = RMCharacterDetailViewController(viewModel: viewModel)
        navigationController?.pushViewController(characterDetailVC, animated: true)
    }
    
    private func didLoadInitialCharacters() {
        spinner.stopAnimating()
        collectionView.isHidden = false
        collectionView.reloadData() // Initial fetch
        UIView.animate(withDuration: 0.4) {
            self.collectionView.alpha = 1
        }
    }
    
    private func didLoadMoreCharacters(with newIndexPaths: [IndexPath]) {
        collectionView.insertItems(at: newIndexPaths)
    }
    
    // MARK: - Overriden Methods
    
    override func didTapSearch() {
        let searchVC = RMSearchViewController(config: RMSearchViewController.Config(type: .character))
        navigationController?.pushViewController(searchVC, animated: true)
    }
}

// MARK: - UICollectionViewDataSource & general cell deqeue

extension RMCharacterListViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.getCellCount()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: RMCharacterCollectionViewCell.cellIdentifier,
            for: indexPath
        ) as? RMCharacterCollectionViewCell else {
            fatalError("Unsupported cell")
        }
        cell.configure(viewModel.getCellViewModelForConfiguration(with: indexPath.row))
        return cell
    }
}

// MARK: - CollectionView footer cell deqeue

extension RMCharacterListViewController {
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

extension RMCharacterListViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let bounds = UIScreen.main.bounds
        let width = (bounds.width-30)/2
        return CGSize(
            width: width,
            height: width * 1.5
        )
    }
}

// MARK: - UIScrollViewDelegate

extension RMCharacterListViewController: UIScrollViewDelegate {
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
                viewModel.fetchAdditionalCharacters(url: url)
            }
            t.invalidate()
        }
    }
}

// MARK: - CollectionView didSelect

extension RMCharacterListViewController {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        navigateToCharacterDetailWith(character: viewModel.getSelectedCharacter(with: indexPath.row))
    }
}
