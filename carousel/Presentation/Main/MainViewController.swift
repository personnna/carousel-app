//
//  MainViewController.swift
//  carousel
//
//  Created by ellkaden on 06/02/26.
//

import UIKit
import Combine

final class MainViewController: UIViewController, UICollectionViewDelegate, UITableViewDelegate {
    
    private let viewModel: MainViewModel
    private var cancellables = Set<AnyCancellable>()
    
    private let scrollView = UIScrollView()
    private let stackView = UIStackView()
    
    private let carousel: UICollectionView
    private let pageControl = UIPageControl()
    let tableView = UITableView()
    
    private var searchWorkItem: DispatchWorkItem?
    
    init(viewModel: MainViewModel) {
        self.viewModel = viewModel
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.sectionInset = .zero
        layout.itemSize = CGSize(
            width: UIScreen.main.bounds.width,
            height: StyleGuide.Carousel.height
        )
        
        carousel = UICollectionView(frame: .zero, collectionViewLayout: layout)
        carousel.showsHorizontalScrollIndicator = false
        carousel.decelerationRate = .fast
        carousel.contentInsetAdjustmentBehavior = .never
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) { fatalError() }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        navigationItem.rightBarButtonItem = makeStatsButton()
        
        setupLayout()
        setupCarousel()
        setupTable()
        setupSearch()
        setupPageControl()
        
        bindViewModel()
    }
}

private extension MainViewController {
    private func setupLayout() {
        view.addSubview(carousel)
        view.addSubview(pageControl)
        view.addSubview(tableView)

        carousel.translatesAutoresizingMaskIntoConstraints = false
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        tableView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            // Carousel
            carousel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            carousel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            carousel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            carousel.heightAnchor.constraint(equalToConstant: StyleGuide.Carousel.height),

            // PageControl
            pageControl.topAnchor.constraint(equalTo: carousel.bottomAnchor, constant: 8),
            pageControl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            pageControl.heightAnchor.constraint(equalToConstant: 20),

            // TableView
            tableView.topAnchor.constraint(equalTo: pageControl.bottomAnchor, constant: 8),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func bindViewModel() {
        
        viewModel.$currentPage
            .receive(on: RunLoop.main)
            .sink { [weak self] _ in
                self?.tableView.reloadData()
            }
            .store(in: &cancellables)
        
        viewModel.$pages
            .receive(on: RunLoop.main)
            .sink { [weak self] pages in
                self?.pageControl.numberOfPages = pages.count
                self?.carousel.reloadData()
                self?.tableView.reloadData()
            }
            .store(in: &cancellables)
    }
    
    private func updateUI() {
        guard tableView.window != nil else { return }
        tableView.reloadData()
    }

    private func setupCarousel() {
        carousel.isPagingEnabled = true
        carousel.showsHorizontalScrollIndicator = false
        carousel.decelerationRate = .fast
        carousel.backgroundColor = .clear

        carousel.dataSource = self
        carousel.delegate = self

        carousel.register(CarouselCell.self,
                          forCellWithReuseIdentifier: CarouselCell.reuseIdentifier)
        
        
        carousel.contentInsetAdjustmentBehavior = .never
    }
    
    private func setupSearch() {
        let search = UISearchController()
        search.searchResultsUpdater = self
        navigationItem.searchController = search
    }
    
    private func setupTable() {
        tableView.dataSource = self
        tableView.register(ItemCell.self, forCellReuseIdentifier: ItemCell.reuseIdentifier)
        tableView.separatorStyle = .none
        tableView.isScrollEnabled = true
    }
    
    private func setupPageControl(){
        pageControl.numberOfPages = viewModel.pages.count
        pageControl.currentPage = 0
        pageControl.pageIndicatorTintColor = .systemGray4
        pageControl.currentPageIndicatorTintColor = .systemBlue
    }

}

extension MainViewController: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        viewModel.pages.count
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: CarouselCell.reuseIdentifier,
            for: indexPath
        ) as? CarouselCell else {
            return UICollectionViewCell()
        }

        cell.configure()
        return cell
    }
    
    private func makeStatsButton() -> UIBarButtonItem {
        let button = UIButton(type: .system)

        let image = UIImage(systemName: "ellipsis")
        button.setImage(image, for: .normal)

        button.tintColor = .white
        button.backgroundColor = .systemBlue
        button.transform = CGAffineTransform(rotationAngle: .pi / 2)

        button.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            button.widthAnchor.constraint(equalToConstant: 37),
            button.heightAnchor.constraint(equalToConstant: 37)
        ])

        button.layer.cornerRadius = 20
        button.layer.masksToBounds = false

        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOpacity = 0.2
        button.layer.shadowRadius = 4
        button.layer.shadowOffset = CGSize(width: 0, height: 2)

        button.addTarget(self, action: #selector(showStats), for: .touchUpInside)

        return UIBarButtonItem(customView: button)
    }


}

extension MainViewController: UIScrollViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let page = Int(scrollView.contentOffset.x / scrollView.frame.width)
        guard viewModel.pages.indices.contains(page) else { return }
        viewModel.currentPage = page
        pageControl.currentPage = page
        updateUI()
    }
}

extension MainViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.filteredItems.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: ItemCell.reuseIdentifier,
            for: indexPath
        ) as? ItemCell else {
            return UITableViewCell()
        }

        cell.configure(with: viewModel.filteredItems[indexPath.row])
        return cell
    }
}

extension MainViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        searchWorkItem?.cancel()

        let text = searchController.searchBar.text ?? ""

        let workItem = DispatchWorkItem { [weak self] in
            self?.viewModel.searchText = text
            self?.updateUI()
        }

        searchWorkItem = workItem

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3, execute: workItem)
    }
    
    @objc private func showStats() {
        let allItems = viewModel.pages.flatMap{ $0 }
        let vc = StatsViewController(
            items: allItems,
            pageIndex: viewModel.currentPage
        )

        vc.modalPresentationStyle = .pageSheet

        if let sheet = vc.sheetPresentationController {
            sheet.detents = [
                .custom { _ in StyleGuide.Stats.detentHeight }
            ]
            sheet.prefersGrabberVisible = true
        }

        present(vc, animated: true)
    }
}

// MARK: - ToolbarButtonContainer

private final class ToolbarButtonContainer: UIView {

    override var intrinsicContentSize: CGSize {
        CGSize(width: StyleGuide.Toolbar.buttonSize, height: StyleGuide.Toolbar.buttonSize)
    }
}
