//
//  NetworkCore.swift
//  VKClient
//
//  Created by Alex on 25.03.2022.
//

import Foundation

typealias CoreResult<T: Responsable> = Result<T, Error>

protocol NetworkCore {
    func sendRequest<Res: Responsable>(urlRequest: URLRequest?,
                                       completion: @escaping (CoreResult<Res>) -> Void)
}

final class NetworkCoreImpl {

}

//MARK: - NetworkCore

extension NetworkCoreImpl: NetworkCore {
    func sendRequest<Res: Responsable>(
        urlRequest: URLRequest?,
        completion: @escaping (CoreResult<Res>) -> Void) {

            guard let urlRequest = urlRequest else {
                completion(.failure(NetworkError.invalidURL))
                return }

            let sessionConfiguration = URLSessionConfiguration.ephemeral
            sessionConfiguration.timeoutIntervalForRequest = 30
            sessionConfiguration.timeoutIntervalForResource = 60
            let urlSession = URLSession(configuration: sessionConfiguration)

            urlSession.dataTask(with: urlRequest) { data, response, error in
                if error != nil {
                    completion(.failure(NetworkError.connectionError))
                    //todo alert controller
                    // когда нет сервака или таймаут
                    print(error?.localizedDescription as Any)
                    return
                }
                self.checkResponse(response: response, data: data, completion: completion)
            }.resume()
        }
}

//MARK: - Private methods

extension NetworkCoreImpl {
    private func checkResponse<Res: Responsable>(response: URLResponse?, data: Data?, completion: @escaping (CoreResult<Res>) -> Void ) {
        if let response = response as? HTTPURLResponse {
            guard let status = response.status else { return }
            switch status.responseType {
            case .success:
                guard let data = data else { return }
                self.handleSuccsesDataRespones(data, completion: completion)
            case .clientError:
                //todo alert controller
                print(response.statusCode)
                completion(.failure(NetworkError.connectionError))
                break
            case .serverError:
                //todo alert controller
                completion(.failure(NetworkError.connectionError))
                print(response.statusCode)
                break
            case .undefined:
                break
            }
        }
    }


    private func handleSuccsesDataRespones<Res: Responsable>(_ data: Data, completion: (CoreResult<Res>) -> Void) {
        do {
            completion(.success(try decodeData(data: data)))
        } catch {
            completion(.failure(error))
        }
    }
    
    private func decodeData<Res: Responsable>(data: Data) throws -> Res {
//        let json = try JSONSerialization.jsonObject(with: data, options: [])
//        print(json)
        let respones = try JSONDecoder().decode(Res.self, from: data)
        return respones
    }
}
