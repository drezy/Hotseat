//
//  PreferencesWindow.swift
//  Hotseat
//
//  Created by drezy on 12/16/17.
//  Copyright © 2017 drezy. All rights reserved.
//

import Cocoa

protocol PreferencesWindowDelegate {
    func preferencesDidUpdate()
}

class PreferencesWindow: NSWindowController, NSWindowDelegate  {

    @IBOutlet weak var bar0TextField: NSTextField!
    
    @IBOutlet weak var bar1TextField: NSTextField!
    
    @IBOutlet weak var bar2TextField: NSTextField!
    
    var delegate: PreferencesWindowDelegate?
    
    override func windowDidLoad() {
        super.windowDidLoad()
        self.window?.center()
        self.window?.makeKeyAndOrderFront(nil)
        NSApp.activate(ignoringOtherApps: true)

        // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
    }
    
    @IBAction func closeClicked(_ sender: Any) {
        self.close()
    }
    
    override var windowNibName : NSNib.Name? {
        return NSNib.Name("PreferencesWindow")
    }
    
    func windowWillClose(_ notification: Notification) {
        let defaults = UserDefaults.standard
        defaults.setValue(bar2TextField.intValue, forKey: "Level2")
        defaults.setValue(bar1TextField.intValue, forKey: "Level1")
        defaults.setValue(bar0TextField.intValue, forKey: "Level0")
        delegate?.preferencesDidUpdate()
    }
    
    
}
