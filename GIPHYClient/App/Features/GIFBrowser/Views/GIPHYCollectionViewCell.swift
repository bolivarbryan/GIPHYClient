//
//  GIPHYCollectionViewCell.swift
//  GIPHYClient
//
//  Created by Bryan A Bolivar M on 2/22/19.
//  Copyright © 2019 BolivarBryan. All rights reserved.
//

import UIKit
import SwiftGifOrigin

class GIPHYCollectionViewCell: UICollectionViewCell {
    var item: Image? {
        didSet {
            guard
                let item = item,
                let url = item.url
                else { return }


            if let data = item.data {
                 DispatchQueue.main.async() {
                    self.gifImageView.image = UIImage.gif(data: data)
                }
            } else {
                getData(from: url) { data, response, error in
                    guard
                        let data = data,
                        error == nil
                        else { return }

                    DispatchQueue.main.async() {
                        self.gifImageView.image = UIImage.gif(data: data)

                        //once loaded data store it in local database
                        let newImageEndpoint = DatabaseEndpoint.newImage(imageData: data, url: url.absoluteString)
                        newImageEndpoint.save()
                    }
                }
            }

        }
    }

    @IBOutlet weak var gifImageView: UIImageView!

    func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }

}
