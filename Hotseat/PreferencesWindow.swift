//
//  PreferencesWindow.swift
//  Hotseat
//
//  Created by drezy on 12/16/17.
//  Copyright © 2017 drezy
//
//Permission is hereby granted, free of charge, to any person obtaining a copy
//of this software and associated documentation files (the "Software"), to deal
//in the Software without restriction, including without limitation the rights
//to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//copies of the Software, and to permit persons to whom the Software is
//furnished to do so, subject to the following conditions:
//
//The above copyright notice and this permission notice shall be included in all
//copies or substantial portions of the Software.
//
//THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//SOFTWARE.

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
