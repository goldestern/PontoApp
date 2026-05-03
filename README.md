# PontoApp

PontoApp is a SwiftUI time clock app for iPhone and Apple Watch. It lets users record clock-in, break start, break end, and clock-out events, keeping a local history and synchronizing records between devices.

[Portuguese version](README_PT-BR.md)

## iPhone Features

- Main dashboard with the current work status: off duty, working, on break, or shift finished.
- Contextual buttons that only show the valid actions for the current status, such as clock in, start break, return from break, or clock out.
- Daily summary with total worked time, break time, first clock-in, and last clock-out.
- Daily history with time, punch type, and the device where each record was created.
- Full history screen grouped by day.
- Options to delete today's records or the entire local history.

## Apple Watch Features

- Compact interface for quickly recording time from the wrist.
- Current work status display.
- Contextual buttons for clock in, break start, break end, and clock out.
- Quick summary of the hours worked during the day.
- Short list with the most recent records for the day.

## Synchronization

The app uses `WatchConnectivity` to synchronize records between iPhone and Apple Watch. When a punch is recorded on one device, the history is sent to the other device whenever a connection is available.

Deleted records are also synchronized through internal markers, preventing old records from reappearing after a delayed sync.

## Storage

Data is stored locally with `UserDefaults`, encoded as JSON. The app does not require an external server to work.

## Requirements

- iOS 17 or later.
- watchOS 10 or later.
- Xcode on macOS to build and install the app.

## Opening In Xcode

1. Open `PontoApp.xcodeproj`.
2. Select the `Ponto` target.
3. Configure your development team in `Signing & Capabilities`.
4. Run the app in an iPhone simulator or on an iPhone paired with an Apple Watch.
