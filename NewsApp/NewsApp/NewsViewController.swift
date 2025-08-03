//
//  NewsViewController.swift
//  NewsApp
//
//  Created by Кристина Олейник on 03.08.2025.
//

import UIKit
import SnapKit

final class NewsViewController: UIViewController {
    
    //GUI Variables
    
    private lazy var scrollView: UIScrollView = {
        let view = UIScrollView()
         
        return view
    }()
    
    private lazy var contentView: UIView = UIView()
    
    private lazy var titleNewsLabel = {
        let label = UILabel()
        
        label.text = "Why scientists say we need to send clocks to the moon — soon"
        label.textAlignment = .center
        label.textColor = .black
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.font = .boldSystemFont(ofSize: 20)
        
        return label
    }()
    
    private lazy var authorNewsLabel = {
        let label = UILabel()
        
        label.text = "By Jackie Wattles, CNN"
        label.textColor = .gray
        label.font = .boldSystemFont(ofSize: 14)
        
        return label
    }()
    
    private lazy var dateNewsLabel = {
        let label = UILabel()
        
        label.text = "Published Fri May 31, 2024"
        label.textColor = .gray
        label.font = .boldSystemFont(ofSize: 14)
        
        return label
    }()
    
    private lazy var textNewsLabel = {
        let label = UILabel()
        
        label.text = """
        Perhaps the greatest, mind-bending quirk of our universe is the inherent trouble with timekeeping: Seconds tick by ever so slightly faster atop a mountain than they do in the valleys of Earth. 
        
        For practical purposes, most people don’t have to worry about those differences.
        
        But a renewed space race has the United States and its allies, as well as China, dashing to create permanent settlements on the moon, and that has brought the idiosyncrasies of time, once again, to the forefront.
        
        But a renewed space race has the United States and its allies, as well as China, dashing to create permanent settlements on the moon, and that has brought the idiosyncrasies of time, once again, to the forefront.
        
        NASA and its international partners are currently grappling with this conundrum.
        
        Scientists aren’t just looking to create a new “time zone” on the moon, as some headlines have suggested, said Cheryl Gramling, the lunar position, navigation, and timing and standards lead at NASA’s Goddard Space Flight Center in Maryland. Rather, the space agency and its partners are looking to create an entirely new “time scale,” or system of measurement that accounts for that fact that seconds tick by faster on the moon, Gramling noted.
        """
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textColor = .black
        label.font = .boldSystemFont(ofSize: 16)
        
        return label
    }()
    
    private lazy var imageNewsView = {
        let imageView = UIImageView(image: UIImage(named: "moon") ?? UIImage.add)
        
        imageView.contentMode = .scaleAspectFit
        
        return imageView
    }()

    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    //Private methods
    
    private func setupUI() {
        view.backgroundColor = .white
        
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        contentView.addSubview(titleNewsLabel)
        contentView.addSubview(authorNewsLabel)
        contentView.addSubview(dateNewsLabel)
        contentView.addSubview(imageNewsView)
        contentView.addSubview(textNewsLabel)
        
        setupConstraints()
        
    }
    
    private func setupConstraints() {
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        contentView.snp.makeConstraints { make in
            make.size.edges.equalToSuperview()
        }
        
        titleNewsLabel.snp.makeConstraints { make in
            make.top.equalTo(contentView.safeAreaLayoutGuide)
            make.leading.trailing.equalToSuperview().inset(10)
        }
        
        authorNewsLabel.snp.makeConstraints { make in
            make.top.equalTo(titleNewsLabel.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().inset(10)
        }
        
        dateNewsLabel.snp.makeConstraints { make in
            make.top.equalTo(authorNewsLabel.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview().inset(10)
        }
        
        imageNewsView.snp.makeConstraints { make in
            make.top.equalTo(dateNewsLabel.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().inset(10)
        }
        
        textNewsLabel.snp.makeConstraints { make in
            make.top.equalTo(imageNewsView.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().inset(10)
            make.bottom.equalTo(contentView.safeAreaLayoutGuide)
        }
    }
}
