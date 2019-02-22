//
//  GIFBrowserViewController.swift
//  GIPHYClient
//
//  Created by Bryan A Bolivar M on 2/22/19.
//  Copyright © 2019 BolivarBryan. All rights reserved.
//

import UIKit

class GIFBrowserViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    let viewModel = GIFBrowserViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
        viewModel.fetchItems()
        title = Language.appName.localized
    }
}

extension GIFBrowserViewController: GIFBrowserViewModelDelegate {
    func didUpdateDatasource() {
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
}
