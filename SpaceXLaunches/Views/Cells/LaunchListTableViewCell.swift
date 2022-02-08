//
//  LaunchListTableViewCell.swift
//  SpaceXLaunches
//
//  Created by Sarp  on 6.02.2022.
//

import UIKit

final class LaunchListTableViewCell: UITableViewCell {
    
    let titleLabel = UILabel()
    let dateLabel = UILabel()
    let launchImageView = UIImageView()

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        backgroundColor = Constants.Color.backgroundColor
        setupLaunchImageView()
        setupTitleLabel()
        setupDateLabel()
    }

    private func setupTitleLabel() {
        titleLabel.numberOfLines = 1
        titleLabel.textColor = .white
        titleLabel.font = UIFont.boldSystemFont(ofSize: 18)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 24),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: launchImageView.leadingAnchor, constant: -16)
        ])
    }
    
    private func setupDateLabel() {
        dateLabel.numberOfLines = 1
        dateLabel.textColor = .lightGray
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(dateLabel)
        NSLayoutConstraint.activate([
            dateLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            dateLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            dateLabel.trailingAnchor.constraint(equalTo: launchImageView.leadingAnchor, constant: -16)
        ])
    }
    
    private func setupLaunchImageView() {
        launchImageView.contentMode = .scaleAspectFit
        launchImageView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(launchImageView)
        NSLayoutConstraint.activate([
            launchImageView.heightAnchor.constraint(equalToConstant: 60),
            launchImageView.widthAnchor.constraint(equalToConstant: 60),
            launchImageView.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            launchImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
            launchImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16)
        ])
    }
    
    public func setData(launch: Launch) {
        if let date = launch.launchDateLocal?.convertToDate() {
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd hh:mm:ss"
            dateLabel.text = formatter.string(from: date)
        }
        titleLabel.text = launch.missionName
        if let launchImageUrl = launch.links?.missionPatchSmall {
            launchImageView.downloadImage(from: launchImageUrl)
        }
        else {
            launchImageView.image = UIImage(named: "rocket")
        }
    }
}
