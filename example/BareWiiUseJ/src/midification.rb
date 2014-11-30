require 'midi-jruby'
require 'unimidi'
require 'midi-eye'
require 'midi-message'
require 'yaml'




module Midification

  include MIDIMessage
  @@output = nil

  @@last_note = nil

  DEFAULT_CONFIG = '.wii-midi-config.yaml'

  def load_config config_file
    warn "Look for '#{config_file}' in #{Dir.pwd}"
    unless File.exist? config_file
      warn "Cannot find config file '#{config_file}'"
      return nil
    end
    begin 
      @config = YAML.load_file config_file
    rescue
      warn "There was an exception loading config file '#{config_file}': #{$!}"
      return nil
    end
  end


  def setup_midi

    unless load_config DEFAULT_CONFIG
      raise "Failed to load the config file '#{DEFAULT_CONFIG}'"
    end

    puts UniMIDI::Output.list
    @@output ||= UniMIDI::Output.use_by_name  @config[:device]

    unless @@output
      raise "Failed to assign a device with name '#{@config[:device]}'"
    end

    warn "Model is ready with device: #{@@output.inspect}"
    warn "device enabled?: #{@@output.enabled?}"


  end

  def send_note_off e

    message  = NoteOff.new 1, @@last_note

    t = Thread.new do
      begin
        @@output.puts message 
      rescue 
        warn '!'*80
        warn "Error sending MIDI message: #{$!}"
        warn '!'*80
      end
    end

  end


  def send_note e
 
    unless @@output
      raise "Output MIDI device is nil"
    end

    unless @@output.enabled?
      #  Why does it become disabled?
      @@output = UniMIDI::Output.use_by_name  @config[:device] 
    end

    vol = model.normalized_roll 10, 127
    note = model.normalized_pitch 44, 100

    @@last_note = note

  #  warn"Send note! note = #{note}; vol = #{vol}"

    message  = NoteOn.new 1, note, vol

    t = Thread.new do
      begin
        @@output.puts message 
      rescue 
        warn '!'*80
        warn "Error sending MIDI message: #{$!}"
        warn '!'*80
      end
    end

  end

   
end
