import Foundation

protocol TimeClockSyncing: AnyObject {
    var onArchiveReceived: ((PunchArchive) -> Void)? { get set }

    func activate()
    func send(archive: PunchArchive)
}

final class NullTimeClockSync: TimeClockSyncing {
    var onArchiveReceived: ((PunchArchive) -> Void)?

    func activate() {}

    func send(archive: PunchArchive) {}
}
