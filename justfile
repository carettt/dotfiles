set dotenv-load

version := "v2.2.0-rc1"
commit-msg := `git log -1 --oneline`

# TODO: add automatic structure update

test *flags:
  git add .
  nh os test {{flags}}

switch version *flags:
  @echo 'NIXOS_LABEL="{{version}} - {{commit-msg}}"' | tee .env
  nh os switch {{flags}}
  @rm .env

save *flags:
  git add .
  @just switch {{version}} {{flags}}

stage branch *flags:
  @just switch {{version}} {{flags}}
  git checkout main
  git merge {{branch}}

publish:
  git push
  git tag -a {{version}}
  git push origin {{version}}
