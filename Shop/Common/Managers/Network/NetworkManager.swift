import Foundation

// MARK: NetworkManager

final class NetworkManager {}

// MARK: NetworkManagerProtocol

protocol NetworkManagerProtocol {
  func request<ResponseType: Codable>(
    configs: NetworkRequestConfig<ResponseType>,
    completion: @escaping (Result<NetworkResponse<ResponseType>, NetworkError>) -> Void
  )
}

extension NetworkManager: NetworkManagerProtocol {
  func request<ResponseType: Codable>(
    configs: NetworkRequestConfig<ResponseType>,
    completion: @escaping (Result<NetworkResponse<ResponseType>, NetworkError>) -> Void
  ) {
    callRequest(configs: configs, completion: completion)
  }
}

// MARK: Private Methods

private extension NetworkManager {
  func callRequest<ResponseType: Codable>(
    configs: NetworkRequestConfig<ResponseType>,
    completion: @escaping (Result<NetworkResponse<ResponseType>, NetworkError>) -> Void
  ) {
      let request = createBaseRequest(configs: configs)
    
      URLSession.shared.dataTask(with: request) { data, response, _ in
          self.makeRequestResponse(
            endpoint: configs.endPoint,
            responseType: configs.responseType,
            data: data, response: response,
            completion: completion
          )
      }.resume()
  }
  
  func createBaseRequest<ResponseType: Codable>(configs: NetworkRequestConfig<ResponseType>) -> URLRequest {
    let url = configs.endPoint.url
    var request = URLRequest(url: URL(string: url)!)
    
    request.httpMethod = configs.method.rawValue

    return request
  }
  
  func makeRequestResponse<ResponseType: Codable>(
    endpoint: NetworkEndpoints,
    responseType: ResponseType.Type,
    data: Data?,
    response: URLResponse?,
    completion: @escaping (Result<NetworkResponse<ResponseType>, NetworkError>) -> Void
  ) {
    guard let response = response as? HTTPURLResponse else {
      completion(.failure(NetworkError(type: .badRquest)))
      return
    }

    guard let data = data else {
      completion(.failure(NetworkError(type: .noData)))
      return
    }

    DispatchQueue.main.async {
      switch NetworkHttpStatusType(rawValue: response.statusCode) {
      case .success:
        self.completionSuccess(responseType: responseType, data: data, completion: completion)
      default:
        self.completionError(statusCode: response.statusCode, completion: completion)
      }
    }
  }
  
  func completionError<ResponseType: Codable>(
    statusCode: Int,
    completion: @escaping (Result<NetworkResponse<ResponseType>, NetworkError>) -> Void
  ) {
    let type = NetworkHttpStatusType(rawValue: statusCode) ?? .notFound
    let error = NetworkError(type: type)
    
    completion(.failure(error))
  }

  func completionSuccess<ResponseType: Codable>(
    responseType: ResponseType.Type,
    data: Data,
    completion: @escaping (Result<NetworkResponse<ResponseType>, NetworkError>) -> Void
  ) {
    let data: ResponseType? = try? JSONDecoder().decode(responseType.self, from: data)
    let response = NetworkResponse(data: data)
    
    completion(.success(response))
  }
}
