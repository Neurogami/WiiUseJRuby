
class Numeric

  def translate left_min, left_max, right_min, right_max
    # Figure out how 'wide' each range is
    left_span = left_max - left_min
    right_span = right_max - right_min

    # Convert the left range into a 0-1 range (float)
    value_scaled = (self - left_min).to_f / left_span.to_f

    # Convert the 0-1 range into a value in the right range.
    right_min + value_scaled * right_span
  end

end


class IntroModel

  # From -Math::PI to Math::PI
  def pitch
    @acceleration_event ?  @acceleration_event.orientation.pitch : 0.0
  end


  #  the roll of the remote, in radians from 0 to 2PI. 
  #  However, sometimes the value is -1.5707963267948966 
  #  And always that special number. 
  def roll
    @acceleration_event ?  @acceleration_event.orientation.roll : 0.0
  end


  # Seems WiiUseJ always returns a yaw of 0.0.  Why?
  def yaw
    @acceleration_event ?  @acceleration_event.orientation.yaw : -99
  end

  def acceleration_event= e
    # warn e.inspect
    # http://code.google.com/p/wiiusej/source/browse/trunk/WiiUseJ/src/wiiusej/wiiusejevents/physicalevents/MotionSensingEvent.java
    @acceleration_event = e # AccelerationEvent

=begin
model.pitch           = event.orientation.pitch
model.yaw             = event.orientation.yaw
model.roll               = event.orientation.roll
model.gforce_x           = event.gforce.x
model.gforce_y           = event.gforce.y
model.gforce_z           = event.gforce.z
model.raw_acceleration_x = event.raw_acceleration.x
model.raw_acceleration_y = event.raw_acceleration.y
model.raw_acceleration_z = event.raw_acceleration.z

=end


  end


end
