
# NIEM MPD specification

## Building

The build process is set up to use 3 separate directories. It's easiest if these 3 directories are siblings of a single parent directory.

- source: The source code for the resulting document (this directory). This is a git clone of repository `https://git2.icl.gtri.org/scm/niem/niem-model-package-description-specification.git`.
- artifacts: Where the resulting document and supporting files are published. This should be a git clone of your own fork of repo `https://github.com/NIEM/MPD-Spec.git`.
- build: a directory where the source code is built/transformed into the resulting document. This is all temporary files

## Example

```
~ $ cd ~/r/niem-mpd-spec
~/r/niem-mpd-spec $ ls
artifacts build source
~/r/niem-mpd-spec $ cd build
~/r/niem-mpd-spec/build $ ../source/configure install_dir=../artifacts
[ ... configure script finds things in the environment ...]
configure: creating ./config.status
config.status: creating Makefile
config.status: creating run
~/r/niem-mpd-spec/build $ ls
Makefile  config.log  config.status  run
~/r/niem-mpd-spec/build $ make depend
[ ... dependencies.mk is built ... ]
~/r/niem-mpd-spec/build $ make
[ ... local copy of document and supporting files are built ... ]
~/r/niem-mpd-spec/build $ make install
[ ... copy of document and supporting files are pushed to the install directory ... ]
h~/r/niem-mpd-spec/build $ 
```

## Details of configure

Variable `install_dir`: The configuration stage needs to know in what directory to install resulting documents; set this variable to that folder. For example:

`~/r/niem-mpd-spec/build $ ../source/configure install_dir=../artifacts`

## Details of make

The makefile requires dependencies that are derived from the source document. These dependencies are automatically rebuilt when needed. Avoid rebuilding dependencies by running make with 'depend=no' set.




