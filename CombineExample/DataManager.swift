//
//  DataManager.swift
//  CombineExample
//
//  Created by UW-IN-LPT0108 on 2/5/22.
//

import Foundation
import Combine
import Metal

class DataManager {
    
    static let shared = DataManager()
    
    private init() {
        
    }
    
    var cancellables = Set<AnyCancellable>()
    var posts = [Post]()
    
    func getData() -> Future<[Post], Error> {
        return Future<[Post], Error> { promise in
            guard let baseURL = URL(string: "https://jsonplaceholder.typicode.com/posts") else { fatalError("Check the URL") }
            
            // Combine Implimentation:
            /*
             //1. create publisher
             //2. subscribe publisher on background thread
             //3. receive on main thread
             //4. tryMap (check that the data is good)
             //5. decode (decode data into models)
             //6. sink (put the item in our app)
             //7. store (cancel subscription if needed)
             */
            
            URLSession.shared.dataTaskPublisher(for: baseURL)
                .subscribe(on: DispatchQueue.global(qos: .background))
                .receive(on: RunLoop.main)
                .tryMap { (data, response) -> Data in
                    guard
                        let response = response as? HTTPURLResponse,
                        response.statusCode >= 200 && response.statusCode < 300 else {
                            throw URLError(.badServerResponse)
                        }
                    return data
                }
                .decode(type: [Post].self, decoder: JSONDecoder())
                .sink { (completion) in
                    print("Completion: \(completion)")
                } receiveValue: { promise(.success($0)) }
                .store(in: &self.cancellables)
        }
    }
}
