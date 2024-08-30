//
//  MDeviceProtection.swift
//  MoviesApp
//
//  Created by Ahmed Ali on 19/08/2024.
//

import UIKit
import MachO

class MDeviceProtection {
    static let shared = MDeviceProtection()
    
    private init() {}
    
    private let suspiciousPaths = ["/private/var/lib/apt",
                                   "/Applications/Cydia.app",
                                   "/private/var/lib/cydia",
                                   "/private/var/tmp/cydia.log",
                                   "/Applications/RockApp.app",
                                   "/Applications/Icy.app",
                                   "/Applications/WinterBoard.app",
                                   "/Applications/SBSetttings.app",
                                   "/Applications/blackra1n.app",
                                   "/Applications/IntelliScreen.app",
                                   "/Applications/Snoop-itConfig.app",
                                   "/usr/libexec/cydia/",
                                   "/usr/sbin/frida-server",
                                   "/usr/bin/cycript",
                                   "/usr/local/bin/cycript",
                                   "/usr/lib/libcycript.dylib",
                                   "/bin/sh",
                                   "/usr/libexec/sftp-server",
                                   "/usr/libexec/ssh-keysign",
                                   "/Library/MobileSubstrate/MobileSubstrate.dylib",
                                   "/bin/bash",
                                   "/usr/sbin/sshd",
                                   "/etc/apt",
                                   "/usr/bin/ssh",
                                   "/bin.sh",
                                   "/var/checkra1n.dmg",
                                   "/System/Library/LaunchDaemons/com.saurik.Cydia.Startup.plist",
                                   "/System/Library/LaunchDaemons/com.ikey.bbot.plist",
                                   "/Library/MobileSubstrate/DynamicLibraries/LiveClock.plist",
                                   "/Library/MobileSubstrate/DynamicLibraries/Veency.plist",
                                   "/etc/apt/sources.list.d/electra.list",
                                   "/etc/apt/sources.list.d/sileo.sources",
                                   "/.bootstrapped_electra",
                                   "/usr/lib/libjailbreak.dylib",
                                   "/jb/lzma",
                                   "/.cydia_no_stash",
                                   "/.installed_unc0ver",
                                   "/jb/offsets.plist",
                                   "/usr/share/jailbreak/injectme.plist",
                                   "/etc/apt/undecimus/undecimus.list",
                                   "/var/lib/dpkg/info/mobilesubstrate.md5sums",
                                   "/jb/jailbreakd.plist",
                                   "/jb/amfid_payload.dylib",
                                   "/jb/libjailbreak.dylib",
                                   "/usr/libexec/cydia/firmware.sh",
                                   "/var/lib/cydia",
                                   "/private/var/Users/",
                                   "/var/log/apt",
                                   "/private/var/stash",
                                   "/private/var/cache/apt/",
                                   "/private/var/log/syslog",
                                   "/Applications/FakeCarrier.app",
                                   "/Applications/MxTube.app",
                                   "/Applications/SBSettings.app",
                                   "/private/var/mobile/Library/SBSettings/Themes",
                                   "/Library/MobileSubstrate/CydiaSubstrate.dylib"]
}

extension MDeviceProtection {
    func isJailbreakDevice() -> Bool {
        isCydiaAppInstalled() || isJailBrokenFilesPresentInTheDirectory() || canEditSandboxFilesForJailBreakDetecttion() || isSuspiciousLibraryLoaded() || isFridaEnvironmentVariablePresent()
    }
}

private extension MDeviceProtection {
    func isCydiaAppInstalled() -> Bool {
        MLogger.output("isCydiaAppInstalled \(UIApplication.shared.canOpenURL(URL(string: "cydia://")!))")
        return UIApplication.shared.canOpenURL(URL(string: "cydia://")!)
    }
    
    func isJailBrokenFilesPresentInTheDirectory() -> Bool {
        let fm = FileManager.default
        for path in suspiciousPaths {
            if fm.fileExists(atPath: path.trim()) {
                MLogger.output("isJailBrokenFilesPresentInTheDirectory \(path)")
                return true
            }
        }
        return false
    }
    
    func canEditSandboxFilesForJailBreakDetecttion() -> Bool {
        do {
            try "Test for JailBreak".write(toFile:"/private/jailBreakTestText.txt", atomically: true, encoding: .utf8)
            MLogger.output("canEditSandboxFilesForJailBreakDetecttion write successful")
            return true
        } catch {
            return false
        }
    }
    
    func isSuspiciousLibraryLoaded() -> Bool {
        // Array of known suspicious libraries or patterns to check for
        let suspiciousLibraryPatterns = [
            "frida",        // Example: Frida related libraries
            "libinjector"   // Example: Other common library names
        ]
        
        // It returns the total number of dynamic libraries (images) currently loaded into the process. This count is used to iterate through the libraries.
        let libraryCount = _dyld_image_count()
        // This loop iterates over the range from 0 to libraryCount - 1, accessing each loaded library by its index.
        for index in 0..<libraryCount {
            //  It retrieves the name of the library at the specified index. Since this function returns an optional UnsafePointer<CChar>?, you use guard let to safely unwrap the optional. If the name cannot be retrieved (i.e., imageName is nil), the loop continues to the next index.
            guard let imageName = _dyld_get_image_name(index) else {
                continue
            }
            // Convert the C string to a Swift string
            let libraryName = String(cString: imageName)
            
            // This nested loop iterates over each pattern in suspiciousLibraryPatterns. It converts both libraryName and pattern to lowercase to perform a case-insensitive comparison.
            for pattern in suspiciousLibraryPatterns {
                if libraryName.lowercased().contains(pattern.lowercased()) {
                    MLogger.output("isSuspiciousLibraryLoaded \(libraryName)")
                    return true
                }
            }
        }
        
        return false
    }
    
    func isFridaEnvironmentVariablePresent() -> Bool {
        // This array contains names of environment variables that are commonly set by Frida or related tools.
        let environmentVariables = ["FRIDA", "FRIDA_SERVER"]
        // Fetches the current environment variables of the process.
        let environment = ProcessInfo.processInfo.environment
        // Iterates over the list of environment variables you are interested in.
        for variable in environmentVariables {
            // Checks if the environment variable is set (i.e., not nil).
            if environment[variable] != nil {
                MLogger.output("isFridaEnvironmentVariablePresent \(String(describing: environment[variable]))")
                return true
            }
        }
        return false
    }
}
