//
//  NetworkRequestConfig.swift
//  Shop
//
//  Created by Juliano Terres on 20/11/23.
//

struct NetworkRequestConfig<ResponseType: Codable, Body: Codable> {
  let method: NetworkHttpMethod
  let endPoint: NetworkEndpoints
  var body: Body?
  let responseType: ResponseType.Type
}
