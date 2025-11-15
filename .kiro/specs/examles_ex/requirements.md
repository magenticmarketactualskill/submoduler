Example project named 'parent_module' that has one submodule 'ex/child'

This shows example of configured SubmodulerProject:

├── .submoduler
├── examples
    └── parent_module
        ├───.submoduler
        ├── bin
        ├   ├── Gemfile.erb
        ├   ├── generate_gemfile.rb
        ├   ├── generate_child_symlinks.rb
        └── submodules
            └── ex
               └── child
                    ├── .submoduler
                    ├── bin
                        ├── Gemfile.erb
                        ├── generate_gemfile.rb
                        ├── generate_parent_symlink.rb

