$scriptName=$args[0]
get-content .env | foreach {
     $name, $value = $_.split('=')
     set-content env:\$name $value
}
forge script $scriptName --fork-url $env:RINKEBY_RPC_URL  --private-key $env:PRIVATE_KEY --broadcast --verify --etherscan-api-key $env:ETHERSCAN_KEY -vvvv
remove-item env:\RINKEBY_RPC_URL
remove-item env:\PRIVATE_KEY
remove-item env:\ETHERSCAN_KEY