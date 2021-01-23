# Purpose
The purpose of this is to have some Gems available from inside a Docker container in order to keep your
system clean. Currently, the Dockerfile installs [Reek](https://github.com/troessner/reek "Reek's Github"),
[Flog](https://github.com/seattlerb/flog "Flog's Github"),  and [RuboCop](https://rubocop.org/)
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
function reek() {
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
function flog() {
  docker run -it -v `pwd`:/tmp ruby-dev-gems flog -d /tmp/${1}
}
```
Notice that I added the `-d` flag as I like the more verbose output.

### Run Rubocop
- Follow the same steps as above for Reek, but replace `reek` with `rubocop` (naturally).
For convenience, here is the function you can add to your .zshrc/.bashrc:
```vi
function rubocop() {
  docker run -it -v `pwd`:/tmp ruby-dev-gems rubocop /tmp/${1}
}
```

## Use Reek & Rubocop w/ ALE in VIM for automatic linting
- Follow [ALE's installation instructions](https://github.com/dense-analysis/ale#installation-with-vim-plug "ALE's Github")
- Create scripts to run the Reek and Rubocop linters from the ruby-dev-gems Docker container
**/Users/matt/.vim/ale_docker_scripts/reek.sh** (make sure it's an executable)
```bash
#!/usr/bin/env bash
exec docker run -i --rm -v "$(pwd):/data" ruby-dev-gems reek "$@"
```
**/Users/matt/.vim/ale_docker_scripts/rubocop.sh** (make sure it's an executable)
```bash
#!/usr/bin/env bash
exec docker run -i --rm -v "$(pwd):/data" ruby-dev-gems rubocop "$@"
```
- Add ALE configuration to your .vimrc, here's mine for example:
```vi
" ALE
if isdirectory('/Users/matt/.vim/ale_docker_scripts/')
  let b:ale_linters = ['reek', 'rubocop']
  let g:ale_linters_explicit = 1
  let g:ale_ruby_reek_show_context = 1

  " Good for Ruby < 1.9 b/c the 'new' hash syntax came out in 1.9
  let g:ale_ruby_rubocop_options = '--except Style/SymbolArray,Style/HashSyntax'

  let b:ale_ruby_reek_executable = '/Users/matt/.vim/ale_docker_scripts/reek.sh'
  let b:ale_ruby_rubocop_executable = '/Users/matt/.vim/ale_docker_scripts/rubocop.sh'

  let b:ale_filename_mappings = {
  \ 'reek': [
  \   ['/Users/matt/.vim/ale_docker_scripts/', '/data'],
  \ ],
  \ 'rubocop': [
  \   ['/Users/matt/.vim/ale_docker_scripts/', '/data'],
  \ ],
  \}
endif
" Change color of highlight
highlight ALEWarning ctermbg=DarkMagenta
highlight ALEError ctermbg=DarkMagenta

" Do you want to underline text instead of highlight? See two lines below
" highlight ALEError ctermbg=none cterm=underline
" highlight ALEWarning ctermbg=none cterm=underline
let g:ale_fixers =  {'ruby': ['remove_trailing_lines', 'trim_whitespace']}
```

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
