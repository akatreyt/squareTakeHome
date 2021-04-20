//
//  ImageCaching.swift
//  SquareTakeHome
//
//  Created by Trey Tartt on 4/20/21.
//

import Foundation
import UIKit

// ImageCache is used as an in memory store for URL:Data with the URL being the key
public final class ImageCache{
    
    // when we read / write to the internal cache need it to be on a serial queue
    private let queue = DispatchQueue.init(label: "ImageCachingQueue",
                                   qos: .background)
    
    private var imageCache = [URL: Data]()
    
    /**
     * Retrieve an UIImage or NetworkError for a given url from the ImageCache
     *
     * - Parameters:
     *   - forURL: The URL to fetch the image from, also used as the key in the internal cache
     *   - completion: Closure to return the UIImage object or NetworkError
     * - Returns: Void
     */
    public func getImage(forURL url: URL, completion: @escaping (Result<UIImage, NetworkError>) -> Void){
        if imageCache.keys.contains(url){
            queue.sync {
                if let data = imageCache[url],
                   let image = UIImage(data: data){
                    DispatchQueue.main.async {
                        completion(.success(image))
                    }
                    return
                }
            }
        }else{
            fetchImage(forURL: url, completion: completion)
        }
    }
    
    private func fetchImage(forURL url: URL, completion: @escaping (Result<UIImage, NetworkError>) -> Void){
        URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in
            guard let data = data else {
                DispatchQueue.main.async {
                    completion(.failure(.NoData(url)))
                }
                return
            }
            
            if let httpResponse = response as? HTTPURLResponse {
                if httpResponse.statusCode != 200 {
                    DispatchQueue.main.async {
                        completion(.failure(.InvalidHTTPCode(url, httpResponse.statusCode)))
                    }
                    return
                }
            }else{
                DispatchQueue.main.async {
                    completion(.failure(.InvalidResponse(url)))
                }
                return
            }
            
            if let image = UIImage(data: data){
                self!.queue.sync {
                    self!.imageCache[url] = data
                    DispatchQueue.main.async {
                        completion(.success(image))
                    }
                }
                return
            }
            DispatchQueue.main.async {
                completion(.failure(.ErrorDecodingImage(url)))
            }
        }.resume()
    }
}
