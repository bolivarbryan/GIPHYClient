//
//  GIFBrowserViewController+CollectionView.swift
//  GIPHYClient
//
//  Created by Bryan A Bolivar M on 2/22/19.
//  Copyright © 2019 BolivarBryan. All rights reserved.
//

import UIKit

extension GIFBrowserViewController: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.datasource.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell  = collectionView
            .dequeueReusableCell(withReuseIdentifier: "GIPHYCollectionViewCell",
                                 for: indexPath) as! GIPHYCollectionViewCell
        cell.item = viewModel.datasource[indexPath.row]
        return cell
    }
}

extension GIFBrowserViewController: UICollectionViewDelegate { }

extension GIFBrowserViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWidth = (UIScreen.main.bounds.width/4)-4
        return CGSize(width: cellWidth, height: cellWidth)
    }
}
