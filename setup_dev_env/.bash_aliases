alias ltst='tree -a --timefmt '%H:%m:%S' --dirsfirst /tmp/bats'
alias rtst='pushd /workspaces/${RepositoryName};/workspaces/${RepositoryName}/test/bats/bin/bats /workspaces/${RepositoryName}/test; ltst;popd'
alias stst='rm -rf /tmp/bats/*'
alias ctst='stst; rtst'
