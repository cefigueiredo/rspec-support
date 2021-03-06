module RSpec
  module Support
    # @api private
    #
    # Provides query methods for different OS or OS features.
    module OS
      module_function

      def windows?
        RbConfig::CONFIG['host_os'] =~ /cygwin|mswin|mingw|bccwin|wince|emx/
      end

      def windows_file_path?
        ::File::ALT_SEPARATOR == '\\'
      end
    end

    # @api private
    #
    # Provides query methods for different rubies
    module Ruby
      module_function

      def jruby?
        RUBY_PLATFORM == 'java'
      end
    end

    # @api private
    #
    # Provides query methods for ruby features that differ among
    # implementations.
    module RubyFeatures
      module_function

      def optional_and_splat_args_supported?
        Method.method_defined?(:parameters)
      end

      def kw_args_supported?
        RUBY_VERSION >= '2.0.0' && RUBY_ENGINE != 'rbx' && RUBY_ENGINE != 'jruby'
      end

      def required_kw_args_supported?
        RUBY_VERSION >= '2.1.0' && RUBY_ENGINE != 'rbx' && RUBY_ENGINE != 'jruby'
      end

      def module_prepends_supported?
        Module.method_defined?(:prepend) || Module.private_method_defined?(:prepend)
      end

      def supports_rebinding_module_methods?
        # RBX and JRuby don't yet support this.
        RUBY_VERSION.to_i >= 2 && RUBY_ENGINE != 'rbx' && RUBY_ENGINE != 'jruby'
      end
    end
  end
end
