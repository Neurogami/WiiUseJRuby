module Neurogami

  class WiimoteEventListener
=begin
  /* Buttons MACRO */
  private static short WIIMOTE_BUTTON_TWO = 0x0001
  private static short WIIMOTE_BUTTON_ONE = 0x0002
  private static short WIIMOTE_BUTTON_B = 0x0004
  private static short WIIMOTE_BUTTON_A = 0x0008
  private static short WIIMOTE_BUTTON_MINUS = 0x0010
  private static short WIIMOTE_BUTTON_ZACCEL_BIT6 = 0x0020
  private static short WIIMOTE_BUTTON_ZACCEL_BIT7 = 0x0040
  private static short WIIMOTE_BUTTON_HOME = 0x0080
  private static short WIIMOTE_BUTTON_LEFT = 0x0100
  private static short WIIMOTE_BUTTON_RIGHT = 0x0200
  private static short WIIMOTE_BUTTON_DOWN = 0x0400
  private static short WIIMOTE_BUTTON_UP = 0x0800
  private static short WIIMOTE_BUTTON_PLUS = 0x1000
  private static short WIIMOTE_BUTTON_ZACCEL_BIT4 = 0x2000
  private static short WIIMOTE_BUTTON_ZACCEL_BIT5 = 0x4000
  private static int WIIMOTE_BUTTON_UNKNOWN = 0x8000
  private static short WIIMOTE_BUTTON_ALL = 0x1F9F
=end

    WIIMOTE_BUTTON_TWO = 0x0001
    WIIMOTE_BUTTON_ONE = 0x0002
    WIIMOTE_BUTTON_B = 0x0004
    WIIMOTE_BUTTON_A = 0x0008
    WIIMOTE_BUTTON_MINUS = 0x0010
    WIIMOTE_BUTTON_ZACCEL_BIT6 = 0x0020
    WIIMOTE_BUTTON_ZACCEL_BIT7 = 0x0040
    WIIMOTE_BUTTON_HOME = 0x0080
    WIIMOTE_BUTTON_LEFT = 0x0100
    WIIMOTE_BUTTON_RIGHT = 0x0200
    WIIMOTE_BUTTON_DOWN = 0x0400
    WIIMOTE_BUTTON_UP = 0x0800
    WIIMOTE_BUTTON_PLUS = 0x1000
    WIIMOTE_BUTTON_ZACCEL_BIT4 = 0x2000
    WIIMOTE_BUTTON_ZACCEL_BIT5 = 0x4000
    WIIMOTE_BUTTON_UNKNOWN = 0x8000
    WIIMOTE_BUTTON_ALL = 0x1F9F


    def initialize mapping
      define_on_ir_event(mapping.delete :ir_event) if mapping[:ir_event ]
      define_on_motion_sensing_event(mapping.delete :motion_sensing_event) if mapping[:motion_sensing_event ]
      assign_button_mapping mapping
    end


    def define_on_ir_event prk
      self.class.send :define_method, :on_ir_event do |event|
        prk.call(event) 
      end
    end

    def define_on_motion_sensing_event prk
      self.class.send :define_method, :on_motion_sensing_event do  |event| 
        prk.call(event)
      end
    end


    # The goal is that when creating an app, there is a default event listener that does nothing.
    # The developer than provides either a whole new listener, or passes in a set of event mappings
    # when creatng an instance of this class:
    #  :wiimote_button_two => :some_cool_thing, :wiimote_button_home => other_cool_thing
    #
    #  We can easily do this for single keys, but when we have, say, a button event number of 6, we need
    #  to find the mapping for WIIMOTE_BUTTON_ONE + WIIMOTE_BUTTON_B
    #  So we allow mappings such as 
    #   :wiimote_button_home_and_wiimote_button_two => :really_cool_stuff
    #   then decompose that key into WIIMOTE_BUTTON_HOME + WIIMOTE_BUTTON_TWO  to get the hash number
    #
    # These key mappings can map to lambdas or method names.  A typical scenario is that
    # some Jimpanzee controller will want to map controller methods to Wiimote events:
    #
    #
    #     mappings = {
    #      :wiimote_button_home => lambda {|e| FooController.instance.home_button_action_performed(e) },
    #      :wiimote_button_a_and_wiimote_button_b => lambda {|e| FooController.instance.a_and_b_action_performed(e) }
    #     }
    #
    #    listener = WiimoteEventListener.new(mappings)
    #
    def assign_button_mapping  mapping

      @button_handlers ||= { }

      mapping.each do |button_key, response|
        key_str = button_key.to_s
        keys = key_str.split( '_and_')
        key_sum = keys.inject(0){|sum, k| sum + eval(k.upcase) }
        @button_handlers[key_sum] = response 
      end
    end

    def assign_ir_mapping  prk
      define_method
    end


    #  WiimoteButtonsEvent
    def onButtonsEvent event
      button = event.buttonsJustPressed

      return if button == 0
      return unless handler = @button_handlers[button]

      if handler.respond_to?(:call)
        begin
          handler[event]
        rescue Exception => e
          STDERR.puts " \n ERROR at #{__FILE__}:#{__LINE__}: #{e.inspect} \n handler = #{handler.pretty_inspect}" 
          raise  e
        end
      else
        send handler, event
      end
    end

    # IREvent
    def on_ir_event event 
      warn "Default on_ir_event " if ENV['JAMES_SCA_JDEV_MACHINE'] # JGBDEBUG 
    end


    
    def on_motion_sensing_event event 
      STDERR.puts( ":DEBUG #{__FILE__}:#{__LINE__} DEFAULT onMotionSensingEvent" ) if ENV['JAMES_SCA_JDEV_MACHINE'] # JGBDEBUG 
    end

  
    # ExpansionEvent
    def  onExpansionEvent event 
      # warn event 
    end

    # StatusEvent
    def  onStatusEvent event 
      # warn event 
    end

    # DisconnectionEvent
    def  onDisconnectionEvent event 
      # warn event 
    end

    # NunchukInsertedEvent
    def  onNunchukInsertedEvent event 
      # warn event 
    end

    # NunchukRemovedEvent
    def  onNunchukRemovedEvent event 
      # warn event 
    end
  end
end
