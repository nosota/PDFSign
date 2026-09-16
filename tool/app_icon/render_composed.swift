// Renders an app's icon as macOS composes it, at 1024 px.
//
//     swift tool/app_icon/render_composed.swift <App.app> <out.png>
//
// macOS 26 draws an app icon on a tile of its own, and an icon authored in
// Icon Composer fills that tile. Asking the system for the icon is the only
// way to obtain what the reader actually sees, which is what the Windows icon
// and the Welcome screen logo are cut from.
//
// Ask about a copy at a path the system has not seen before: LaunchServices
// caches an icon per path and will otherwise hand back the previous one.
import Cocoa

let icon = NSWorkspace.shared.icon(forFile: CommandLine.arguments[1])
let size = 1024
icon.size = NSSize(width: size, height: size)
let rep = NSBitmapImageRep(bitmapDataPlanes: nil, pixelsWide: size, pixelsHigh: size,
  bitsPerSample: 8, samplesPerPixel: 4, hasAlpha: true, isPlanar: false,
  colorSpaceName: .deviceRGB, bytesPerRow: 0, bitsPerPixel: 0)!
NSGraphicsContext.saveGraphicsState()
NSGraphicsContext.current = NSGraphicsContext(bitmapImageRep: rep)
icon.draw(in: NSRect(x: 0, y: 0, width: size, height: size))
NSGraphicsContext.restoreGraphicsState()
try! rep.representation(using: .png, properties: [:])!
  .write(to: URL(fileURLWithPath: CommandLine.arguments[2]))
print("composed icon rendered at \(size)")
