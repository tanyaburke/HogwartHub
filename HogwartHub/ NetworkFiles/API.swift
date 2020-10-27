//
//  API.swift
//  HogwartHub
//
//  Created by Tanya Burke on 10/27/20.
//  Copyright © 2020 Tanya Burke. All rights reserved.
//

import Foundation

struct HogwartsAPICLient {

static func fetchCharacters(completion: @escaping (Result <[Characters],AppError>)->()){
    
    let movieEndPointURLString = "https://hp-api.herokuapp.com/api/characters"
    guard let url = URL(string: movieEndPointURLString) else {
        completion(.failure(.badURL(movieEndPointURLString)))
        return
    }
    let request = URLRequest(url: url) //creating a url request
    
    NetworkHelper.shared.performDataTask(with: request){
        (result) in
        switch result{
        case .failure(let appError):
            completion(.failure(.networkClientError(appError)))
        case .success(let data):
            do{
                let characters = try
                    JSONDecoder().decode([Characters].self, from: data)
                completion(.success(characters))
            }catch{
                completion(.failure(.decodingError(error)))
                
            }
            
        }
    }
}
    static func fetchHouse(house: String, completion: @escaping (Result <[Characters],AppError>)->()){
        
        let movieEndPointURLString = "http://hp-api.herokuapp.com/api/characters/house/\(house)"
        guard let url = URL(string: movieEndPointURLString) else {
            completion(.failure(.badURL(movieEndPointURLString)))
            return
        }
        let request = URLRequest(url: url) //creating a url request
        
        NetworkHelper.shared.performDataTask(with: request){
            (result) in
            switch result{
            case .failure(let appError):
                completion(.failure(.networkClientError(appError)))
            case .success(let data):
                do{
                    let characters = try
                        JSONDecoder().decode([Characters].self, from: data)
                    completion(.success(characters))
                }catch{
                    completion(.failure(.decodingError(error)))
                    
                }
                
            }
        }
    }
}
