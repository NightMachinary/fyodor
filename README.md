# Fyodor

Convert your Amazon Kindle highlights, notes and bookmarks into markdown files.

## What is Fyodor

This application parses `My Clippings.txt` from your Kindle and generates a markdown file for each book/document, in the format `#{Author} - #{Title}.md`. This way, your annotations are conveniently stored and easily managed.

[For samples of the output, click here.](docs/output_demo)

To read more about the motivation and what problem it tries to solve, [check this blog post](http://rafaelc.org/blog/export-all-your-kindle-highlights-and-notes/).

## Features

- Supports all the type of entries in your clippings file: highlights, notes, clips and bookmarks.
- Automatic removal of empty or duplicate entries (the clippings file can get a lot of those).
- Orders your entries by location/page on each book (the clippings file is ordered by time).
- Easily configurable for your language, allowing you to get all features and beautiful output.
- This software goes some length to be locale agnostic: basic parsing should work without configuration for any language. It should also work even if your clippings file has multiple locales.
- Bookmarks are printed together and notes are formatted differently, for better visualization.
- Output in a format that is clean and easy to edit/fiddle around: markdown.

This program is based on the clippings file generated by Kindle 2019, but should work with other models.

## Installation

Install Ruby and run:

```
$ gem install fyodor
```

## Updating

Run:

```
$ gem update fyodor
```

## Configuration

Fyodor has an optional configuration file, which is used for the following.

### Languages

If your Kindle is not in English, you should tell Fyodor how some things are called by your `My Clippings.txt` (e.g. highlights, pages, etc). _Fyodor should still work without configuration, but you won't take advantage of many features, resulting in a dirtier output._

1. Download the sample config to `~/.config/fyodor.toml` or `$XDG_CONFIG_HOME/fyodor.toml`:

```
$ wget https://raw.githubusercontent.com/rccavalcanti/fyodor/master/docs/fyodor.toml.sample -O ~/.config/fyodor.toml
```

2. Open both the configuration and your `My Clippings.txt` in your preferred editor. Change the values in the `[parser]` section to mirror what you get in `My Clippings.txt`.

For example, this is the configuration for Brazilian Portuguese:

```
[parser]
highlight = "Seu destaque"
note = "Sua nota"
bookmark = "Seu marcador"
clip = "Recortar este artigo"
loc = "posição"
page = "página"
time = "Adicionado:"
```

### Showing the time

In the configuration file you can also set whether to print the time of each entry. On `[output]`, set `time` to `true` or `false`.

## Usage

```
$ fyodor CLIPPINGS_FILE [OUTPUT_DIR]
```

Where:

- `CLIPPINGS_FILE` is the path for `My Clippings.txt`.
- `OUTPUT_DIR` is the directory to write the markdown files. If none is supplied, this will be `fyodor_output` under the current directory.

## Buy me a coffee

If you like Fyodor, you can show your support here:

<a href="https://www.buymeacoffee.com/rafaelc" target="_blank"><img src="https://cdn.buymeacoffee.com/buttons/default-orange.png" alt="Buy Me A Coffee" width="200" ></a>

## License

Licensed under [GPLv3](LICENSE)

Copyright (C) 2019-2020 [Rafael Cavalcanti](https://rafaelc.org/)
