import Testing
@testable import AetherEngine

@Suite("AirPlay: an audio interruption from another app is not the end of AirPlay")
struct AirPlayInterruptionTests {

    @Test("a false external-playback edge while the receiver holds the route is held")
    func interruptionEdgeHeld() {
        #expect(AetherEngine.externalPlaybackEndIsHeldByRoute(
            active: false, airPlayActive: true, wirelessAirPlayRoute: true))
    }

    @Test("the edge is not held once the route left the receiver, or when AirPlay was never active")
    func realEndNotHeld() {
        #expect(!AetherEngine.externalPlaybackEndIsHeldByRoute(
            active: false, airPlayActive: true, wirelessAirPlayRoute: false))
        #expect(!AetherEngine.externalPlaybackEndIsHeldByRoute(
            active: false, airPlayActive: false, wirelessAirPlayRoute: true))
        #expect(!AetherEngine.externalPlaybackEndIsHeldByRoute(
            active: true, airPlayActive: true, wirelessAirPlayRoute: true))
    }

    @Test("a held end stands only when neither the player nor the route still points at the receiver")
    func heldEndStands() {
        #expect(AetherEngine.heldExternalPlaybackEndStands(externalPlaybackActive: false, wirelessAirPlayRoute: false))
        #expect(!AetherEngine.heldExternalPlaybackEndStands(externalPlaybackActive: false, wirelessAirPlayRoute: true))
        #expect(!AetherEngine.heldExternalPlaybackEndStands(externalPlaybackActive: true, wirelessAirPlayRoute: false))
    }

    @Test("a backgrounded native session on a wireless receiver may resume when the interruption ends")
    func backgroundResumeOnReceiver() {
        let safe = AetherEngine.interruptionResumeIsBackgroundSafe(
            backgrounded: true, ownsAudioPath: false, nativeOnWirelessReceiver: true)
        #expect(safe)
        #expect(AetherEngine.interruptionEndShouldPlay(
            armed: true, shouldResume: true, deferredPlay: false, backgroundSafe: safe))
    }

    @Test("a backgrounded native session with the picture on this device still does not resume unseen")
    func backgroundResumeLocal() {
        #expect(!AetherEngine.interruptionResumeIsBackgroundSafe(
            backgrounded: true, ownsAudioPath: false, nativeOnWirelessReceiver: false))
        #expect(AetherEngine.interruptionResumeIsBackgroundSafe(
            backgrounded: false, ownsAudioPath: false, nativeOnWirelessReceiver: false))
        #expect(AetherEngine.interruptionResumeIsBackgroundSafe(
            backgrounded: true, ownsAudioPath: true, nativeOnWirelessReceiver: false))
    }
}
