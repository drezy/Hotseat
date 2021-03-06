//
//  StatusMenuController.swift
//  Hotseat
//
//  Created by drezy on 12/11/17.
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
import Foundation

//class StatusMenuController: NSObject {
class StatusMenuController: NSViewController, PreferencesWindowDelegate {
    
    @IBOutlet weak var statusMenu: NSMenu!
    @IBAction func preferencesClicked(_ sender: Any) {
        preferencesWindow.showWindow(nil)
    }
    
    var preferencesWindow: PreferencesWindow!
    
    //var tableViewData =  [[String : Any]]()
    
    
//    var tableViewData = [["networkname":"netone","signal_strength":-61,"imageIcon":"NSStatusUnavailable"],]
    var powerlevel = 0
    var powerarray = [Int]()
    var statusImage = [
        NSImage(named: NSImage.Name(rawValue: "statusicon0bar")),
        NSImage(named: NSImage.Name(rawValue: "statusicon1bar")),
        NSImage(named: NSImage.Name(rawValue: "statusicon2bar")),
        NSImage(named: NSImage.Name(rawValue: "statusicon3bar")),
        ]
   
    let userDefaults = UserDefaults.standard
    let statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
    //let icon = NSImage(named: NSImage.Name(rawValue: "statusicon2bar"))
    //let icon2 = NSImage(named: NSImage.Name(rawValue: "statusicon"))
    var timer:Timer = Timer()
    
    override func awakeFromNib() {
        
        userDefaults.set(-50, forKey: "Level3")
        userDefaults.set(-60, forKey: "Level2")
        userDefaults.set(-70, forKey: "Level1")
        userDefaults.set(-90, forKey: "Level0")
        
        preferencesWindow = PreferencesWindow()
        
        statusItem.image = statusImage[0]
        statusItem.menu = statusMenu
    
        timer = Timer.scheduledTimer(timeInterval: 5, target: self,   selector: (#selector(StatusMenuController.updateView)), userInfo: nil, repeats: true)
    }
    
    func preferencesDidUpdate() {
        self.updateView()
    }
    
    func updateicon () {
        switch powerlevel {
        case -200..<userDefaults.integer(forKey:"Level0"):
            statusItem.image = statusImage[0]
        case userDefaults.integer(forKey:"Level0")..<userDefaults.integer(forKey:"Level1"):
            statusItem.image = statusImage[1]
        case userDefaults.integer(forKey:"Level1")..<userDefaults.integer(forKey:"Level2"):
            statusItem.image = statusImage[2]
        case userDefaults.integer(forKey:"Level2")..<0:
            statusItem.image = statusImage[3]

        default:
            statusItem.image = statusImage[0]
        }
    }
    
    @IBAction func quitClicked(sender: NSMenuItem) {
        NSApplication.shared.terminate(self)
    }
    
    @objc func updateView() {
        powerarray.removeAll()

        if let discovery =  Discovery() {
            if (discovery.networks.isEmpty) {
//                print ("empty")
                statusItem.image = statusImage[0]
            }
            else {
                for network in (discovery.networks) {
                    print(network.ssid!,network.rssiValue )
                    powerarray.append(network.rssiValue)
                    }
//                print ("highest signal =",powerarray.max()!)
                powerlevel = powerarray.max()!
                updateicon()
                    
                }
            }
        
    }
    
}




