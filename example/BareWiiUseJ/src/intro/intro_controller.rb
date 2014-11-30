require 'wii_api_manager'
require 'wiimotable'
require 'wiimote_event_listener'

class IntroController < ApplicationController
  set_model 'IntroModel'
  set_view  'IntroView'

  include Neurogami::Wiimotable # Add this to stock Monkeybars controller code

  def exit_menu_action_performed
    close 
  end 

  # You need to define the handlers that are invoked via the mappings

  def home_button e
    #      if e.buttons_just_released > 0 # Never happens
    java.lang.System.exit 0   
    #     end

  end

  def motion_sensing_event_action_performed e    # WRAccelerationEvent
    model.acceleration_event = e
    #     warn e.to_s
    transfer[:pitch_text] = "Pitch: #{model.pitch}"
    signal :set_pitch_text
    transfer[:roll_text] = "Roll: #{model.roll}"
    signal :set_roll_text
    transfer[:yaw_text] = "Yaw: #{model.yaw}"
    signal :set_yaw_text

  end

=begin
   Seems these button events get called both for pressed and released,
   and you have to sort it out.
   But the event info seems contrary to the user actions.
    For example, the home button when pressed gives this:

   HOME /******** Buttons for Wiimote generic Event ********/
  /******** Buttons ********/
  --- Buttons just pressed : 128
  --- Buttons just released : 0
  --- Buttons held : 0

What happens is, on first press, you get a button just pressed and 0 for button held.
On release the only difference is  buttons held is now 128.

If you actually hold the button it looks no different, it just goes on longer.

There is no way to tell the moment when a button is in fact released.


=end
  def b_button e
    warn "e.getButtonsJustPressed() = #{e.getButtonsJustPressed()}"


    # This is never true!
    # warn "e.isButtonJustReleased(WiimoteEventListener::WIIMOTE_BUTTON_B) ? = #{e.isButtonJustReleased(Neurogami::WiimoteEventListener::WIIMOTE_BUTTON_B)}"

    if e.buttons_held > 0
      warn "------\nb_button HELD #{e.to_s}\n------"
    else
      warn "------\nb_button RELEASED #{e.to_s}\n------"
    end


  end


  def button_up e
    warn "button_up  #{e.to_s}"
  end

  def load


=begin

wiimote_event_listener defines a method, onButtonsEvent,  that catches 
button events.  Each event has some enum-like value defined for it.

There are constants defined for them.

The mappings hash associates these button event enums with code.

When onButtonsEvent fires the Ruby wiimote code grabs the enum value
and looks to see if there is behavior (i.e. a proc) associated.

If so then that proc is called with the Wii event passed as the single
param.

If there is no associated proc then the event is ignored.

WiiRemoteJ has the option to distinquish between a button being pressed
and a button being released.  

Oddly the WiiUseJRuby stuff does not seem to offer this, though
it seems that WiiUseJ should have this as well.

The WiiUseJ code has a function `isButtonPressed`


You can also query the event itself, but this seems flawed.

    Buttons just released : 0

is always 0.

You can check to see if 

     Buttons held : 0

but this seems to fire once when the button is pressed, and then on release there is
a series of 

    --- Buttons held : 4  # For the B button

events.




http://code.google.com/p/wiiusej/downloads/list



=end
    mappings = {

      :wiimote_button_home => lambda {|e| home_button e },
      :wiimote_button_b => lambda {|e| b_button e },
      :wiimote_button_up => lambda {|e| button_up e },

      # ... more mappings of Wii events to app code
      :motion_sensing_event => lambda{|e| motion_sensing_event_action_performed e }
    }




    # Neurogami::WiimoteEventListener code doesn't know anything about these lambdas, so it
    # makes the assumption that they accept a single argument: the source event.
    # You are free to ignore this argument in the lambda, but you have to account
    # for it being part of the invocation or you'll get an error.
    #

    # You do not have to map all possible Wii events, just those you care about.

    # Now create a Wiimote event listner, passing in the mappings,
    # and the number of times to prompt the user to connect before giving up.
    # If you omit this number, the application will prompt the user forever.
    wiimote_me  mappings, 3

  end



end
