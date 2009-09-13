module Neurogami

  class WiiUseApiManager < Java::wiiusej.WiiUseApiManager

    def self.wiimotes number_of_remotes,  send_rumble=true
      wiimotes = getWiimotes number_of_remotes,  send_rumble
      wiimotes.to_ary
    end

  end
end
