# expand

Crystal macro debugging tool.

## Installation

Add this to your application's `shard.yml`:

```yaml
development_dependencies:
  expand:
    github: waterlink/expand.cr
    version: ~> 0.13.0
```

`version` should be always `~> YOUR_CRYSTAL_VERSION`. If you need to lock to
concrete version of `expand` tool: `version: YOUR_CRYSTAL_VERSION.N`, where N
is the specific version of `expand` tool, for example: `version: 0.13.0.2`.

And run `shards install`. This will download all required dependencies and
install the tool. Additionally, it installs its own binary to `./bin` directory
of your project (it is created automatically if it doesn't exist) as
`./bin/expand`.

NOTE: first build of `./bin/expand` tool will take some time and about 1 GB of
RAM, since it actually builds a crystal compiler under the hood.

## Usage

### Check the version of `expand`

```bash
$ ./bin/expand --version
0.13.0.2
```

### Expand source code of the file

Given file `example.cr`:

```crystal
macro a
  "a macro"
end

macro b
  a
  "b macro"
end

macro c
  b
  a
  "c macro"
end

c
```

When we run:

```bash
$ ./bin/expand /path/to/example.cr
macro a
    "a macro"

end
macro b
    a
  "b macro"

end
macro c
    b
  a
  "c macro"

end
"a macro"
"b macro"
"a macro"
"c macro"

```

Notice, how `c` macro call has been recursively expanded.
That is very useful to debug nested macros.

## Development

### Running tests

TODO: setup regression tests (collection of example files
and the expected expanded output).

### How version is structured?

There are 2 files controlling the version:

- `src/CRYSTAL_VERSION` - version of embedded crystal
  compiler, should match user's crystal version
- `src/EXPAND_VERSION` - a single-numbered version, always
  increases (even if `CRYSTAL_VERSION` changes). Required
  for delivering new versions (features, bug-fixes, etc.)
  for the same compiler version.

Final version of the tool is
`${CRYSTAL_VERSION}.${EXPAND_VERSION}`. That is what used in
`shard.yml`'s `version` field and as a part of git tag for a
release.

### To build expand in development

```bash
cd src
./build.sh
../../bin/expand --version
```

## Contributing

1. Fork it ( https://github.com/waterlink/expand.cr/fork )
2. Create your feature branch (git checkout -b my-new-feature)
3. Commit your changes (git commit -am 'Add some feature')
4. Push to the branch (git push origin my-new-feature)
5. Create a new Pull Request

## Contributors

- [waterlink](https://github.com/waterlink) Oleksii Fedorov - creator, maintainer
