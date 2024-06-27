set dotenv-load

version := "1.2.0"
commit-msg := `git log -1 --pretty=format:%B`

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
  git add .
  git commit -m "Merged {{version}}"
  git push
  git tag -a {{version}}
  git push origin {{version}}
