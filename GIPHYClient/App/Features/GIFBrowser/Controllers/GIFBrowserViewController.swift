//
//  GIFBrowserViewController.swift
//  GIPHYClient
//
//  Created by Bryan A Bolivar M on 2/22/19.
//  Copyright © 2019 BolivarBryan. All rights reserved.
//

import UIKit

class GIFBrowserViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let service = GIPHYAPIService.trending(1)
        service.sendRequest { (data) in
            print(data)
            do {
                let items = try JSONDecoder().decode(GIFResponse.self, from: data)
                print(items)
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}
