#!/usr/bin/env jruby

include Java
import java.awt.TrayIcon
import javax.imageio.ImageIO

class Dtime

  def self.run
    popup = java.awt.PopupMenu.new

    dtime_in_menu = java.awt.MenuItem.new("")
    popup.add(dtime_in_menu)

    exititem = java.awt.MenuItem.new("Exit")
    exititem.add_action_listener { java.lang.System::exit(0) }
    popup.add(exititem)

    image = java.awt.image.BufferedImage.new(18, 18, java.awt.image.BufferedImage::TYPE_INT_RGB)
    image_width = image.getWidth
    image_height = image.getHeight

    g = image.getGraphics
    font = java.awt.Font.new("Verdana", java.awt.Font::BOLD, 11)
    g.setFont(font)
    g.setColor(java.awt.Color.new(200, 200, 200))

    tray_icon = TrayIcon.new(image, "DTIME!", popup)
    tray_icon.image_auto_size = true
    tray = java.awt.SystemTray::system_tray
    tray.add(tray_icon)
    
    old = {}
    old_bar_width = nil

    while sleep 0.4
      now = Dtime.dtime_now_hash

      if old[:seconds] != now[:seconds]
        if old[:hours] != now[:hours]
          g.clearRect(0, 0, 100, 100)
          dtime_hours_formatted = "%02d" % now[:hours]
          g.drawString(dtime_hours_formatted, 1, 13)
        end

        bar_width = ((now[:minutes] * 100 + now[:seconds]) * image_width / (100.0 * 10.0)).ceil

        if bar_width != old_bar_width
          bar_height = (image_height / 10.0).ceil
          g.fillRect(0, image_height - bar_height, bar_width, bar_height)

          tray_icon.setImage(image)
          old_bar_width = bar_width
        end
      end
      
      current_dtime_formatted = "#{"%02d" % now[:hours]}:#{now[:minutes]}:#{"%02d" % now[:seconds]}"
      tray_icon.setToolTip(current_dtime_formatted)
      dtime_in_menu.setLabel(current_dtime_formatted)

      old = now
    end
  end

  def self.current_dtime
    now = Time.now
    ms_today = now.to_f - Time.local(now.year, now.month, now.day, 0).to_f
    (ms_today * 1000 / 864).to_i
  end

  def self.dtime_now_hash
    dtime = self.current_dtime
    {
      :seconds => dtime % 100,
      :minutes => (dtime / 100) % 10,
      :hours => dtime / 1000
    }      
  end
end

Dtime.run
