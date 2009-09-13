# http://wiki.jruby.org/wiki/Calling_Java_from_JRuby#Use_include_package_within_a_Ruby_Module_to_import_a_Java_Package

# require 'spinner_dialog'   # need a way to allow some UI stuff without presuming too much

require 'pp'

module Neurogami

  module Wiimotable
    def wiimote_me listener, max_attempts=nil
      
      attempts_so_far = 0

      begin
        attempts_so_far += 1
        transfer[:attempt_number] = attempts_so_far
        signal :set_discovery_mode

        @remote =  get_wiimote 
        raise "Nil remote" unless @remote
        prepare_wiimote @remote , listener
      rescue  Exception => e
        warn "Error #{e.inspect}"
        warn "Signal to end dicovery mode. Have @remote  #{@remote.inspect}"

        exit if e.is_a?(NameError)

        signal :end_discovery_mode
        if max_attempts.nil? || attempts_so_far < max_attempts
          warn "Attempte #{attempts_so_far}. Retry  connection ... "
          retry
        else
          raise
        end
      end
    ensure
      signal :end_discovery_mode
    end


    def get_wiimote 
      begin
      wiimotes = WiiUseApiManager.wiimotes(1)
      warn "wiimotes: #{wiimotes.pretty_inspect}"
      wiimote = wiimotes.first
      rescue Exception => e
        (STDERR.puts( " \n ERROR at #{__FILE__}:#{__LINE__}: #{e.inspect} " ); STDERR.flush ) if ENV['JAMES_SCA_JDEV_MACHINE'] # JGBDEBUG 
        raise e
      end
    end

    def prepare_wiimote wiimote, listener
      wiimote.activateIRTRacking
      wiimote.activateMotionSensing
      wiimote.addWiiMoteEventListeners(listener)
      wiimote    
    end
  end

  module WiimotableView

    def set_discovery_mode model, transfer
      begin
        @spinner = SpinnerDialog.new(["Attempt #{transfer[:attempt_number] }", "Press buttons 1+2 together ..."])
        @spinner.visible = true
      rescue  Exception
        warn "Error creating SpinnerDialog: #{$!}"
        raise
      end
    end

    def end_discovery_mode model, transfer
      return unless @spinner
      @spinner.visible = false
      @spinner.hide
      @spinner = nil
    end
  end

end
