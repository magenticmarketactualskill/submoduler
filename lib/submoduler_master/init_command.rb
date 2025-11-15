# frozen_string_literal: true

require 'optparse'
require 'fileutils'

module SubmodulerMaster
  class InitCommand
    def initialize(args)
      @args = args
      @project_path = nil
      @children = []
      parse_options
    end

    def execute
      validate_options
      
      puts "Initializing Submoduler project at: #{@project_path}"
      
      create_parent_structure
      create_child_structures
      
      puts "✓ Successfully initialized project with #{@children.length} child submodule(s)"
      0
    rescue StandardError => e
      puts "Error during initialization: #{e.message}"
      1
    end

    private

    def parse_options
      OptionParser.new do |opts|
        opts.banner = "Usage: bin/submoduler_master.rb init [options]"
        
        opts.on('--project PATH', 'Relative path to project root (required)') do |path|
          @project_path = path
        end
        
        opts.on('--children NAMES', 'Comma-separated list of child submodule names') do |names|
          @children = names.split(',').map(&:strip)
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
    end

    def create_parent_structure
      FileUtils.mkdir_p(@project_path)
      puts "  Created directory: #{@project_path}"
      
      create_parent_config
      create_parent_bin_scripts
    end

    def create_parent_config
      config_path = File.join(@project_path, '.submoduler.ini')
      File.write(config_path, parent_config_content)
      puts "  Created: #{config_path}"
    end

    def parent_config_content
      <<~CONFIG
        [default]
        \tsubmodule_parent=true
        \tsubmodule_child=false
        \trequire_tests_pass=true
        \tseparate_repo=true
      CONFIG
    end

    def create_parent_bin_scripts
      bin_dir = File.join(@project_path, 'bin')
      FileUtils.mkdir_p(bin_dir)
      puts "  Created directory: #{bin_dir}"
      
      create_file(File.join(bin_dir, 'Gemfile.erb'), gemfile_erb_content)
      create_file(File.join(bin_dir, 'generate_gemfile.rb'), generate_gemfile_content)
      create_file(File.join(bin_dir, 'generate_child_symlinks.rb'), generate_child_symlinks_content)
    end

    def create_child_structures
      return if @children.empty?
      
      @children.each do |child_name|
        create_child_structure(child_name)
      end
    end

    def create_child_structure(child_name)
      child_path = File.join(@project_path, 'submodules', child_name)
      FileUtils.mkdir_p(child_path)
      puts "  Created child submodule: #{child_path}"
      
      create_child_config(child_path)
      create_child_bin_scripts(child_path)
    end

    def create_child_config(child_path)
      config_path = File.join(child_path, '.submoduler.ini')
      File.write(config_path, child_config_content)
      puts "    Created: #{config_path}"
    end

    def child_config_content
      <<~CONFIG
        [default]
        \tsubmodule_parent=false
        \tsubmodule_child=true
        \trequire_tests_pass=true
        \tseparate_repo=true
      CONFIG
    end

    def create_child_bin_scripts(child_path)
      bin_dir = File.join(child_path, 'bin')
      FileUtils.mkdir_p(bin_dir)
      
      create_file(File.join(bin_dir, 'Gemfile.erb'), gemfile_erb_content)
      create_file(File.join(bin_dir, 'generate_gemfile.rb'), generate_gemfile_content)
      create_file(File.join(bin_dir, 'generate_parent_symlink.rb'), generate_parent_symlink_content)
    end

    def create_file(path, content)
      File.write(path, content)
      File.chmod(0755, path) if path.end_with?('.rb')
      puts "    Created: #{path}"
    end

    def gemfile_erb_content
      <<~ERB
        # frozen_string_literal: true
        
        source 'https://rubygems.org'
        
        # Add your gem dependencies here
      ERB
    end

    def generate_gemfile_content
      <<~RUBY
        #!/usr/bin/env ruby
        # frozen_string_literal: true
        
        require 'erb'
        
        template = File.read(File.join(__dir__, 'Gemfile.erb'))
        gemfile_content = ERB.new(template).result
        
        File.write('Gemfile', gemfile_content)
        puts 'Generated Gemfile'
      RUBY
    end

    def generate_child_symlinks_content
      <<~RUBY
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
        
        puts "Generated symlinks in \#{symlink_dir}"
      RUBY
    end

    def generate_parent_symlink_content
      <<~RUBY
        #!/usr/bin/env ruby
        # frozen_string_literal: true
        
        require 'fileutils'
        
        parent_dir = File.expand_path('../..', __dir__)
        symlink_path = './submodule_parent'
        
        FileUtils.rm_rf(symlink_path) if File.exist?(symlink_path)
        FileUtils.ln_s(parent_dir, symlink_path)
        
        puts "Generated symlink to parent: \#{symlink_path}"
      RUBY
    end
  end
end
