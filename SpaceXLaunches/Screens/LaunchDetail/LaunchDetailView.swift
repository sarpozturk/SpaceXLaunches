//
//  LaunchDetailView.swift
//  SpaceXLaunches
//
//  Created by Sarp  on 6.02.2022.
//

import UIKit

class LaunchDetailView: UIView {
    
    let scrollView = UIScrollView()
    let stackView = UIStackView()
    let missionImageView = UIImageView()
    let missionDescriptionLabel = UILabel()
    let layout = UICollectionViewFlowLayout()
    var imageListCollectionView: UICollectionView!
    
    let heightConstant: CGFloat = 220
    let widthConstant: CGFloat = 220
    let spacingConstant: CGFloat = 48
    let sidePaddingConstant: CGFloat = 8
    
    var data: Launch!

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        backgroundColor = Constants.Color.backgroundColor
        setupMissionImageView()
        setupMissionDescriptionLabel()
        setupCollectionViewLayout()
        setupImageListCollectionView()
        setupScrollView()
        setupStackView()
        scrollView.addSubview(stackView)
        setupLayout()
    }
    
    private func setupScrollView() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.delegate = self
        addSubview(scrollView)
    }
    
    private func setupStackView() {
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = spacingConstant
        stackView.addArrangedSubview(missionImageView)
        stackView.addArrangedSubview(missionDescriptionLabel)
        stackView.addArrangedSubview(imageListCollectionView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setupMissionImageView() {
        missionImageView.contentMode = .scaleAspectFit
        missionImageView.image = UIImage(named: "rocket")
        missionImageView.heightAnchor.constraint(equalToConstant: heightConstant).isActive = true
    }
    
    private func setupMissionDescriptionLabel() {
        missionDescriptionLabel.numberOfLines = 0
        missionDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        missionDescriptionLabel.textColor = .white
    }
    
    private func setupCollectionViewLayout() {
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: widthConstant, height: heightConstant)
    }
    
    private func setupImageListCollectionView() {
        imageListCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        imageListCollectionView.translatesAutoresizingMaskIntoConstraints = false
        imageListCollectionView.showsHorizontalScrollIndicator = false
        imageListCollectionView.backgroundColor = Constants.Color.backgroundColor
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: sidePaddingConstant),
            stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: sidePaddingConstant),
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            stackView.widthAnchor.constraint(equalTo: safeAreaLayoutGuide.widthAnchor),
            imageListCollectionView.heightAnchor.constraint(equalToConstant: heightConstant),
            imageListCollectionView.widthAnchor.constraint(equalTo: stackView.widthAnchor),
            missionDescriptionLabel.trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: -sidePaddingConstant)
        ])
    }
    
    func setData(_ data: Launch?) {
        guard let data = data else { return }
        self.data = data
        if let launchImageUrl = data.links?.missionPatchSmall {
            missionImageView.downloadImage(from: launchImageUrl)
        }
        missionDescriptionLabel.text = data.details ?? "No Detail Given"
    }
}

extension LaunchDetailView: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.x > 0 {
            scrollView.contentOffset.x = 0
        }
    }
}
