import Foundation

extension AetherEngine {

    nonisolated static func externalPlaybackEndIsHeldByRoute(
        active: Bool, airPlayActive: Bool, wirelessAirPlayRoute: Bool
    ) -> Bool {
        !active && airPlayActive && wirelessAirPlayRoute
    }

    nonisolated static func heldExternalPlaybackEndStands(
        externalPlaybackActive: Bool, wirelessAirPlayRoute: Bool
    ) -> Bool {
        !externalPlaybackActive && !wirelessAirPlayRoute
    }

    nonisolated static func interruptionResumeIsBackgroundSafe(
        backgrounded: Bool, ownsAudioPath: Bool, nativeOnWirelessReceiver: Bool
    ) -> Bool {
        !backgrounded || ownsAudioPath || nativeOnWirelessReceiver
    }
}
