#!/usr/bin/env ruby
# frozen_string_literal: true

require 'fileutils'

symlink_dir = './submodule_children'
FileUtils.rm_rf(symlink_dir) if File.exist?(symlink_dir)
FileUtils.mkdir_p(symlink_dir)

Dir.glob('submodules/**/*').select { |f| File.directory?(f) }.each do |child_dir|
  child_name = File.basename(child_dir)
  symlink_path = File.join(symlink_dir, child_name)
  FileUtils.ln_s(File.expand_path(child_dir), symlink_path)
end

puts "Generated symlinks in #{symlink_dir}"
