//
//  GIFBrowserViewModel.swift
//  GIPHYClient
//
//  Created by Bryan A Bolivar M on 2/22/19.
//  Copyright © 2019 BolivarBryan. All rights reserved.
//

import Foundation

protocol GIFBrowserViewModelDelegate {
    func didUpdateDatasource()
}

class GIFBrowserViewModel {
    var delegate: GIFBrowserViewModelDelegate? = nil

    var datasource: [Image] = [] {
        didSet {
            delegate?.didUpdateDatasource()
        }
    }

    func fetchItems() {

        let images = DatabaseEndpoint.listImages
        images.fetch { (response) in
            let array = response as! [[String: Any]]
            self.datasource = array.compactMap({ item -> Image? in
                return Image(from: item)
            })
        }

        let service = GIPHYAPIService.trending(100)
        service.sendRequest { (data) in
            self.decodeImages(from: data)
        }
    }

    func decodeImages(from data: Data) {
        do {
            let items = try JSONDecoder().decode(GIFResponse.self, from: data)
            self.datasource = items.data.map({$0.image.preview})
        } catch {
            print(error.localizedDescription)
        }
    }
}

struct GIFResponse: Codable {
    let data: [GiphyItem]
    let pagination: Pagination
}
