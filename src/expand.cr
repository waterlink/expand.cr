require "compiler/crystal/**"

ENV["CRYSTAL_PATH"] ||= "/opt/crystal/src"

filename = ARGV[0]
compiler = Crystal::Compiler.new
source = Crystal::Compiler::Source.new(filename, File.read(filename))
tempfile = Crystal.tempfile("expand_temp")
result = compiler.compile(source, tempfile)

puts result.original_node
