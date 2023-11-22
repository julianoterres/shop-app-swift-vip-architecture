//
//  NetworkRequestConfig.swift
//  Shop
//
//  Created by Juliano Terres on 20/11/23.
//

struct NetworkRequestConfig<ResponseType: Codable> {
  let method: NetworkHttpMethod
  let endPoint: NetworkEndpoints
  let responseType: ResponseType.Type
}
