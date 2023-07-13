//
// Bitmovin Player iOS SDK
// Copyright (C) 2023, Bitmovin GmbH, All Rights Reserved
//
// This source code and its use and distribution, is subject to the terms
// and conditions of the applicable license agreement.
//

import BitmovinPlayer
import BitmovinCollector
import CoreCollector
#if os(iOS)
import GoogleCast
#endif

// This sample showcases how the BitmovinPlayer could be used from within another Framework which wraps the Player.
public class PlayerWrapper {
    private let player: Player
    private let collector: BitmovinPlayerCollector
    
#if os(iOS)
    private var bitmovinCastManager: BitmovinCastManager
    // Bitmovin cast manger options
    private let bitmovinCastManagerOptions = BitmovinCastManagerOptions()
    // The namesapce for the message to send/receive. namespace must begin with "urn:x-cast:"
    private static var namespace = "urn:x-cast:com.mediakind.cast.media"
    // ID to communicate with receiver
    private static var applicationId = "5A468DEE"
#endif
    

    public init() {
        let playerConfig = PlayerConfig()
        playerConfig.key = "your license key"

        let analyticsConfig = BitmovinAnalyticsConfig(key: "your analytics key")

        self.player = PlayerFactory.create(playerConfig: playerConfig)
        self.collector = BitmovinPlayerCollector(config: analyticsConfig)
#if os(iOS)
        bitmovinCastManagerOptions.deviceDiscoveryMode = .castButtonInteraction
        bitmovinCastManagerOptions.applicationId = "5A468DEE"
        bitmovinCastManagerOptions.messageNamespace = PlayerWrapper.namespace
        bitmovinCastManagerOptions.enableBackgroundSessions = false
        BitmovinCastManager.initializeCasting(options: bitmovinCastManagerOptions)
        bitmovinCastManager = BitmovinCastManager.sharedInstance()
        let currentMediaStatus = bitmovinCastManager.currentMediaStatus
#endif
    }

    func setup() {
        collector.attachPlayer(player: player)
    }

    func play() {
        player.play()
    }
    
    
}
