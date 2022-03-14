# frozen_string_literal: true

require_relative("./flags")

def mruby_engine_gembox_path
  if ENV["MRUBY_ENGINE_GEMBOX_PATH"] && File.exist?(ENV["MRUBY_ENGINE_GEMBOX_PATH"])
    raise "`#{ENV['MRUBY_ENGINE_GEMBOX_PATH']}` require `.gembox` extension" unless ENV["MRUBY_ENGINE_GEMBOX_PATH"].end_with?(".gembox")

    Pathname.new ENV["MRUBY_ENGINE_GEMBOX_PATH"][0..-8]
  else
    Pathname.new(__FILE__).dirname.join("mruby_engine")
  end
end

# https://github.com/mruby/mruby/blob/master/doc/guides/compile.md

MRuby::Build.new do |conf|
  toolchain :clang

  conf.gembox(mruby_engine_gembox_path)
  conf.gem(core: "mruby-bin-mirb")
  conf.gem(core: "mruby-bin-mruby")

  conf.cc do |cc|
    cc.flags += %w[-fPIC]
    cc.flags += Flags.cflags
    cc.defines += Flags.defines
  end

  conf.linker do |linker|
    linker.library_paths += Flags.library_paths
  end
end

MRuby::CrossBuild.new("emscripten") do |conf|
  toolchain :clang

  conf.gembox(mruby_engine_gembox_path)

  # No executables
  conf.bins = []

  conf.cc.command = 'emcc'
  conf.cxx.command = 'em++'
  conf.linker.command = 'em++'
  conf.archiver.command = 'emar'

  conf.cc do |cc|
    cc.flags += %w[-fPIC]
    cc.flags += Flags.wasm32_cflags
    cc.defines += Flags.wasm32_defines
  end

  # conf.linker do |linker|
  #   linker.library_paths += Flags.library_paths
  # end
end
