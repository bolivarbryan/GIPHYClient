//
//  GIPHYCollectionViewCell.swift
//  GIPHYClient
//
//  Created by Bryan A Bolivar M on 2/22/19.
//  Copyright © 2019 BolivarBryan. All rights reserved.
//

import UIKit
import SwiftyGif

class GIPHYCollectionViewCell: UICollectionViewCell {
    var item: GiphyItem? {
        didSet {
            guard
                let item = item,
                let url = item.image.preview.url
                else { return }

            print(url)

            getData(from: url) { data, response, error in
                guard
                    let data = data,
                    error == nil
                    else { return }

                DispatchQueue.main.async() {
                    self.gifImageView.image = UIImage(gifData: data)
                }
            }
        }
    }
    
    @IBOutlet weak var gifImageView: UIImageView!

    func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
}
