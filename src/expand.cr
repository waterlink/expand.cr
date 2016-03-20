require "compiler/crystal/**"

if ARGV[0] == "--version"
  crystal_version = {{ `cat CRYSTAL_VERSION`.stringify.strip }}
  expand_version = {{ `cat EXPAND_VERSION`.stringify.strip }}
  puts "#{crystal_version}.#{expand_version}"
  exit 0
end

filename = ARGV[0]
compiler = Crystal::Compiler.new
source = Crystal::Compiler::Source.new(filename, File.read(filename))
tempfile = Crystal.tempfile("expand_temp")
result = compiler.compile(source, tempfile)

puts result.original_node
