alias ltst='tree -a --timefmt '%H:%m:%S' --dirsfirst /tmp/bats'
alias rtst='bats /workspaces/${RepositoryName}/test; ltst'
alias ctst='rm -rf /tmp/bats; rtst'
