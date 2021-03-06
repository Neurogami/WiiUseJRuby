require 'wiimotable'
require 'intro_ui' 

# This is our Monkeybars View code
class IntroView < ApplicationView
  set_java_class IntroFrame  # Defined in intro_ui.rb

  # Signals are a way to have the controller pass requests to the view.
  define_signal :name => :set_pitch_text, :handler => :handle_pitch_text
  define_signal :name => :set_roll_text,  :handler => :handle_roll_text
  define_signal :name => :set_yaw_text,   :handler => :handle_yaw_text

  Thread.abort_on_exception = true

  include Neurogami::WiimotableView

  define_signal :name => :set_discovery_mode, :handler => :set_discovery_mode 
  define_signal :name => :end_discovery_mode, :handler => :end_discovery_mode 
  define_signal :name => :update_pitch_marker, :handler => :update_pitch_marker 

  ####### 


  # @load@ is called when the UI is opened.  You can think of it as a subsitute for 'initialize',
  # which, in the parent code, is already used for high-lelve preperations and should not
  # be replaced without a good understanding of how it works.
  def load
    set_frame_icon 'images/mb_default_icon_16x16.png'
    move_to_center # Built in to each Monkeybars View class.
    
    # Set up some basics content for our UI ...
    pitch_label.text = "Pitch: 0 "
    roll_label.text = "Roll: 0 "
    yaw_label.text = "Yaw: 0 "
  end

  # This is the method invoked when the view receives the set_new_text signal
  # is received.  All such signal handlers need to accept model and transfer objects.
  #
  # To understand Moneybars signals, see:
  #     http://www.monkeybars.org/understanding-signals
  def handle_pitch_text model, transfer
    pitch_label.text = transfer[:pitch_text]
  end

  def handle_roll_text model, transfer
    roll_label.text = transfer[:roll_text]
  end

  def handle_yaw_text model, transfer
    yaw_label.text = transfer[:yaw_text]
  end

  private

  def set_frame_icon file
  @main_view_component.icon_image = Java::javax::swing::ImageIcon.new(Java::org::monkeybars.rawr.Main.get_resource(file)).image
  rescue Exception => e
    # The weird thing is that this simply breaks the app if an error occurs, even with this recue in place.
    warn  "Error loading frame icon: #{e.message} "
    warn "Perhaps you do not have the image file '#{file}' in the proper location?"
  end



end
