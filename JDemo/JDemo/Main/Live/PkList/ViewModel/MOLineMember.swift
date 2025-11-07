//
//  MOLineMember.swift
//  MiMoLive
//
//  Created by OneeChan on 2025/9/30.
//

import Foundation


@objcMembers
class MOLineMember: NSObject {
    private(set) var roomId: String = ""
    private(set) var userId: String = ""
    private(set) var userNo: String = ""
    private(set) var agoraId: Int = 0
    private(set) var userNickName: String = ""
    private(set) var avatar: String = ""
    // 主播在连线期间的-金豆收入-当前（可被清空）
    private(set) var goldenBeanOnLink: Double = 0
    // 主播在连线期间的-金豆收入-累计
    private(set) var goldenBeanOnLinkTotal: Double = 0
    private(set) var pkCampCode: String = ""
    private(set) var mute: Bool = false
    
    var isMe: Bool {
        userId == UserDefaults.uid
    }
    
    func updateBy(info: MOLivePkLinkRoomMemberVo) {
        roomId = info.roomId
        userId = info.userId
        userNo = info.userNo
        agoraId = info.agoraId
        userNickName = info.userNikName
        avatar = info.avatar
        goldenBeanOnLink = info.goldenBeanOnLink
        goldenBeanOnLinkTotal = info.goldenBeanOnLinkTotal
        pkCampCode = info.pkCampCode
        mute = info.mute
    }
    
    func updateBy(linkInfo: MORtmPkV2StatusLinkInfo) {
        userId = linkInfo.userId
        goldenBeanOnLink = linkInfo.goldenBeanOnLink
        pkCampCode = linkInfo.campCode
    }
}
