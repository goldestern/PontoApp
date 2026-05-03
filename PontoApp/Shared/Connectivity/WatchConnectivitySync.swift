import Foundation

#if canImport(WatchConnectivity)
import WatchConnectivity

final class WatchConnectivitySync: NSObject, TimeClockSyncing, WCSessionDelegate {
    var onArchiveReceived: ((PunchArchive) -> Void)?

    private let encoder: JSONEncoder
    private let decoder: JSONDecoder

    private var session: WCSession? {
        WCSession.isSupported() ? WCSession.default : nil
    }

    override init() {
        let encoder = JSONEncoder()
        encoder.dateEncodingStrategy = .iso8601
        self.encoder = encoder

        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        self.decoder = decoder

        super.init()
    }

    func activate() {
        guard let session else { return }
        session.delegate = self
        session.activate()
    }

    func send(archive: PunchArchive) {
        guard let session, let data = encode(archive: archive) else { return }

        do {
            try session.updateApplicationContext(["payload": data])
        } catch {
            session.transferUserInfo(["payload": data])
        }

        if session.isReachable {
            session.sendMessageData(data, replyHandler: nil, errorHandler: nil)
        }
    }

    func session(
        _ session: WCSession,
        activationDidCompleteWith activationState: WCSessionActivationState,
        error: Error?
    ) {}

    #if os(iOS)
    func sessionDidBecomeInactive(_ session: WCSession) {}

    func sessionDidDeactivate(_ session: WCSession) {
        session.activate()
    }
    #endif

    func session(_ session: WCSession, didReceiveApplicationContext applicationContext: [String: Any]) {
        receivePayload(from: applicationContext)
    }

    func session(_ session: WCSession, didReceiveUserInfo userInfo: [String: Any] = [:]) {
        receivePayload(from: userInfo)
    }

    func session(_ session: WCSession, didReceiveMessageData messageData: Data) {
        deliver(data: messageData)
    }

    private func encode(archive: PunchArchive) -> Data? {
        try? encoder.encode(archive)
    }

    private func receivePayload(from dictionary: [String: Any]) {
        guard let data = dictionary["payload"] as? Data else { return }
        deliver(data: data)
    }

    private func deliver(data: Data) {
        guard let archive = try? decoder.decode(PunchArchive.self, from: data) else { return }
        DispatchQueue.main.async { [weak self] in
            self?.onArchiveReceived?(archive)
        }
    }
}
#else
typealias WatchConnectivitySync = NullTimeClockSync
#endif
