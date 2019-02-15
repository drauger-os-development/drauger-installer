#!/usr/bin/env python3
# -*- coding: utf-8 -*-
#
#  splash.py
#  
#  Copyright 2019 Thomas Castleman <contact@draugeros.ml>
#  
#  This program is free software; you can redistribute it and/or modify
#  it under the terms of the GNU General Public License as published by
#  the Free Software Foundation; either version 2 of the License, or
#  (at your option) any later version.
#  
#  This program is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#  GNU General Public License for more details.
#  
#  You should have received a copy of the GNU General Public License
#  along with this program; if not, write to the Free Software
#  Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
#  MA 02110-1301, USA.
#  
#  
import gi
gi.require_version('Gtk', '3.0')
from gi.repository import Gtk, Gdk

class splash(Gtk.Window):
		def __init__(self):
			Gtk.Window.__init__(self, title="Drauger Installer")
			self.grid=Gtk.Grid(orientation=Gtk.Orientation.VERTICAL,)
			self.add(self.grid)

			self.label = Gtk.Label()
			self.label.set_markup("""
	Welcome to Drauger Installer! In the following screen, please navigate to the *.deb file you wish to install, select it, then hit \"Ok\"	
	""")
			self.label.set_justify(Gtk.Justification.CENTER)
			self.grid.attach(self.label, 1, 1, 8, 1)
			
			self.button1 = Gtk.Button.new_with_label("Next -->")
			self.button1.connect("clicked", self.onnextclicked)
			self.grid.attach(self.button1, 7, 2, 1, 1)
		
		def onnextclicked(self, widget):
			dialog = Gtk.FileChooserDialog("Drauger Installer", self,
			Gtk.FileChooserAction.OPEN,
			(Gtk.STOCK_CANCEL, Gtk.ResponseType.CANCEL,
			Gtk.STOCK_OPEN, Gtk.ResponseType.OK))

			self.add_filters(dialog)

			response = dialog.run()
			if response == Gtk.ResponseType.OK:
				exit(dialog.get_filename())
			elif response == Gtk.ResponseType.CANCEL:
				exit(2)

			dialog.destroy()
			
		def add_filters(self, dialog):
			filter_text = Gtk.FileFilter()
			filter_text.set_name("Archive")
			filter_text.add_mime_type("application/vnd.debian.binary-package")
			dialog.add_filter(filter_text)
			
			filter_any = Gtk.FileFilter()
			filter_any.set_name("Any files")
			filter_any.add_pattern("*")
			dialog.add_filter(filter_any)



def show_splash():
	window = splash()
	window.set_decorated(True)
	window.set_resizable(False)
	window.set_opacity(0.0)
	window.set_position(Gtk.WindowPosition.CENTER)
	window.show_all()
	Gtk.main() 
	window.connect("delete-event", Gtk.main_quit)

show_splash()
