//
//  TechnologyViewController.swift
//  NewsApp
//
//  Created by Кристина Олейник on 03.08.2025.
//

import UIKit


final class TechnologyViewController: UIViewController {
    //MARK: - GUI Variables

    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        
        let width = view.frame.width - 10
        layout.itemSize = CGSize(width: width, height: 180)
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 5
        
        let collectionView = UICollectionView(frame: CGRect(x: 0,
                                                            y: 0,
                                                            width: view.frame.width,
                                                            height: view.frame.height),
                                              collectionViewLayout: layout)
        return collectionView
    }()
    
    //MARK: - Properties
    private var viewModel: TechnologyViewModelProtocol
    
    //MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    //MARK: - Initialization
    init (viewModel: TechnologyViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        self.setupViewModel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Private methods
    private func setupViewModel() {
        viewModel.reloadData = { [weak self] in
            self?.collectionView.reloadData()
        }
        
        viewModel.reloadCell = { [weak self] row in
            self?.collectionView.reloadItems(at: [IndexPath(row: row, section: 0)])
        }
        
        viewModel.showError = { error in
            //TODO: show alert with error
        }
    }
    
    private func setupUI() {
        view.addSubview(collectionView)
        
        collectionView.register(TechnologyCollectionViewCell.self, forCellWithReuseIdentifier: "TechnologyCollectionViewCell")
        
        collectionView.dataSource = self
        collectionView.delegate = self
        setupConstraints()
    }
    
    private func setupConstraints() {
        collectionView.snp.makeConstraints { make in
            make.top.bottom.equalTo(view.safeAreaLayoutGuide)
            make.trailing.leading.equalToSuperview().inset(5)
        }
    }
}

//MARK: - UICollectionViewDataSource
extension TechnologyViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.numberOfCells
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TechnologyCollectionViewCell", for: indexPath) as? TechnologyCollectionViewCell else { return UICollectionViewCell()}
        
        let article = viewModel.getArticle(for: indexPath.row)
        cell.set(article: article)
        return cell
    }
    
    
}
//MARK: - UICollectionViewDelegate
extension TechnologyViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let article = viewModel.getArticle(for: indexPath.row)
        navigationController?.pushViewController(NewsViewController(viewModel: NewsViewModel(article: article)), animated: true)
    }
}
