//
//  LockBtn.swift
//  SchroedingerAlarm
//
//  Created by Monique Golnik on 26.01.22.
//

import Foundation
import SwiftUI

struct LockBtn: View {
    var active = false
    
    var body: some View {
        ZStack{
            if active {
                Image(systemName: "lock")
                    .foregroundColor(.green)
                    .font(.system(size: 80, weight: .ultraLight))
               
            } else {
                Image(systemName: "lock.slash")
                    .foregroundColor(.red)
                    .font(.system(size: 78, weight: .ultraLight))
            }
        }
    }
}
//TODO: 1. wenn aktiviert, dann werden die Benachrichtigungen aktiviert - wenn deaktivert, wird nur der Standort angezeigt
// 2. Erweiterung : nur wenn aktiviert, wird der Webserver abgefragt und Benachrichtigungen (bei Bewegung) angezeigt, wenn deaktiviert wird nur der letzte Standort angezeigt
