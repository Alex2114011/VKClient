//
//  ImageLoader.swift
//  VKClient
//
//  Created by Alex on 03.04.2022.
//

import UIKit

final public class ImageLoader {

    //MARK: - Private property

    private lazy var cache: NSCache<NSString, UIImage> = {
        let cache = NSCache<NSString, UIImage>()
        cache.totalCostLimit = 20 * 1000 * 1000
        return cache
    }()

    private lazy var loadingQueue = DispatchQueue(label: "image loading queue")

    //MARK: - Public init

    public init() {}

    public func loadImage(by url: URL, compleation: @escaping (UIImage?) -> Void) {
        loadingQueue.async {
            if let image = self.cache.object(forKey: url.absoluteString as NSString) {
                DispatchQueue.main.async {
                    compleation(image)
                }
                return
            }
            guard let data = try? Data(contentsOf: url),
                  let image = UIImage(data: data) else {
                      DispatchQueue.main.async {
                          compleation(nil)
                      }
                      return
                  }
            self.cache.setObject(image, forKey: url.absoluteString as NSString)
            DispatchQueue.main.async {
                compleation(image)
            }
        }
    }
}
