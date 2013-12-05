lib = File.dirname(__FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require "bundler/setup"
require "redcarpet_filename_extension/block_code_with_filename"
