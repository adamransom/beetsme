# beetsme

Config and wrapper for [beets](https://github.com/beetbox/beets) to help manage my music library.

# Prerequisites

Most importantly you need to [install beets](http://beets.readthedocs.io/en/v1.3.19/guides/main.html). In the simplest case, you can just run:

```
pip install beets
```

Of course, if you don't have Python or pip installed, you will need to follow the [installation guide](http://beets.readthedocs.io/en/v1.3.19/guides/main.html) mentioned above.

You will also need **Ruby 2.x**.

# Installation

Firstly, make sure you are in the root of the repo and install the required gems:

```
bundle install
```

Then install the script and beets config:

```
sh install.sh
```

This will symlink `beetsme` to `/usr/local/bin/beetsme` (it is assumed this is in your `PATH`) and `beets.config.yml` to `~/.config/beets/config.yml` (which is where beets expects the config file).

Before you can use `beetsme` you'll need to configure a few variables.

# Configuration

In order to use `beetsme`, you'll need to first tell it where your library and backup library are located.

1. Create a config file in the root of the repo named **`config.rb`**.
2. Add the following 3 lines, changing the example paths to your actual library paths:

    ```Ruby
    DOWNLOADED="#{Dir.home}/Music/Downloads/"
    LIBRARY="#{Dir.home}/Music/Library/"
    BACKUP='/Volumes/Backup/Music/Library/'
    ```
  This tells `beetsme` where to import your music from (`DOWNLOADED`), where to move it to (`LIBRARY`) and where to sync the backup library to (`BACKUP`).
  
  _Note: The `BACKUP` variable is optional if you don't want to create a backup library. This means you can't use the `beetsme diff` or `beetsme sync` commands._
3. If you want to modify the actual [beets config](http://beets.readthedocs.io/en/v1.3.19/reference/config.html), simply edit `beets.config.yml` because it as already been symlinked.

# Usage

To get started, simply type `beetsme` and it will print a list of available commands.

The usual flow will be

```
beetsme import
beetsme sync
```

to import new music from your downloads folder and then sync it with the backup library.

Before using `beetsme` to import my music, I first tag it all with [Yate](https://2manyrobots.com/yate/), which is highly recommended. I use the 'Discogs Wizard' feature heavily, which allows my library to stay consistent with the biggest music database on the net.
