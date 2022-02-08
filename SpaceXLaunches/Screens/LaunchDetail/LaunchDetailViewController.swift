//
//  LaunchDetailViewController.swift
//  SpaceXLaunches
//
//  Created by Sarp  on 6.02.2022.
//

import UIKit

class LaunchDetailViewController: UIViewController {
    
    var viewSource: LaunchDetailView {
        return self.view as! LaunchDetailView
    }

    override func loadView() {
        view = LaunchDetailView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        viewSource.imageListCollectionView.dataSource = self
        viewSource.imageListCollectionView.delegate = self
        viewSource.imageListCollectionView.register(ImageListCollectionViewCell.self, forCellWithReuseIdentifier: ImageListCollectionViewCell.identifier)
    }

    func setData(_ data: Launch?) {
        self.title = data?.missionName
        guard let data = data else { return }
        viewSource.setData(data)
    }
}


extension LaunchDetailViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewSource.data.links?.flickrImages?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageListCollectionViewCell.identifier, for: indexPath) as! ImageListCollectionViewCell
        cell.setData(viewSource.data.links?.flickrImages?[indexPath.row])
        return cell
    }
}
