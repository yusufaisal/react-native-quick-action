//
//  RNQuickActionManager.swift
//  RNQuickAction
//
//  Created by iSal on 10/02/23.
//  Copyright © 2023 react-native. All rights reserved.
//

@objc(RNShortcuts)
public class RNShortcuts: RCTEventEmitter {

    let quickActionShortcut = "quickActionShortcut"

    public override func startObserving() {
        Shortcuts.shared.delegate = self
    }

    public override func stopObserving() {
        Shortcuts.shared.delegate = nil
    }

    public override func supportedEvents() -> [String]! {
        return [
            quickActionShortcut
        ]
    }

    public override class func requiresMainQueueSetup() -> Bool {
        return true
    }

    @objc(setShortcuts:resolve:reject:)
    public func setShortcuts(shortcutItems: [[String: Any]],
                             resolve: RCTPromiseResolveBlock,
                             reject: RCTPromiseRejectBlock) {
        do {
            let shortcutItems = try Shortcuts.shared.setShortcuts(shortcutItems)
            resolve(shortcutItems)
        } catch {
            let error = NSError(domain: "RNQuickAction", code: 1)
            reject("1", "Unable to set shortcuts", error)
        }

    }

    @objc(getShortcuts:reject:)
    public func getShortcuts(resolve: @escaping RCTPromiseResolveBlock, reject: RCTPromiseRejectBlock) {
        Shortcuts.shared.getShortcuts { (shorcutItems) in
            resolve(shorcutItems)
        }
    }

    @objc(getInitialShortcut:reject:)
    public func getInitialShortcut(resolve: @escaping RCTPromiseResolveBlock, reject: RCTPromiseRejectBlock) {
        resolve(Shortcuts.shared.getInitialShortcut())
    }

    @objc
    public class func onQuickActionPress(_ shortcutItem: UIApplicationShortcutItem,
                                                   completionHandler: (Bool) ->Void) {
        Shortcuts.shared.performAction(forShortcutItem: shortcutItem)
    }
}

extension RNShortcuts: ShortcutsDelegate {
    func quickActionShortcut(_ item: ShortcutItem) {
        sendEvent(withName: quickActionShortcut, body: item)
    }
}
