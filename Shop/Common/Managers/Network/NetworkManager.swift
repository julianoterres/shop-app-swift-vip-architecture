import Foundation

// MARK: NetworkManager

final class NetworkManager {}

// MARK: NetworkManagerProtocol

protocol NetworkManagerProtocol {
  func request<ResponseType: Codable, Body: Codable>(
    configs: NetworkRequestConfig<ResponseType, Body>,
    completion: @escaping (Result<NetworkResponse<ResponseType>, NetworkError>) -> Void
  )
}

extension NetworkManager: NetworkManagerProtocol {
  func request<ResponseType: Codable, Body: Codable>(
    configs: NetworkRequestConfig<ResponseType, Body>,
    completion: @escaping (Result<NetworkResponse<ResponseType>, NetworkError>) -> Void
  ) {
    callRequest(configs: configs, completion: completion)
  }
}

// MARK: Private Methods

private extension NetworkManager {
  func callRequest<ResponseType: Codable, Body: Codable>(
    configs: NetworkRequestConfig<ResponseType, Body>,
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
  
  func createBaseRequest<ResponseType: Codable, Body: Codable>(configs: NetworkRequestConfig<ResponseType, Body>) -> URLRequest {
    let url = makeBaseUrl(configs: configs)
    let request = makeRequest(url: url, configs: configs)
    return request
  }

  func makeRequest<ResponseType: Codable, Body: Codable>(url: String, configs: NetworkRequestConfig<ResponseType, Body>) -> URLRequest {
    var request = URLRequest(url: URL(string: url)!)
    request.httpMethod = configs.method.rawValue

    if configs.body.isNotNil, configs.method == .post {
      request.httpBody = try? JSONEncoder().encode(configs.body)
    }

    return request
  }
  
  func makeBaseUrl<ResponseType: Codable, Body: Codable>(configs: NetworkRequestConfig<ResponseType, Body>) -> String {
    var baseUrl = configs.endPoint.url
    
    if getRequestHasParameters(configs: configs) {
      baseUrl = createBaseUrlWithParameters(baseUrl: baseUrl, body: configs.body)
    }

    return baseUrl
  }
  
  func getRequestHasParameters<ResponseType: Codable, Body: Codable>(configs: NetworkRequestConfig<ResponseType, Body>) -> Bool {
    return configs.body.isNotNil && configs.method == .get && configs.body?.asDictionary?.count ?? 0 >= 1
  }
  
  func createBaseUrlWithParameters(baseUrl: String, body: Codable?) -> String {
    guard let parameters = body?.asDictionary, parameters.count > 0 else {
      return baseUrl
    }
    
    var baseUrl = baseUrl
    var queryParameters: [String] = []
    
    parameters.forEach { key, value in
      let parameter = "\(key)=\(value)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? .empty
      queryParameters.append(parameter)
    }
    
    baseUrl = "\(baseUrl)?\(queryParameters.joined(separator: "&"))"
    
    return baseUrl
  }
}
