//
//  GIFBrowserViewController.swift
//  GIPHYClient
//
//  Created by Bryan A Bolivar M on 2/22/19.
//  Copyright © 2019 BolivarBryan. All rights reserved.
//

import UIKit

class GIFBrowserViewController: UIViewController {

    lazy var collectionViewLayout: UICollectionViewFlowLayout = {
        let cellWidth = (UIScreen.main.bounds.width/4) - 4
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 3, left: 3, bottom: 0, right: 3)
        layout.minimumInteritemSpacing = 2;
        layout.minimumLineSpacing = 2;
        layout.itemSize = CGSize(width: cellWidth, height: cellWidth)
        layout.scrollDirection = .vertical
        return layout
    }()

    @IBOutlet weak var collectionView: UICollectionView!
    let viewModel = GIFBrowserViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
        viewModel.fetchItems()
    }
}

extension GIFBrowserViewController: GIFBrowserViewModelDelegate {
    func didUpdateDatasource() {
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
}
