#!/usr/bin/env jruby

include Java
import java.awt.TrayIcon
import java.awt.Toolkit
import javax.imageio.ImageIO
import java.io.File;

class Dtime # terrible hack-job prototype

  def self.run
    popup = java.awt.PopupMenu.new

    dtime_in_menu = java.awt.MenuItem.new("")
    popup.add(dtime_in_menu)

    exititem = java.awt.MenuItem.new("Exit")
    exititem.add_action_listener { java.lang.System::exit(0) }
    popup.add(exititem)

    image = java.awt.image.BufferedImage.new(18, 18, java.awt.image.BufferedImage::TYPE_INT_RGB)
    g = image.getGraphics()
    font = java.awt.Font.new("Verdana", java.awt.Font::BOLD, 11)
    g.setFont(font)
    g.setColor(java.awt.Color.new(200, 200, 200))

    tray_icon = TrayIcon.new(image, "DTIME!", popup)
    tray_icon.image_auto_size = true
    tray = java.awt.SystemTray::system_tray
    tray.add(tray_icon)
    
    old_dtime = nil

    while sleep 0.4
      dtime_info = Dtime.dtime_info
      dtime_hours = Dtime.current_dtime_formatted_hours(dtime_info)

      if dtime_hours != old_dtime
        g.clearRect(0, 0, 100, 100)
        g.drawString(dtime_hours, 1, 13)
        tray_icon.setImage(image)
      end

      current_dtime = Dtime.current_dtime_formatted(dtime_info)
      tray_icon.setToolTip(current_dtime)
      dtime_in_menu.setLabel(current_dtime)

      old_dtime = dtime_hours
    end
  end

  def self.current_dtime
    (ms_today * 1000 / 864).to_i
  end

  def self.dtime_info
    dtime = self.current_dtime
    {
      :seconds => dtime % 100,
      :minutes => (dtime / 100) % 10,
      :hours => dtime / 1000
    }      
  end

  def self.current_dtime_formatted(now=nil)
    now ||= dtime_components
    "#{"%02d" % now[:hours]}:#{now[:minutes]}:#{"%02d" % now[:seconds]}"
  end

  def self.current_dtime_formatted_hours(now=nil)
    now ||= dtime_components
    "%02d" % now[:hours]
  end

  private

  def self.ms_today
    now = Time.now
    now.to_f - Time.local(now.year, now.month, now.day, 0).to_f
  end

end

Dtime.run
