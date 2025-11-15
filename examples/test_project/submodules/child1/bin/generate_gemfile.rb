#!/usr/bin/env ruby
# frozen_string_literal: true

require 'erb'

template = File.read(File.join(__dir__, 'Gemfile.erb'))
gemfile_content = ERB.new(template).result

File.write('Gemfile', gemfile_content)
puts 'Generated Gemfile'
