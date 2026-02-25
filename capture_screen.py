import Quartz
import Quartz.CoreGraphics as CG
import Cocoa

def capture_screen(output_file):
    # Get main display ID
    main_display_id = CG.CGMainDisplayID()
    
    # Capture screen image
    image_ref = CG.CGDisplayCreateImage(main_display_id)
    
    if image_ref:
        # Create bitmap rep
        width = CG.CGImageGetWidth(image_ref)
        height = CG.CGImageGetHeight(image_ref)
        bitmap_rep = Cocoa.NSBitmapImageRep.alloc().initWithCGImage_(image_ref)
        
        # Create PNG data
        png_data = bitmap_rep.representationUsingType_properties_(Cocoa.NSPNGFileType, None)
        
        # Write to file
        png_data.writeToFile_atomically_(output_file, True)
        print(f"Captured to {output_file}")
        return True
    return False

if __name__ == "__main__":
    capture_screen("/tmp/sheet_snapshot.png")
