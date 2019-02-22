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

    var datasource: [GiphyItem] = [] {
        didSet {
            delegate?.didUpdateDatasource()
        }
    }

    func fetchItems() {
        let service = GIPHYAPIService.trending(100)
        service.sendRequest { (data) in
            print(data)
            do {
                let items = try JSONDecoder().decode(GIFResponse.self, from: data)
                self.datasource = items.data
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}

struct GIFResponse: Codable {
    let data: [GiphyItem]
    let pagination: Pagination
}
