# Purpose
The purpose of this is to have some Gems available from inside a Docker container in order to keep your
system clean. Currently, the Dockerfile installs [Reek](https://github.com/troessner/reek "Reek's Github") and [Flog](https://github.com/seattlerb/flog "Flog's Github")

### Build Ruby Image
```bash
$ git clone git@github.com:mattjg908/ruby_dev_gems.git
$ cd ruby_dev_gems
$ docker build -t ruby-dev-gems .
```
### Run Reek
**Run it with the full Docker command:**
```bash
$ docker run -it -v /absolute/path:/tmp/or/some/other/dir ruby-dev-gems reek /tmp/or/some/other/dir/whatever.rb
```
**Or, for easier usage, create a bash function:**
- Edit your .zshrc or .bashrc
```bash
$ vi ~/.zshrc
or
$ vi ~/.bashrc
```
- Add a function:
```vi
function reek () {
  docker run -it -v `pwd`:/tmp ruby-dev-gems reek /tmp/${1}
}
```
- Then, reload your .zshrc/.bashrc
```bash
$ source ~/.zshrc
or
$ source ~/.bashrc
```
Now you can run Reek like
```bash
$ reek path/to/some/file.rb
```

### Run Flog
- Follow the same steps as above for Reek, but replace `reek` with `flog` (naturally).
For convenience, here is the function you can add to your .zshrc/.bashrc:
```vi
function flog () {
  docker run -it -v `pwd`:/tmp ruby-dev-gems flog -d /tmp/${1}
}
```
Notice that I added the `-d` flag as I like the more verbose output.
## Other helpful commands

### Attach to container console
```bash
$ docker run -it ruby-dev-gems
```
### Bash in to container
```bash
$ docker run -it ruby-dev-gems bash
```
### Remove ruby-dev-gems image
```bash
$ docker image rm ruby-dev-gems -f
```
