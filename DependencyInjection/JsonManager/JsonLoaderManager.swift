//
//  Utility.swift

//
//  Created by Lalit Kant on 06/04/21.
//

import Foundation

protocol GetTimerFileData {
    func getTimerData(completion: @escaping (Result<[TimerDataModal]?, Error>) -> ())
}

struct LoadDataFromJsonServiceManager: GetTimerFileData {
    
    func getTimerData(completion: @escaping (Result<[TimerDataModal]?, Error>) -> ()) {
        self.loadJson(fileName: Constants.fileName, completion: completion)
    }
    
    private func loadJson<T: Decodable>(fileName: String, completion: @escaping (Result<T?, Error>) -> ()) {
        if let url = Bundle.main.url(forResource: fileName, withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode(T.self, from: data)
                return completion(.success(jsonData))
            } catch {
                print("error:\(error)")
                return completion(.failure(error))
            }
        }
        return
    }
    
}



struct LoadDataFromApiServiceManager: GetTimerFileData {
    
    func getTimerData(completion: @escaping (Result<[TimerDataModal]?, Error>) -> ()) {
        completion(.success([TimerDataModal.init()]))
    }
}
