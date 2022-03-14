# frozen_string_literal: true

module Flags
  class << self
    def optimization_flags
      if ENV["MRUBY_ENGINE_ENABLE_DEBUG"]
        %w[-O0]
      else
        %w[-O3 -Os]
      end
    end

    def cflags
      optimization_flags
    end

    def wasm32_cflags
      optimization_flags
    end

    def library_paths
      # Necessary because of https://github.com/mruby/mruby/issues/4537
      %w[/usr/local/lib /usr/lib]
    end

    def io_safe_defines
      %w[
        MRB_UTF8_STRING
        MRB_WORD_BOXING
      ]
    end

    def defines
      io_safe_defines + %w[
        MRB_USE_FLOAT32
        MRB_INT32
        MRB_WORDBOX_NO_FLOAT_TRUNCATE
        MRB_USE_RO_DATA_P_ETEXT
      ] # MRB_NO_STDIO
    end

    def wasm32_defines
      io_safe_defines + %w[
        MRB_32BIT
        MRB_USE_FLOAT32
        MRB_INT32
        MRB_WORDBOX_NO_FLOAT_TRUNCATE
        MRB_USE_RO_DATA_P_ETEXT
      ] # MRB_NO_STDIO
    end
  end
end
