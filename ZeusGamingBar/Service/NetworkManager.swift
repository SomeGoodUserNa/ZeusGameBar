//
//  NetworkManager.swift
//  ZeusGamingBar
//
//  Created by Danylo Klymenko on 17.09.2024.
//

import Foundation

enum URLS: String {
    case dirnks = "https://api.jsonserve.com/3_ZkDz"
    case food = "https://api.jsonserve.com/QDvaiO"
    case snacks = "https://api.jsonserve.com/a3TF6V"
    case news = "https://api.jsonserve.com/TPBF4u"
    case clubs = "https://api.jsonserve.com/HXLUrl"
}

class NetworkManager  {
    
    static let shared = NetworkManager()
    
    private init(){}
    
    
    func fetchClubs(from urlString: String, completion: @escaping ([Club]?) -> Void) {
        guard let url = URL(string: urlString) else {
            print("Некорректный URL")
            completion(nil)
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Ошибка запроса: \(error)")
                completion(nil)
                return
            }
            
            guard let data = data else {
                print("Нет данных")
                completion(nil)
                return
            }
            
            let decoder = JSONDecoder()
            do {
                let clubs = try decoder.decode([Club].self, from: data)
                completion(clubs)
            } catch {
                print("Ошибка при парсинге JSON: \(error)")
                completion(nil)
            }
        }.resume()
    }
    
    func fetchNews(from urlString: String, completion: @escaping ([News]?) -> Void) {
        guard let url = URL(string: urlString) else {
            print("Некорректный URL")
            completion(nil)
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Ошибка запроса: \(error)")
                completion(nil)
                return
            }
            
            guard let data = data else {
                print("Нет данных")
                completion(nil)
                return
            }
            
            let decoder = JSONDecoder()
            do {
                let clubs = try decoder.decode([News].self, from: data)
                completion(clubs)
            } catch {
                print("Ошибка при парсинге JSON: \(error)")
                completion(nil)
            }
        }.resume()
    }
    
    func fetchProduct(from urlString: String, completion: @escaping ([Product]?) -> Void) {
        guard let url = URL(string: urlString) else {
            print("Некорректный URL")
            completion(nil)
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Ошибка запроса: \(error)")
                completion(nil)
                return
            }
            
            guard let data = data else {
                print("Нет данных")
                completion(nil)
                return
            }
            
            let decoder = JSONDecoder()
            do {
                let clubs = try decoder.decode([Product].self, from: data)
                completion(clubs)
            } catch {
                print("Ошибка при парсинге JSON: \(error)")
                completion(nil)
            }
        }.resume()
    }
}
