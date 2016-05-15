# Ruby Config

Ruby continues to be a pain to configure "correctly" (is there actually a truly
correct config for ruby?).

## version management

[rbenv](https://github.com/rbenv/rbenv) is configured to handle switching ruby
versions

* `bash/source.sh` sources `ruby/rbenv-init.sh`
* `~/.rbenv/version` sets the default ruby version
* the existence of a `.ruby-version` in a directory _automatically_ sets the
  local ruby version
* `~/.rbenv/default-gems` ensures that the list of gems is installed when
  switching versions

## environment

after many iterations of trying to get the environment configured "correctly",
i finally ran across [an article](http://technotes.iangreenleaf.com/posts/if-youre-having-ruby-environment-problems-i-feel-bad-for-you-son.html)
that helped me get my head around more of the important pieces and got me to the
current state with this config.

* `RUBYGEMS_GEMDEPS=-` is set in the environment as a result of the above article
  in order to ensure that local gems are used without introducing the
  [security issue](http://technotes.iangreenleaf.com/posts/if-youre-having-ruby-environment-problems-i-feel-bad-for-you-son.html#fn2)
  of adding `./bin` to the `$PATH` and installing bundles with `--binstubs`.

## .gemrc

* downloading of documentation is disabled to improve installation times
