//
//  MOLineViewModel.swift
//  MiMoLive
//
//  Created by OneeChan on 2025/9/23.
//

import Foundation

extension MOLiveViewModel {
    var curLineRoomId: String? {
        lineViewModel?.curLineRoomId
    }
}

extension MOLiveManager {
    static var curLineViewModel: MOLineViewModel? {
        curLive?.lineViewModel
    }
}

@objc
enum LineState: Int {
    case none
    case matching_line
    case matching_pk
    case lining
}

@objc
protocol MOLineViewModelDelegate {
    @objc optional func onLineStateChanged(state: LineState)
    @objc optional func onLineSettingChanged()
    @objc optional func onLineJoinFailed(viewModel: MOLineViewModel)
    @objc optional func onLineInfoChange(viewModel: MOLineViewModel)
    @objc optional func onLineUserMuteChange(viewModel: MOLineViewModel, user: MOLineMember)
}

@objcMembers
class MOLineViewModel: NSObject {
    let curLineRoomId: String
    private let agoraToken: String
    
    // 重试配置
    private var lineInfoRetryTime = 0
    private var joinLineRetryTime = 0
    
    // Line 拉取到的相关信息
    private var hasJoinedChannel = false
    private(set) var lineRoomInfo: MOLivePkLinkRoomInfoVo? = nil
    var curLineTime: Int {
        guard let info = lineRoomInfo else {
            return 0
        }
        let hasPass = Date().timeIntervalSince1970 - info.now
        let time = Int(hasPass * 1000) + info.serviceTime - info.linkBeginTime
        
        return time / 1000
    }
    var isCreator: Bool {
        lineRoomInfo?.initiatorId == UserDefaults.uid
    }
    private var members: [MOLineMember] = []
    private var campMembers: [String: [MOLineMember]] = [:] // members 的 map 化
    var curOwnerInfo: MOLineMember? {
        guard let ownerUid = MOLiveManager.curLive?.ownerUid else { return nil }
        return members.first { $0.userId == ownerUid }
    }
    var curPeerInfo: MOLineMember? {
        guard let ownerUid = MOLiveManager.curLive?.ownerUid else { return nil }
        if members.count == 2 { // 如果只有两个人，不需要考虑阵营的问题
            return members.first { $0.userId != ownerUid }
        } else {
            let ownerCampCode = members.first { $0.userId == ownerUid }?.pkCampCode
            return members.first { $0.pkCampCode != ownerCampCode }
        }
    }
    
    // Line 状态
    private(set) static var matchTime: TimeInterval = 0
    private(set) static var curState: LineState = .none {
        didSet { notifyLineStateChanged() }
    }
    
    // Pk 玩法
    private(set) var curPKViewModel: MOLinePKViewModel? = nil
    
    // Line 配置
    private(set) static var lineConfig: MOLivePkLinkConfigVo = MOLivePkLinkConfigVo() {
        didSet {
            notifyLineSettingChanged()
        }
    }
    
    init(lineRoomId: String, token: String) {
        self.curLineRoomId = lineRoomId
        self.agoraToken = token
        super.init()
        
        MOEventDeliver.addObserver(self)
        
        joinLineChannel()
        getLineInfo()
    }
    
    deinit {
        clear()
    }
    
    func clear() {
        guard Self.curState != .none else { return }
        
        curPKViewModel?.clear()
        curPKViewModel = nil
        MOShowAgoraKitManager.share().leavePkChannelEx(withChannelId: curLineRoomId)
        Self.curState = .none
    }
    
    func handleLinePkRtm(_ statusInfo: MORtmPkV2Status) {
        if statusInfo.linkClose {
            // line 结束
            clear()
            return
        }
        updateMembers(statusInfo)
        checkPkInfo(statusInfo)
    }
    
    func handleLinePkExpandRtm(_ info: MORtmPkV2StatusExpand) {
        curPKViewModel?.handleTopUsersUpdate(info)
    }
    
    func reloadLineRoomInfo() {
        guard !curLineRoomId.isEmpty, !agoraToken.isEmpty else { return }
        
        MOHttpManager.shared().getLineRoomInfo(curLineRoomId) { [weak self] roomInfo, error in
            guard let self else { return }
            
            guard let roomInfo, error == nil else {
                return
            }
            if roomInfo.roomClose {
                return
            }
            self.lineRoomInfo = roomInfo
            self.updateMembers(roomInfo)
            self.checkPkInfo(roomInfo)
        }
    }
}

// MARK: Private 私有方法
extension MOLineViewModel {
    private func updateMembers(_ roomInfo: MOLivePkLinkRoomInfoVo) {
        let newUsers = roomInfo.members.map { $0.userId }

        self.members.removeAll { !newUsers.contains($0.userId) } // 移除不在新名单的用户信息
        
        roomInfo.members.forEach { info in
            if let member = self.members.first(where: { $0.userId == info.userId }) {
                let isMute = member.mute
                member.updateBy(info: info)
                if info.mute != isMute {
                    notifyLineUserMuteChanged(user: member)
                }
            } else {
                let member = MOLineMember()
                member.updateBy(info: info)
                self.members.append(member)
            }
        }
        // 更新 map
        self.campMembers = self.members.reduce(into: [String: [MOLineMember]](), { partialResult, info in
            partialResult[info.pkCampCode, default: []].append(info)
        })
        
        notifyLineInfoChanged()
    }
    
    private func updateMembers(_ statusInfo: MORtmPkV2Status) {
        let newUsers = statusInfo.linkMemberInfos.map { $0.userId }

        self.members.removeAll { !newUsers.contains($0.userId) } // 移除不在新名单的用户信息
        
        statusInfo.linkMemberInfos.forEach { info in
            if let member = self.members.first(where: { $0.userId == info.userId }) {
                member.updateBy(linkInfo: info)
            } else {
                let member = MOLineMember()
                member.updateBy(linkInfo: info)
                self.members.append(member)
            }
        }
        // 更新 map
        self.campMembers = self.members.reduce(into: [String: [MOLineMember]](), { partialResult, info in
            partialResult[info.pkCampCode, default: []].append(info)
        })
        
        notifyLineInfoChanged()
    }
    
    private func checkPkInfo(_ roomInfo: MOLivePkLinkRoomInfoVo) {
        if roomInfo.type == .line {
            if MOLiveManager.curLive?.isOwner != true, // 自己开播不需要处理上一次的记录
               roomInfo.lastPkAvailable() == true {
                if curPKViewModel == nil {
                    curPKViewModel = MOLinePKViewModel(pkMatchId: "")
                }
            }
        } else if roomInfo.type == .linePk {
            if curPKViewModel?.pkMatchId != roomInfo.pkMatchId {
                curPKViewModel?.clear()
                curPKViewModel = nil
                curPKViewModel = MOLinePKViewModel(pkMatchId: roomInfo.pkMatchId)
            }
        }
        curPKViewModel?.updateInfo(roomInfo: roomInfo)
    }
    
    private func checkPkInfo(_ statusInfo: MORtmPkV2Status) {
        curPKViewModel?.updateInfo(statusInfo: statusInfo)
    }
    
    private func preloadImageToCache() {
        // 提前加载图片资源
        DispatchQueue.global().async {
            let webpNames: [String] = ["icon_line_pk_start", "icon_line_pk_draw",
                                       "icon_line_pk_defeat", "icon_line_pk_vic"]
            let urls: [URL] = webpNames.compactMap {
                guard let path = Bundle.main.path(forResource: $0, ofType: "webp") else { return nil }
                return URL(fileURLWithPath: path)
            }
            urls.forEach {
                SDWebImageManager.shared.loadImage(with: $0, progress: nil)
                { _, _, _, type, finished, _ in
                    
                }
            }
        }
    }
}

// MARK: Line 查询以及频道加入
extension MOLineViewModel {
    @objc
    private func joinLineChannel() {
        guard !curLineRoomId.isEmpty, !agoraToken.isEmpty else { return }
        //将要渲染的PK对象
        let peerId = 0
        
        MOShowAgoraKitManager.share().joinChannel(withTargetChannelId: curLineRoomId
                                                  , ownerId: peerId, token: agoraToken,
                                                  delegate: nil)
        { [weak self] success, code in
            guard let self else { return }
            
            if success || code == -17 {
                //-17错误码代表已经进入了同一个房间，直接按成功处理即可
                self.hasJoinedChannel = true
                self.joinLineRetryTime = 0
                self.checkIfLineSuccess()
                return
            }
            
            // 失败
            if self.joinLineRetryTime > 2 {
                self.handleJoinLineFailed()
                return
            }
            self.joinLineRetryTime += 1
            
            //离开房间, 然后再次加入试试
            MOShowAgoraKitManager.share().leavePkChannelEx(withChannelId: self.curLineRoomId)
            self.perform(#selector(joinLineChannel), afterDelay: 0.3)
        }
    }
    
    @objc
    private func getLineInfo() {
        guard !curLineRoomId.isEmpty, !agoraToken.isEmpty else { return }
        
        MOHttpManager.shared().getLineRoomInfo(curLineRoomId) { [weak self] roomInfo, error in
            guard let self else { return }
            
            guard let roomInfo, error == nil else {
                // 失败
                if self.lineInfoRetryTime > 2 {
                    self.handleJoinLineFailed()
                    return
                }
                self.lineInfoRetryTime += 1
                self.perform(#selector(getLineInfo), afterDelay: 0.3)
                return
            }
            if roomInfo.roomClose {
                // Line 房间已经关闭，TODO: 当作失败处理(有待讨论)
                handleJoinLineFailed()
                return
            }
            self.lineRoomInfo = roomInfo
            self.lineInfoRetryTime = 0
            self.checkIfLineSuccess()
        }
    }
    
    private func checkIfLineSuccess() {
        guard let lineRoomInfo, hasJoinedChannel else { return }
        
        // 此时已经 joinChannel & getInfo 成功
        self.updateMembers(lineRoomInfo)
        Self.curState = .lining
        self.checkPkInfo(lineRoomInfo)
        self.preloadImageToCache()
    }
    
    private func handleJoinLineFailed() {
        MOShowAgoraKitManager.share().leavePkChannelEx(withChannelId: curLineRoomId)
        
        self.notifyLineJoinFailed()
    }
}

// MARK: Line 音频控制
extension MOLineViewModel {
    func mutePeerHost(_ mute: Bool, _ handler: @escaping (Bool) -> Void) {
        guard let peer = curPeerInfo else { return }
        MOHttpManager.shared().updateSoundControl(curLineRoomId, userIds: [peer.userId],
                                                  mute: mute, forAll: false) { err in
            guard err == nil else {
                showNetError(err: err)
                handler(false)
                return
            }
            handler(true)
        }
    }
}

// MARK: Line 配置
extension MOLineViewModel {
    static func getLineConfig() {
        MOHttpManager.shared().getLinePkConfig { info, error in
            guard error == nil else {
                showNetError(err: error)
                return
            }
            guard let info else { return }
            self.lineConfig = info
        }
    }
    
    static func updateLinePkTime(_ duration: Int, _ handler: @escaping (Bool) -> Void) {
        updateLineConfig(duration: duration, handler)
    }
    
    static func updateAcceptPk(_ canAcceptPk: Bool, _ handler: @escaping (Bool) -> Void) {
        updateLineConfig(canAcceptPk: canAcceptPk, handler)
    }
    
    static func updateAcceptLine(_ canAcceptLink: Bool, _ handler: @escaping (Bool) -> Void) {
        updateLineConfig(canAcceptLink: canAcceptLink, handler)
    }
    
    private static func updateLineConfig(duration: Int = lineConfig.duration,
                                         canAcceptPk: Bool = lineConfig.canAcceptPk,
                                         magnifyMySelf: Bool = lineConfig.magnifyMySelf,
                                         canAcceptLink: Bool = lineConfig.canAcceptLink,
                                         _ handler: @escaping (Bool) -> Void) {
        MOHttpManager.shared().updateLinePkConfig(duration: duration,
                                                  canAcceptPk: canAcceptPk,
                                                  magnifyMySelf: magnifyMySelf,
                                                  canAcceptLink: canAcceptLink)
        { error in
            guard error == nil else {
                showNetError(err: error)
                handler(false)
                return
            }
            self.lineConfig.duration = duration
            self.lineConfig.canAcceptPk = canAcceptPk
            self.lineConfig.magnifyMySelf = magnifyMySelf
            self.lineConfig.canAcceptLink = canAcceptLink
            handler(true)
            Self.notifyLineSettingChanged()
        }
    }
    
    func updateLineShowValue(showValue: Bool, _ handler: @escaping (Bool) -> Void) {
        guard let info = lineRoomInfo else {
            handler(false)
            return
        }
        MOHttpManager.shared().updateLineRoomConfig(info.pkLinkRoomId,
                                                    showValue: showValue,
                                                    allowJoin: info.allowJoin,
                                                    allowInvite: info.allowInvite) { [weak self] error in
            guard let self else { return }
            guard error == nil else {
                showNetError(err: error)
                handler(false)
                return
            }
            self.lineRoomInfo?.showValue = showValue
            handler(true)
        }
    }
    
    func updateLineAllowJoin(allowJoin: Bool, _ handler: @escaping (Bool) -> Void) {
        guard let info = lineRoomInfo else {
            handler(false)
            return
        }
        MOHttpManager.shared().updateLineRoomConfig(info.pkLinkRoomId,
                                                    showValue: info.showValue,
                                                    allowJoin: allowJoin,
                                                    allowInvite: info.allowInvite) { [weak self] error in
            guard let self else { return }
            guard error == nil else {
                showNetError(err: error)
                handler(false)
                return
            }
            self.lineRoomInfo?.allowJoin = allowJoin
            handler(true)
        }
    }
    
    func updateLineAllowInvite(allowInvite: Bool, _ handler: @escaping (Bool) -> Void) {
        guard let info = lineRoomInfo else {
            handler(false)
            return
        }
        MOHttpManager.shared().updateLineRoomConfig(info.pkLinkRoomId,
                                                    showValue: info.showValue,
                                                    allowJoin: info.allowJoin,
                                                    allowInvite: allowInvite) { [weak self] error in
            guard let self else { return }
            guard error == nil else {
                showNetError(err: error)
                handler(false)
                return
            }
            self.lineRoomInfo?.allowInvite = allowInvite
            handler(true)
        }
    }
    
    func cleanBeanValue() {
        MOHttpManager.shared().cleanLineRoomBeans(curLineRoomId) { error in
            guard error == nil else {
                showNetError(err: error)
                return
            }
        }
    }
}

// MARK: Line 操作
extension MOLineViewModel {
    // 随机连线
    static func startLineMatch(_ lineType: LineType, _ handler: ((Bool) -> Void)? = nil) {
        guard let roomId = MOLiveManager.curRoomId,
              !roomId.isEmpty,
              curState == .none else {
            handler?(false)
            return
        }
        matchTime = Date().timeIntervalSince1970
        curState = lineType == .line ? .matching_line : .matching_pk
        MOHttpManager.shared().matchLine(roomId, lineType) { error in
            guard error == nil else {
                showNetError(err: error)
                handler?(false)
                return
            }
            handler?(true)
        }
    }
    
    static func cancelMatch(handler: @escaping (Bool) -> Void) {
        guard let roomId = MOLiveManager.curRoomId,
              !roomId.isEmpty else {
            handler(false)
            return
        }
        guard curState != .none else {
            handler(false)
            return
        }
        let lineType: LineType?
        if curState == .matching_pk {
            lineType = .linePk
        } else if curState == .matching_line {
            lineType = .line
        } else {
            lineType = nil
        }
        guard let lineType else {
            handler(false)
            return
        }
        MOHttpManager.shared().cancelMatch(roomId, lineType) { error in
            guard error == nil else {
                showNetError(err: error)
                handler(false)
                return
            }
            curState = .none
            matchTime = 0
            handler(true)
        }
    }
    
    // 邀请连线
    static func inviteLineUser(_ peerRoomId: String, _ lineType: LineType, _ handler: ((Bool) -> Void)? = nil) {
        guard let roomId = MOLiveManager.curRoomId,
              !roomId.isEmpty else {
            handler?(false)
            return
        }
        MOHttpManager.shared().inviteLine(roomId, peerRoomId, lineType) { error in
            guard error == nil else {
                showNetError(err: error)
                handler?(false)
                return
            }
            
            handler?(true)
        }
    }
    
    static func responseLineInvite(inviteId: String, accept: Bool, handler: @escaping (Bool) -> Void) {
        MOHttpManager.shared().responseLineInvite(inviteId, accept) { error in
            guard error == nil else {
                showNetError(err: error)
                handler(false)
                return
            }
            
            handler(true)
        }
    }
    
    func closeLine(handler: @escaping (Bool) -> Void) {
        MOHttpManager.shared().closeLine(self.curLineRoomId) { [weak self] error in
            guard let self else { return }
            guard error == nil else {
                showNetError(err: error)
                handler(false)
                return
            }
            
            handler(true)
            
            self.clear()
        }
    }
}

// MARK: PK 相关
extension MOLineViewModel {
    func startPk(_ handler: ((Bool) -> Void)? = nil) {
        MOHttpManager.shared().startPk(curLineRoomId) { error in
            if error != nil {
                showNetError(err: error)
                handler?(false)
                return
            }
            handler?(true)
        }
    }
}

// MARK: Line 列表
extension MOLineViewModel {
    static func loadLineMatchUsers(_ next: String? = nil, _ key: String = "", _ handler: @escaping (MONextVOLivePkLinkInviteVO?, Bool) -> Void) {
        MOHttpManager.shared().getLineInviteList(next: next ?? "", size: 50, searchKey: key) { list, error in
            if error != nil || list == nil {
                showNetError(err: error)
            }
            handler(list, list?.list.count ?? 0 >= 50)
        }
    }
    
    static func loadLinePkMatchUsers(_ next: String? = nil, _ key: String = "", _ handler: @escaping (MONextVOLivePkLinkInviteVO?, Bool) -> Void) {
        MOHttpManager.shared().getLinePkInviteList(next: next ?? "", size: 50, searchKey: key) { list, error in
            if error != nil || list == nil {
                showNetError(err: error)
            }
            handler(list, list?.list.count ?? 0 >= 50)
        }
    }
    
    static func searchLineMatchUser(_ keywork: String, _ handler: @escaping (MONextVOLivePkLinkInviteVO?) -> Void) {
        handler(nil)
    }
    
    static func loadPkHistory(_ category: LinePkHistoryType, next: String? = nil, _ handler: @escaping (MONextVOLivePkV2RecordVo?, Bool) -> Void) {
        MOHttpManager.shared().getLinePkHistory(historyType: category, next: next ?? "", size: 50) { list, error in
            if error != nil || list == nil {
                showNetError(err: error)
            }
            handler(list, list?.list.count ?? 0 >= 50)
        }
    }
}

extension MOLineViewModel: MOLinePKViewModelDelegate {
    func onLinePkStateChanged(viewModel: MOLinePKViewModel, state: LinePKState) {
        if state == .none {
            curPKViewModel?.clear()
            curPKViewModel = nil
        }
    }
}

// MARK: 通知发送
extension MOLineViewModel {
    private static func notifyLineStateChanged() {
        MOEventDeliver.notifyEvent { $0.onLineStateChanged?(state: curState) }
    }
    
    private func notifyLineJoinFailed() {
        MOEventDeliver.notifyEvent { $0.onLineJoinFailed?(viewModel: self) }
    }
    
    private static func notifyLineSettingChanged() {
        MOEventDeliver.notifyEvent { $0.onLineSettingChanged?() }
    }
    
    private func notifyLineInfoChanged() {
        MOEventDeliver.notifyEvent { $0.onLineInfoChange?(viewModel: self) }
    }
    
    private func notifyLineUserMuteChanged(user: MOLineMember) {
        MOEventDeliver.notifyEvent { $0.onLineUserMuteChange?(viewModel: self, user: user) }
    }
}
