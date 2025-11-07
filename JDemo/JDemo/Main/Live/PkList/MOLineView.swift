//
//  MOLineView.swift
//  MiMoLive
//
//  Created by OneeChan on 2025/9/26.
//

import Foundation
import UIKit

@objcMembers
class MOLineView: UIView {
    //点击对方主播图层
    public var peerHostViewClickBlock:(() -> Void)?
    
    private let lineViewModel: MOLineViewModel
    
    private let hostsView = UIView()
    
    private let myHostView = UIView()
    private let myBeanView = MOLineBeanView()
    
    private let peerHostView = UIView()
    private let peerTopMenu = UIStackView()
    private let peerMuteIcon = UIImageView()
    private let peerHostBtn = UIButton()//对方主播图层点击按钮
    private let peerInfoView = MOLinePeerHostInfoView()
    private let peerBeanView = MOLineBeanView()
    private weak var pkView: MOLinePkView? = nil
    
    init(lineViewModel: MOLineViewModel) {
        self.lineViewModel = lineViewModel
        super.init(frame: .zero)
        
        MOEventDeliver.addObserver(self)
        
        setupViews()
        
        updateViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func alignTo(_ canvasView: UIView) {
        hostsView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.bottom.equalTo(canvasView)
        }
        myHostView.snp.remakeConstraints { make in
            make.leading.top.bottom.equalToSuperview()
            make.width.equalTo(canvasView)
        }
    }
}

extension MOLineView {
    private func adjustViewsByPkStateChanged(_ newState: LinePKState) {
        switch newState {
        case .none:
            if lineViewModel.lineRoomInfo?.showValue  == true {
                myBeanView.isHidden = false
                peerTopMenu.isHidden = false
            } else {
                myBeanView.isHidden = true
                peerTopMenu.isHidden = true
            }
            peerTopMenu.addArrangedSubview(peerBeanView)
            
            pkView?.removeFromSuperview()
            pkView = nil // 这里置为 nil 是为了在同一个 runloop 中需要创建新的 pkView
        case .pking, .draw:
            myBeanView.isHidden = true
            peerTopMenu.isHidden = false
            peerTopMenu.removeArrangedSubview(peerBeanView)
            peerBeanView.removeFromSuperview()
            
            setupPkViewIfNeed()
        case .punishing:
            myBeanView.isHidden = true
            peerTopMenu.isHidden = false
            peerTopMenu.removeArrangedSubview(peerBeanView)
            peerBeanView.removeFromSuperview()
            
            setupPkViewIfNeed()
        }
    }
}

extension MOLineView {
    @objc
    public func handleMuteClick() {
        var cur = lineViewModel.curPeerInfo?.mute ?? false
        cur.toggle()
        lineViewModel.mutePeerHost(cur) { [weak self] success in
            guard let self else { return }
            guard success else { return } // TODO: cwy 补充失败提示
            updateMuteState(self.lineViewModel.curPeerInfo?.mute ?? false)
        }
    }
    
    @objc
    private func handlePeerHostViewClick() {
        peerHostViewClickBlock?()
    }
}

extension MOLineView: MOLineViewModelDelegate {
    func onLineInfoChange(viewModel: MOLineViewModel) {
        guard viewModel == self.lineViewModel else { return }
        
        updateViews()
    }
    
    func onLineUserMuteChange(viewModel: MOLineViewModel, user: MOLineMember) {
        guard viewModel == self.lineViewModel else { return }
        updateCurPeerMute()
    }
}

extension MOLineView: MOLinePKViewModelDelegate {
    func onLinePkStateChanged(viewModel: MOLinePKViewModel, state: LinePKState) {
        adjustViewsByPkStateChanged(state)
    }
}

extension MOLineView: MOLinePeerHostInfoViewDelegate {
    func onLinePeerHostInfoViewClick(view: MOLinePeerHostInfoView) {
        peerHostViewClickBlock?()
    }
}

extension MOLineView {
    private func updateMuteState(_ isMute: Bool) {
        let name = isMute ? "icon_line_peer_mute" : "icon_line_peer_unmute"
        peerMuteIcon.image = .init(named: name)
    }
    
    private func updateCurPeerMute() {
        if let peerInfo = lineViewModel.curPeerInfo {
            let peefMuteState = peerInfo.mute
            let channelId = lineViewModel.curLineRoomId
            let peerHostAgoraId = peerInfo.agoraId
            MOShowAgoraKitManager.share().toMuteRemoteAudioStream(with: peefMuteState, channelId: channelId, and: peerHostAgoraId)
            updateMuteState(peefMuteState)
        }
    }
    
    private func updateViews() {
        let state = lineViewModel.curPKViewModel?.curState ?? .none
        adjustViewsByPkStateChanged(state)
        
        updateMuteState(lineViewModel.curPeerInfo?.mute ?? false)
        
        if let myHostInfo = lineViewModel.curOwnerInfo {
            myBeanView.update(myHostInfo.goldenBeanOnLink)
        }
        if let peerInfo = lineViewModel.curPeerInfo {
            peerBeanView.update(peerInfo.goldenBeanOnLink)
            peerInfoView.update(peerInfo.userId, peerInfo.avatar, peerInfo.userNickName)
        }
    }
}

extension MOLineView {
    private func setupViews() {
        let hostViews = buildHostViews()
        addSubview(hostViews)
    }
    
    private func buildHostViews() -> UIView {
        hostsView.addSubview(myHostView)
        myHostView.snp.makeConstraints { make in
            make.leading.top.bottom.equalToSuperview()
            make.width.equalTo(200)
        }
        
        hostsView.addSubview(myBeanView)
        myBeanView.snp.makeConstraints { make in
            make.leading.equalTo(myHostView).offset(8)
            make.top.equalTo(myHostView).offset(8)
        }
        
        hostsView.addSubview(peerHostView)
        peerHostView.snp.makeConstraints { make in
            make.trailing.top.bottom.equalToSuperview()
            make.leading.equalTo(myHostView.snp.trailing)
        }
        
        peerHostView.addSubview(peerHostBtn)
        peerHostBtn.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        peerHostBtn.addTarget(self, action: #selector(handlePeerHostViewClick), for: .touchUpInside)
        
        peerTopMenu.axis = .horizontal
        peerTopMenu.spacing = 4
        peerTopMenu.distribution = .fill
        peerTopMenu.alignment = .fill
        hostsView.addSubview(peerTopMenu)
        peerTopMenu.snp.makeConstraints { make in
            make.trailing.equalTo(peerHostView).offset(-8)
            make.top.equalTo(peerHostView).offset(8)
        }
        
        if MOLiveManager.curLive?.isOwner == true {
            peerTopMenu.addArrangedSubview(peerMuteIcon)
        }
        
        peerTopMenu.addArrangedSubview(peerBeanView)
        
        peerInfoView.delegate = self
        hostsView.addSubview(peerInfoView)
        peerInfoView.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-6)
            make.bottom.equalToSuperview().offset(-6)
            make.width.lessThanOrEqualTo(88)
        }
        
        return hostsView
    }
    
    private func setupPkViewIfNeed() {
        if pkView != nil { return }
        let view = MOLinePkView()
        addSubview(view)
        view.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(hostsView)
        }
        view.alignTo(hostsView)
        self.pkView = view
    }
}


//import SwiftUI
//
//struct MOLineViewPreview: UIViewRepresentable {
//    func makeUIView(context: Context) -> some UIView {
//        let viewModel = MOLineViewModel(lineRoomId: "123", token: "abc")
//        let view = UIView()
//        view.backgroundColor = .black
//        let list = MOLineView(lineViewModel: viewModel)
//        view.addSubview(list)
//        list.snp.makeConstraints { make in
//            make.edges.equalToSuperview()
//        }
//        
//        return view
//    }
//    
//    func updateUIView(_ uiView: UIViewType, context: Context) { }
//}
//
//#Preview {
//    MOLineViewPreview()
//}
//
