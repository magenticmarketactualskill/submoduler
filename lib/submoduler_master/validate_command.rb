# frozen_string_literal: true

require 'optparse'

module SubmodulerMaster
  class ValidateCommand
    def initialize(args)
      @args = args
      @project_path = nil
      @errors = []
      @checks = 0
      parse_options
    end

    def execute
      validate_options
      
      puts "Validating Submoduler project at: #{@project_path}"
      puts ""
      
      validate_parent_structure
      validate_child_structures
      
      display_results
      
      @errors.empty? ? 0 : 1
    rescue StandardError => e
      puts "Error during validation: #{e.message}"
      1
    end

    private

    def parse_options
      OptionParser.new do |opts|
        opts.banner = "Usage: bin/submoduler_master.rb validate [options]"
        
        opts.on('--project PATH', 'Relative path to project root (required)') do |path|
          @project_path = path
        end
        
        opts.on('-h', '--help', 'Display this help') do
          puts opts
          exit 0
        end
      end.parse!(@args)
    end

    def validate_options
      raise 'Missing required --project option' unless @project_path
      raise 'Project path cannot be empty' if @project_path.strip.empty?
      raise "Project path does not exist: #{@project_path}" unless Dir.exist?(@project_path)
    end

    def validate_parent_structure
      puts "Checking parent structure..."
      
      check_file_exists('.submoduler.ini', 'Parent configuration file')
      check_parent_config if File.exist?(File.join(@project_path, '.submoduler.ini'))
      check_file_exists('bin/Gemfile.erb', 'Gemfile template')
      check_file_exists('bin/generate_gemfile.rb', 'Gemfile generator script')
      check_file_exists('bin/generate_child_symlinks.rb', 'Child symlinks generator script')
    end

    def check_parent_config
      config_path = File.join(@project_path, '.submoduler.ini')
      content = File.read(config_path)
      
      check_config_value(content, 'submodule_parent', 'Parent configuration')
      check_config_value(content, 'submodule_child', 'Parent configuration')
      check_config_value(content, 'require_tests_pass', 'Parent configuration')
      check_config_value(content, 'separate_repo', 'Parent configuration')
    end

    def validate_child_structures
      submodules_dir = File.join(@project_path, 'submodules')
      
      unless Dir.exist?(submodules_dir)
        puts "  ℹ No submodules directory found"
        return
      end
      
      puts ""
      puts "Checking child submodules..."
      
      children = find_child_submodules(submodules_dir)
      
      if children.empty?
        puts "  ℹ No child submodules found"
        return
      end
      
      children.each do |child_path|
        validate_child_structure(child_path)
      end
    end

    def find_child_submodules(submodules_dir)
      children = []
      Dir.glob(File.join(submodules_dir, '**', '.submoduler.ini')).each do |config_file|
        children << File.dirname(config_file)
      end
      children
    end

    def validate_child_structure(child_path)
      relative_path = child_path.sub(@project_path + '/', '')
      puts "  Checking #{relative_path}..."
      
      check_child_config(child_path)
      check_child_file_exists(child_path, 'bin/Gemfile.erb', 'Gemfile template')
      check_child_file_exists(child_path, 'bin/generate_gemfile.rb', 'Gemfile generator')
      check_child_file_exists(child_path, 'bin/generate_parent_symlink.rb', 'Parent symlink generator')
    end

    def check_child_config(child_path)
      config_path = File.join(child_path, '.submoduler.ini')
      content = File.read(config_path)
      
      check_config_value(content, 'submodule_parent', 'Child configuration', child_path)
      check_config_value(content, 'submodule_child', 'Child configuration', child_path)
      check_config_value(content, 'require_tests_pass', 'Child configuration', child_path)
      check_config_value(content, 'separate_repo', 'Child configuration', child_path)
    end

    def check_file_exists(relative_path, description)
      @checks += 1
      full_path = File.join(@project_path, relative_path)
      
      if File.exist?(full_path)
        puts "  ✓ #{description}"
      else
        puts "  ✗ #{description} missing: #{relative_path}"
        @errors << "Missing file: #{relative_path}"
      end
    end

    def check_child_file_exists(child_path, relative_path, description)
      @checks += 1
      full_path = File.join(child_path, relative_path)
      
      if File.exist?(full_path)
        puts "    ✓ #{description}"
      else
        puts "    ✗ #{description} missing"
        @errors << "Missing file in #{child_path}: #{relative_path}"
      end
    end

    def check_config_value(content, key, description, path = nil)
      @checks += 1
      
      if content.match?(/#{key}=(true|false)/)
        puts "  ✓ #{description}: #{key} is set" unless path
        puts "    ✓ #{description}: #{key} is set" if path
      else
        puts "  ✗ #{description}: #{key} is missing or invalid" unless path
        puts "    ✗ #{description}: #{key} is missing or invalid" if path
        @errors << "Invalid or missing config value: #{key} in #{path || @project_path}"
      end
    end

    def display_results
      puts ""
      puts "=" * 50
      puts "Validation Summary"
      puts "=" * 50
      puts "Total checks: #{@checks}"
      puts "Failures: #{@errors.length}"
      
      if @errors.empty?
        puts ""
        puts "✓ All validations passed!"
      else
        puts ""
        puts "Errors found:"
        @errors.each do |error|
          puts "  - #{error}"
        end
      end
    end
  end
end
