//
//  MOHttpManager+Relation.swift
//  MiMoLive
//
//  Created by OneeChan on 2025/10/14.
//

import Foundation

let kNetPath_CheckContactFollow = "/contact/follow/check"
let kNetPath_FollowSubmit = "/contact/follow/submit"

extension MOHttpManager {
    func checkFollowStatus(uids: [String], handler: @escaping (MORelationStatusVo?, String?) -> Void) {
        sendPostRequest(path: kNetPath_CheckContactFollow, params: ["list": uids], handler: handler)
    }
    func checkFollowStatus(uid: String, handler: @escaping (Bool, String?) -> Void) {
        checkFollowStatus(uids: [uid]) { list, error in
            handler(list?.list.contains(uid) ?? false, error)
        }
    }
    
    private func submitFollow(uids: [String], type: Int, roomId: String? = nil, handler: @escaping (String?) -> Void) {
        var dic: MOHttpManagerParam = ["type": type, // 类型（1=关注，2=取关）
                                       "target": uids]
        if let roomId {
            dic["roomId"] = roomId
        }
        sendPostRequest(path: kNetPath_FollowSubmit, params: dic, handler: handler)
    }
    func followUsers(uids: [String], _ roomId: String? = nil, handler: @escaping (String?) -> Void) {
        submitFollow(uids: uids, type: 1, roomId: roomId, handler: handler)
    }
    func followUser(uid: String, _ roomId: String? = nil, handler: @escaping (String?) -> Void) {
        followUsers(uids: [uid], roomId, handler: handler)
    }
    func unfollowUsers(uids: [String], _ roomId: String? = nil, handler: @escaping (String?) -> Void) {
        submitFollow(uids: uids, type: 2, roomId: roomId, handler: handler)
    }
    func unfollowUser(uid: String, _ roomId: String? = nil, handler: @escaping (String?) -> Void) {
        unfollowUsers(uids: [uid], roomId, handler: handler)
    }
}
