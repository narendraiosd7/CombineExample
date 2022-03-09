//
//  PostViewModel.swift
//  CombineExample
//
//  Created by UW-IN-LPT0108 on 2/5/22.
//

import Foundation
import Combine

protocol PostViewModelDelegate: AnyObject {
    func updateUI()
}

class PostViewModel {
    
    private var cancellables = Set<AnyCancellable>()
    @Published var posts = [Post]()
    weak var delegate: PostViewModelDelegate?
    
    func getHomeData() {
        DataManager.shared.getData()
            .sink { completion in
                switch completion {
                case .failure(let err):
                    print("Error is \(err.localizedDescription)")
                case .finished:
                    self.delegate?.updateUI()
                }
            } receiveValue: { newPosts in
                self.posts = newPosts
                print(self.posts.count)
            }
            .store(in: &cancellables)
        
    }
}
