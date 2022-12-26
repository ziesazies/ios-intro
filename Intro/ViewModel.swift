//
//  ViewModel.swift
//  Intro
//
//  Created by Alief Ahmad Azies on 27/12/22.
//

import Foundation
import Alamofire
import UIKit

class ViewModel {
    func downloadImage(url: URL, completion: @escaping (UIImage?) -> Void) {
        AF.request(url)
            .responseData { (response) in
                switch response.result {
                case .success(let data):
                    let image = UIImage(data: data)
                    completion(image)
                case .failure(let error):
                    print(error.localizedDescription)
                    completion(nil)
                }
            }
    }
}
