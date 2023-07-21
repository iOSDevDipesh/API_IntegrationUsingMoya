//
//  ViewController.swift
//  API_IntegrationUsingMoya
//
//  Created by mac on 27/03/23.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.initialization()
    }
    
    private func initialization() {
        self.getImages()
    }
    
    private func getImages() {
        NetworkManager.shared.request(target: .getImages(page: 1, limit: 20), type: [ImageData].self) { result in
            switch result {
            case .success(let data):
                print(data)
            case .failure(let error):
                print(error)
            }
        }
    }
}

