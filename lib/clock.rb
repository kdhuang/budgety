require 'clockwork'

include Clockwork

every(1.seconds, 'test job') { print "test" }