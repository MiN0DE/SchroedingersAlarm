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
                Image(systemName: "lock.open")
                    .foregroundColor(.red)
                    .font(.system(size: 80, weight: .ultraLight))
            }
        }
    }
}
