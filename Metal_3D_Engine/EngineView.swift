//
//  EngineView.swift
//  Metal_3D_Engine
//
//  Created by Adrian Krupa on 16.12.2015.
//  Copyright © 2015 Adrian Krupa. All rights reserved.
//

import MetalKit

class EngineView: MTKView {
    
    #if os(OSX)
    override var acceptsFirstResponder: Bool { return true }
    #else
    override func canBecomeFirstResponder() -> Bool { return true }
    #endif
    
    #if os(OSX)
    private func returnChar(theEvent: NSEvent) -> Character? {
        let s: String = theEvent.characters!
        for char in s.characters {
            return char
        }
        return nil
    }
    
    override func keyUp(theEvent: NSEvent) {
        Input.keys[Int(theEvent.keyCode)] = false;
    }
    
    override func keyDown(theEvent: NSEvent) {
        Input.keys[Int(theEvent.keyCode)] = true;
    }
    
    override func flagsChanged(theEvent: NSEvent) {
        Input.keys[Int(theEvent.keyCode)] = !Input.keys[Int(theEvent.keyCode)]
    }
    #else
    
    var firstTouch: UITouch? = nil;
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        print("touches began")
        firstTouch = touches.first
        let loc = firstTouch!.locationInView(self)
        Input.mousePosition = float2(Float(loc.x), Float(loc.y))
        Input.touchCount = touches.count
        
        /*
        NSUInteger numTaps = [[touches anyObject] tapCount];
        
        
        self.touchPhaseText.text = NSLocalizedString(@"Phase: Touches began", @"Phase label text for touches began");
        self.touchInfoText.text = @"";
        if (numTaps >= 2) {
        NSString *infoFormatString = NSLocalizedString(@"%d taps", @"Format string for info text for number of taps");
        self.touchInfoText.text = [NSString stringWithFormat:infoFormatString, numTaps];
        if ((numTaps == 2) && piecesOnTop) {
        // A double tap positions the three pieces in a diagonal.
        // The user will want to double tap when two or more pieces are on top of each other
        if (self.firstPieceView.center.x == self.secondPieceView.center.x)
        self.secondPieceView.center = CGPointMake(self.firstPieceView.center.x - 50, self.firstPieceView.center.y - 50);
        if (self.firstPieceView.center.x == self.thirdPieceView.center.x)
        self.thirdPieceView.center  = CGPointMake(self.firstPieceView.center.x + 50, self.firstPieceView.center.y + 50);
        if (self.secondPieceView.center.x == self.thirdPieceView.center.x)
        self.thirdPieceView.center  = CGPointMake(self.secondPieceView.center.x + 50, self.secondPieceView.center.y + 50);
        self.touchInstructionsText.text = @"";
        }
        }
        else {
        self.touchTrackingText.text = @"";
        }
        // Enumerate through all the touch objects.
        NSUInteger touchCount = 0;
        for (UITouch *touch in touches) {
        // Send to the dispatch method, which will make sure the appropriate subview is acted upon.
        [self dispatchFirstTouchAtPoint:[touch locationInView:self.view] forEvent:nil];
        touchCount++;
        }
        */
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        let loc = firstTouch?.locationInView(self)
        Input.mousePosition = float2(Float(loc?.x ?? 0), Float(loc?.y ?? 0))
        Input.touchCount = touches.count
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
    }
    
    override func touchesCancelled(touches: Set<UITouch>?, withEvent event: UIEvent?) {
        
    }
    
    #endif
    
    
}
