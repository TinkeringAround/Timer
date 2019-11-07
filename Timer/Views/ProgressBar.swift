import Cocoa

@IBDesignable
open class ProgressBar: NSView {
    
    // Attributes:
    var maxSeconds: Int = 0
    var seconds: Int = 0
    
    // ===================================================================
    public override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override open func draw(_ rect: CGRect) {
        super.draw(rect)
        drawProgressBar()
    }
    
    // ===================================================================
    func drawProgressBar() {
        NSColor.white.set()
        
        let barWidth = Math.map(minRange: 0, maxRange: maxSeconds, minDomain: 0, maxDomain: 12, value: seconds) // widthMax = 12
        
        let wrapper: NSRect = NSRect(x: 6, y: 5, width: 18, height: 12)
        let bar : NSRect = NSRect(x: 9, y: 8, width: barWidth, height: 6)
        
        let wrapperPath = NSBezierPath(roundedRect: wrapper, xRadius: 4, yRadius: 4)
        wrapperPath.lineWidth = 2
        wrapperPath.stroke()
        
        let barPath = NSBezierPath(roundedRect: bar, xRadius: 2, yRadius: 2)
        barPath.fill()
    }
    
    func start(seconds: Int) {
        self.maxSeconds = seconds
        self.seconds = seconds
    }
    
    func update(seconds: Int) {
        self.seconds = seconds
        self.display()
    }
}
