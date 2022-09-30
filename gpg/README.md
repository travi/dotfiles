# GPG

## Using GPG key from keybase.io to sign git commits and verify on GitHub

* <https://github.com/pstadler/keybase-gpg-github>
* <https://gist.github.com/sindresorhus/98add7be608fad6b5376a895e5a59972>

### Ensure that the `~/.gnupg` directory has the proper permissions

```sh
chmod 700 ~/.gnupg
```

### Update agent after a config change

```sh
gpgconf --kill gpg-agent
```

### Setting an existing set of keys from Keybase as the default keypair for GPG

* Open the Keybase desktop app
* Log into the desktop app
* Add as a new device
* In the terminal:
  * `$ keybase login`
* [Import the Keybase keypair into GPG](https://github.com/pstadler/keybase-gpg-github#import-key-to-gpg-on-another-host)

## Adding an email to the key

* [edit the key](https://www.katescomment.com/how-to-add-additional-email-addresses-to-your-gpg-identity/)
* push the update to keybase with `keybase pgp update`
* update the public key on GitHub (refer to <https://help.github.com/articles/generating-a-new-gpg-key/>)
  * delete the old key
  * list the private keys with `gpg --list-secret-keys --keyid-format LONG`
  * copy the public key with `gpg --armor --export <key id from the list> | pbcopy`
  * add the copied key in GitHub
