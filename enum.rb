# Downside to enumerations expressed as tables:
#   * Chained method calls that can fail, e.g. glass.color.name
#   * Extra database joins (performance)
#   * Can't quickly identify an instance, e.g. Color.find(3)  => green

require 'rubygems'
require 'active_support'

module Enum
  
  @@values = HashWithIndifferentAccess.new
  
  module ClassMethods
    # Return all possible color objects
    def all
      @@values.keys.collect { |label| self.class.new(label) }
    end
  end
  
  def self.included(base)
    base.extend ClassMethods
  end
  
  def initialize(label=nil)
    if @@values[label].nil?
      raise ArgumentError, "Invalid label #{label.inspect}"
    end
    @label = label
  end
  
  # Return the english name of this color (or nil if this is an unknown color)
  def to_s
    @@values[@label]
  end
  
  # Return the label for this color
  def label
    @label.to_sym
  end
  
  # Is this a valid color? (could be nil too)
  def valid?
    ! @@values[@label].nil?
  end
  
  # Is this color nil? (as opposed to just not valid?)
  def empty?
    @label.nil?
  end
    
  # Value to use when hashing color objects
  def hash
    @label
  end
  
  # See if two colors are equivalent.
  def ==(other_color)
    @label == other_color.label
  end
    
end


class Color
  include Enum
  @@values['dark_green'] = 'Dark Green'
  @@values['sky_blue']   = 'Sky Blue'
  @@values['brick_red']  = 'Brick Red'  
end

class Flavor
  include Enum
  @@values['vanilla']    = 'Vanilla'
  @@values['strawberry'] = 'Strawberry'
end

