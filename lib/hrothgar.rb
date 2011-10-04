require 'hrothgar/engine'
require 'hrothgar/pub_sub'
require 'hrothgar/helper'
ActionController::Base.send(:include,  Hrothgar::Helper)
