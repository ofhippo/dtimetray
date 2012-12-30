require 'dtime'

include Java
import java.awt.TrayIcon
import java.awt.Toolkit
import javax.imageio.ImageIO
import java.io.File;

popup = java.awt.PopupMenu.new
exititem = java.awt.MenuItem.new("Exit")
exititem.add_action_listener { java.lang.System::exit(0) }
popup.add(exititem)

image = ImageIO.read(File.new("blank.png"))
tray_icon = TrayIcon.new(image, "DTIME!", popup)
tray_icon.image_auto_size = true
tray = java.awt.SystemTray::system_tray
tray.add(tray_icon)

old_dtime = nil
while true
  dtime = Dtime.current_dtime_formatted_hours_only
  if dtime != old_dtime
    image = ImageIO.read(File.new("hours.png"))
    g = image.getGraphics()
    g.drawString(dtime, 1, 14)
    tray_icon.setImage(image)
  end

  old_dtime = dtime
end


