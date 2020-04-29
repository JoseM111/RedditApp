import Foundation
import UIKit.UIImage

class PostModelController {
    
    static let baseURL = URL(string: "https://www.reddit.com/r/funny.json")
    
    static func fetchPosts(completion: @escaping (Result<[Post], PostError>) -> Void) {
        
        guard let finalURL = baseURL else { return completion(.failure(.invalidURL)) }
        
        URLSession.shared.dataTask(with: finalURL) { (data, _, error) in
            
            if let error = error {
                print(error.localizedDescription)
                return completion(.failure(.thrownError(error)))
            }
            
            guard let data = data else { return completion(.failure(.noData)) }
            
            // Decoding You have to decode data from the top down in this app
            do {
                let topLevel = try JSONDecoder().decode(PostTopLvLObj.self, from: data)
                let secondLevel = topLevel.data
                let thirdLvLArray = secondLevel.children
                
                var postArray: [Post] = []
                
                for obj in thirdLvLArray {
                    let post = obj.data
                    postArray.append(post)
                }
                
                return completion(.success(postArray))
                
            } catch {
                print(error.localizedDescription)
                return completion(.failure(.thrownError(error)))
            }
            
        }.resume()
    }
    
    /**©-----------------------------©*/
    static func fetchThumbnail(post: Post, completion: @escaping (Result<UIImage, PostError>) -> Void) {
        
        guard let thumbnailURL = URL(string: post.thumbnail) else { return completion(.failure(.invalidURL)) }
//        print(thumbnailURL)
        
        URLSession.shared.dataTask(with: thumbnailURL) { (data, _, error) in
            if let error = error {
                print(error.localizedDescription)
                return completion(.failure(.thrownError(error)))
            }
            
            guard let data = data else { return completion(.failure(.noData)) }
            guard let thumbnail = UIImage(data: data) else { return completion(.failure(.unableToDecode)) }
            
            return completion(.success(thumbnail))
            
        }.resume()
    }
    
    /**©-----------------------------©*/
}
