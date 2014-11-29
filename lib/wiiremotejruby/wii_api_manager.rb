
module Neurogami

#  include WiiUseJ
#  class WiiUseApiManager < Java::wiiusej.WiiUseApiManager
  class WiiUseApiManager < WiiUseJ::WiiUseApiManager

    def self.wiimotes number_of_remotes,  send_rumble=true
      wiimotes = getWiimotes number_of_remotes,  send_rumble
      wiimotes.to_ary
    end

  end
end
