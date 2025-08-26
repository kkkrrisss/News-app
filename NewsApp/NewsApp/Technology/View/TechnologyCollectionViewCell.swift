//
//  TechnologyCollectionViewCell.swift
//  NewsApp
//
//  Created by Кристина Олейник on 07.08.2025.
//

import UIKit
import SnapKit

final class TechnologyCollectionViewCell: UICollectionViewCell {
    //MARK: - GUI Variables
    
    private let imageView: UIImageView = {
        let view = UIImageView()
        
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
        view.layer.masksToBounds = true
        
        return view
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        
        label.text = "Title"
        label.textColor = .black
        label.font = .boldSystemFont(ofSize: 18)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        
        return label
    }()
    
    private let grayView: UIView = {
        let view = UIView()
        
        view.backgroundColor = .systemGray5
        
        return view
    }()
    //MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Methods
    func set(article: ArticleCellViewModel) {
        titleLabel.text = article.title
        if let data = article.imageData,
            let image = UIImage(data: data) {
            imageView.image = image
        } else {
            imageView.image = UIImage(named: "worldNews")
        }
    }
    
    //MARK: - Private methods
    private func setupUI() {
        addSubview(imageView)
        addSubview(titleLabel)
        addSubview(grayView)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        imageView.snp.makeConstraints { make in
            make.height.equalTo(120)
            make.top.trailing.leading.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(imageView.snp.bottom).offset(5)
        }
        
        grayView.snp.makeConstraints { make in
            make.height.equalTo(3)
            make.leading.trailing.bottom.equalToSuperview()
            make.top.equalTo(titleLabel.snp.bottom).offset(5)
        }
    }
}
