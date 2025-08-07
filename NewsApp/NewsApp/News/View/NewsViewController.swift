//
//  NewsViewController.swift
//  NewsApp
//
//  Created by Кристина Олейник on 03.08.2025.
//

import UIKit
import SnapKit

final class NewsViewController: UIViewController {
    
    //MARK: - GUI Variables
    
    private lazy var scrollView: UIScrollView = {
        let view = UIScrollView()
         
        return view
    }()
    
    private lazy var contentView: UIView = UIView()
    
    private lazy var titleNewsLabel = {
        let label = UILabel()
        
        //label.text = "Why scientists say we need to send clocks to the moon — soon"
        //label.textAlignment = .center
        label.textColor = .black
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.font = .boldSystemFont(ofSize: 20)
        
        return label
    }()
    
    private lazy var dateNewsLabel = {
        let label = UILabel()
        
        //label.text = "Published Fri May 31, 2024"
        label.textColor = .gray
        label.font = .systemFont(ofSize: 14)
        
        return label
    }()
    
    private lazy var textNewsLabel = {
        let label = UILabel()
        
//        label.text = "text"
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textColor = .black
        label.font = .systemFont(ofSize: 16)
        
        return label
    }()
    
    private lazy var imageNewsView = {
        let imageView = UIImageView()
        //imageView.setContentHuggingPriority(.defaultLow, for: .vertical)
        //imageView.setContentCompressionResistancePriority(.required, for: .vertical)
        return imageView
    }()

    //MARK: - Properties
    private let viewModel: NewsViewModelProtocol
    private var aspectRatio: Double = 1
    
    //MARK: - Life Cycle
    
    init (viewModel: NewsViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    //MARK: - Private methods
    
    private func setupUI() {
        view.backgroundColor = .white
        
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        contentView.addSubview(titleNewsLabel)
        contentView.addSubview(dateNewsLabel)
        contentView.addSubview(imageNewsView)
        contentView.addSubview(textNewsLabel)
        
        titleNewsLabel.text = viewModel.title
        textNewsLabel.text = viewModel.description
        dateNewsLabel.text = viewModel.date
        if let data = viewModel.imageData,
            let image = UIImage(data: data) {
            imageNewsView.image = image
        } else {
            imageNewsView.image = UIImage(named: "worldNews")
        }
        
        configureImageSize()
        setupConstraints()
        
    }
    
    private func configureImageSize() {
        guard let image = imageNewsView.image else { return }
        
        // Рассчитываем соотношение сторон
        aspectRatio = image.size.height / image.size.width
    }
    
    private func setupConstraints() {
        scrollView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
        
        contentView.snp.makeConstraints { make in
            make.width.equalTo(scrollView) // Важно!
            make.top.bottom.leading.trailing.equalToSuperview()
        }
        
        titleNewsLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(10)
        }
        
        dateNewsLabel.snp.makeConstraints { make in
            make.top.equalTo(titleNewsLabel.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().inset(10)
        }
        
        imageNewsView.snp.makeConstraints { make in
            make.top.equalTo(dateNewsLabel.snp.bottom).offset(5)
            make.leading.trailing.equalToSuperview().inset(10)
            make.height.equalTo(imageNewsView.snp.width).multipliedBy(aspectRatio)// Фиксируем пропорции
        }
        
        textNewsLabel.snp.makeConstraints { make in
            make.top.equalTo(imageNewsView.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().inset(10)
            make.bottom.equalTo(contentView.safeAreaLayoutGuide)
        }
    }
}
