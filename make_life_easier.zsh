# Call dbt run on only new models
function dbt_run_changed() {
    children=$1
    models=$(git diff --name-only | grep '\.sql$' | awk -F '/' '{ print $NF }' | sed "s/\.sql$/${children}/g" | tr '\n' ' ')
    echo "Running models: ${models}"
    dbt run --models $models
}

# Orders logs
function cycle_logs() {
  suffix=$(date '+%Y-%m-%dT%H:%M:%S')
  mv -v logs/dbt.log logs/dbt.log.${suffix}
}

## Add refresh command
alias dbt_refresh='dbt clean ; dbt deps ; dbt seed'
alias open_dbt_docs='dbt docs generate && dbt docs serve'
alias ls='ls -G'
alias grep='grep --color=auto'

export EDITOR="code --wait"