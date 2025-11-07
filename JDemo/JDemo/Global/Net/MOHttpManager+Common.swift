//
//  MOHttpManager+Common.swift
//  MiMoLive
//
//  Created by OneeChan on 2025/9/28.
//

import Foundation


typealias MOHttpManagerParam = [AnyHashable: Any]

extension MOHttpManager {
    func sendGetRequest<T>(path: String, params: MOHttpManagerParam, handler: @escaping (T?, String?) -> Void) where T: Decodable {
        MONetAPIClient.sharedJson().requestJsonData(withPath: path, withParams: params, withMethodType: Int32(Get.rawValue)) { data, error in
            self.handleResponse(data: data, error: error, handler: handler)
        }
    }
    func sendGetRequest(path: String, params: MOHttpManagerParam, handler: @escaping (String?) -> Void) {
        MONetAPIClient.sharedJson().requestJsonData(withPath: path, withParams: params, withMethodType: Int32(Get.rawValue)) { data, error in
            self.handleResponse(data: data, error: error, handler: handler)
        }
    }
    
    func sendPostRequest<T>(path: String, params: MOHttpManagerParam, handler: @escaping (T?, String?) -> Void) where T: Decodable {
        MONetAPIClient.sharedJson().requestJsonData(withPath: path, withParams: params, withMethodType: Int32(Post.rawValue)) { data, error in
            self.handleResponse(data: data, error: error, handler: handler)
        }
    }
    func sendPostRequest(path: String, params: MOHttpManagerParam, handler: @escaping (String?) -> Void) {
        MONetAPIClient.sharedJson().requestJsonData(withPath: path, withParams: params, withMethodType: Int32(Post.rawValue)) { data, error in
            self.handleResponse(data: data, error: error, handler: handler)
        }
    }
    
    func sendPutRequest<T>(path: String, params: MOHttpManagerParam, handler: @escaping (T?, String?) -> Void) where T: Decodable {
        MONetAPIClient.sharedJson().requestJsonData(withPath: path, withParams: params, withMethodType: Int32(Put.rawValue)) { data, error in
            self.handleResponse(data: data, error: error, handler: handler)
        }
    }
    func sendPutRequest(path: String, params: MOHttpManagerParam, handler: @escaping (String?) -> Void) {
        MONetAPIClient.sharedJson().requestJsonData(withPath: path, withParams: params, withMethodType: Int32(Put.rawValue)) { data, error in
            self.handleResponse(data: data, error: error, handler: handler)
        }
    }
    
    func sendDeleteRequest<T>(path: String, params: MOHttpManagerParam, handler: @escaping (T?, String?) -> Void) where T: Decodable {
        MONetAPIClient.sharedJson().requestJsonData(withPath: path, withParams: params, withMethodType: Int32(Delete.rawValue)) { data, error in
            self.handleResponse(data: data, error: error, handler: handler)
        }
    }
    func sendDeleteRequest(path: String, params: MOHttpManagerParam, handler: @escaping (String?) -> Void) {
        MONetAPIClient.sharedJson().requestJsonData(withPath: path, withParams: params, withMethodType: Int32(Delete.rawValue)) { data, error in
            self.handleResponse(data: data, error: error, handler: handler)
        }
    }
    
    private func handleResponse<T>(data: [AnyHashable: Any]?, error: Error?, handler: (T?, String?) -> Void) where T: Decodable {
        guard let data else {
            handler(nil, error?.localizedDescription)
            return
        }
        guard self.handleError(data) else { return }
        
        if data.isCodeSuccess, let content = data.data {
            let res = T.decode(param: content)
            handler(res, nil)
            return
        }
        
        if let err = data["msg"] as? String, err != "Success" {
            handler(nil, err)
        } else {
            handler(nil, nil)
        }
    }
    
    private func handleResponse(data: [AnyHashable: Any]?, error: Error?, handler: (String?) -> Void) {
        guard let data else {
            handler(error?.localizedDescription)
            return
        }
        guard self.handleError(data) else { return }
        
        if data.isCodeSuccess {
            handler(nil)
            return
        }
        
        if let err = data["msg"] as? String, err != "Success" {
            handler(err)
        } else {
            handler(nil)
        }
    }
}


// Codable
// TODO: 后续替换网络组件，避免需要 json -> dic -> json -> Decodable 的流程
extension Decodable {
    static func decode(param: [AnyHashable: Any]) -> Self? {
        guard let jsonData = getJsonData(param) else { return nil }
        guard let model = try? JSONDecoder().decode(Self.self, from: jsonData) else { return nil }
        
        return model
    }
    
    private static func getJsonData(_ param: [AnyHashable: Any]) -> Data? {
        if !JSONSerialization.isValidJSONObject(param) {
            return nil
        }
        guard let data = try? JSONSerialization.data(withJSONObject: param, options: []) else {
            return nil
        }
        return data
    }
}

extension Encodable {
    func toDictionary() -> [AnyHashable: Any] {
        let coder = JSONEncoder()
        coder.outputFormatting = .prettyPrinted
        
        guard let data = try? coder.encode(self) else {
            return [:]
        }
        guard let dic = try? JSONSerialization.jsonObject(with: data, options: .mutableLeaves),
              let dic = dic as? [AnyHashable: Any] else {
            return [:]
        }
        return dic
    }
}
