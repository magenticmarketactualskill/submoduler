#!/usr/bin/env ruby
# frozen_string_literal: true

require 'fileutils'

parent_dir = File.expand_path('../..', __dir__)
symlink_path = './submodule_parent'

FileUtils.rm_rf(symlink_path) if File.exist?(symlink_path)
FileUtils.ln_s(parent_dir, symlink_path)

puts "Generated symlink to parent: #{symlink_path}"
