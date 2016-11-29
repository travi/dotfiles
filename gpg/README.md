## Using GPG key from keybase.io to sign git commits and verify on GitHub
* https://github.com/pstadler/keybase-gpg-github
* https://gist.github.com/sindresorhus/98add7be608fad6b5376a895e5a59972

## Adding an email to the key
* [edit the key](https://www.katescomment.com/how-to-add-additional-email-addresses-to-your-gpg-identity/)
* push the update to keybase with `keybase pgp update`
* update the public key on GitHub (refer to https://help.github.com/articles/generating-a-new-gpg-key/)
  * delete the old key
  * list the private keys with `gpg --list-secret-keys --keyid-format LONG`
  * copy the public key with `gpg --armor --export <key id from the list> | pbcopy`
  * add the copied key in GitHub
