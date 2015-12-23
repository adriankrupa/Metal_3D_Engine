//
//  Input.swift
//  Metal_3D_Engine
//
//  Created by Adrian Krupa on 16.12.2015.
//  Copyright © 2015 Adrian Krupa. All rights reserved.
//

import Foundation
import simd

#if os(OSX)
    import Cocoa
#else
#endif

class Input {
    
    private static var mousePos = float2()
    
    static var mousePosition: float2 {
        get {
        #if os(OSX)
        let t = NSEvent.mouseLocation()
        return float2(Float(t.x), Float(t.y))
        #else
        return mousePos
        #endif
        }
        set {
            mousePos = newValue
        }
    }
    
    static var multiTouchEnabled = true
    
    static var touches: [Touch?] = [Touch?](count: 5, repeatedValue: Touch())
    
    static var touchSupported: Bool {
        #if os(OSX)
            return false
        #else
            return true
        #endif
    }
    
    static var touchCount: Int = 0
    
    static func GetTouch(index: Int) -> Touch {
        return touches[index]!
    }
    
    static func GetButton(button: MOUSE_BUTTON) -> Bool {
        #if os(OSX)
            return (NSEvent.pressedMouseButtons() << button.rawValue) & 1 == 1
        #else
            return false
        #endif
    }
    
    static func GetKey(key: KEYBOARD_BUTTON) -> Bool {
        return keys[keysToCharacter[key]!]
    }
    
    static var keys = [Bool](count: 256, repeatedValue: false)
    
    static let keysToCharacter:[KEYBOARD_BUTTON: Int] = [
        .KEY_SPACE: 49,
        .KEY_A: 0,
        .KEY_B: 11,
        .KEY_C: 8,
        .KEY_D: 2,
        .KEY_E: 14,
        .KEY_F: 3,
        .KEY_G: 5,
        .KEY_H: 4,
        .KEY_I: 34,
        .KEY_J: 38,
        .KEY_K: 40,
        .KEY_L: 37,
        .KEY_M: 46,
        .KEY_N: 45,
        .KEY_O: 31,
        .KEY_P: 35,
        .KEY_Q: 12,
        .KEY_R: 15,
        .KEY_S: 1,
        .KEY_T: 17,
        .KEY_U: 32,
        .KEY_V: 9,
        .KEY_W: 13,
        .KEY_X: 7,
        .KEY_Y: 16,
        .KEY_Z: 6,
        .KEY_LEFT_SHIFT: 56,
        .KEY_RIGHT_SHIFT: 60,
        .KEY_ARROW_LEFT: 123,
        .KEY_ARROW_RIGHT: 124,
        .KEY_ARROW_UP: 126,
        .KEY_ARROW_DOWN: 125
    ]
}

class Touch {
    
    enum TouchPhase {
        case Began
        case Moved
        case Stationary
        case Ended
        case Canceled
    }
    
    private var phase: TouchPhase = .Ended
    
}

enum MOUSE_BUTTON: Int {
    case LEFT = 0
    case RIGHT = 1
    case MIDDLE = 2
};

enum KEYBOARD_BUTTON: Character {
    case KEY_SPACE = " "
    case KEY_A = "a"
    case KEY_B = "b"
    case KEY_C = "c"
    case KEY_D = "d"
    case KEY_E = "e"
    case KEY_F = "f"
    case KEY_G = "g"
    case KEY_H = "h"
    case KEY_I = "i"
    case KEY_J = "j"
    case KEY_K = "k"
    case KEY_L = "l"
    case KEY_M = "m"
    case KEY_N = "n"
    case KEY_O = "o"
    case KEY_P = "p"
    case KEY_Q = "q"
    case KEY_R = "r"
    case KEY_S = "s"
    case KEY_T = "t"
    case KEY_U = "u"
    case KEY_V = "v"
    case KEY_W = "w"
    case KEY_X = "x"
    case KEY_Y = "y"
    case KEY_Z = "z"
    case KEY_LEFT_SHIFT = "⇧"
    case KEY_RIGHT_SHIFT = "⇑"
    case KEY_ARROW_LEFT = "←"
    case KEY_ARROW_RIGHT = "→"
    case KEY_ARROW_UP = "↑"
    case KEY_ARROW_DOWN = "↓"
};