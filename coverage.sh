#!/bin/bash

# We want to make sure the files of our dependencies are availiable so we can update their pragma.
forge install

# First, we change all Aave pragmas from 0.8.10 to 0.8.13, because this is the first solc version with via-ir which we  and we need
# via-ir because importing the PoolConfigurator contract into the ATokenFlexVoting tests causes a stack too deep error.
# find lib/aave-v3-core/contracts -type f -name "*.sol" -exec awk -i inplace '{gsub(/pragma solidity 0\.8\.10;/, "pragma solidity 0.8.13;"); print}' {} \;
find lib/aave-v3-core/contracts -type f -name "*.sol" -exec sh -c 'awk "{gsub(/pragma solidity 0\\.8\\.10;/, \"pragma solidity 0.8.13;\"); print}" "$1" > "$1.tmp" && mv "$1.tmp" "$1"' -- {} \;

# Next, we need to update the pragma for code importing the aave-v3-core otherwise we will get incompatible version errors.
find src/ATokenFlexVoting.sol -type f -name "*.sol" -exec sh -c 'awk "{gsub(/pragma solidity 0\\.8\\.10;/, \"pragma solidity 0.8.13;\"); print}" "$1" > "$1.tmp" && mv "$1.tmp" "$1"' -- {} \;
find test/ATokenFlexVotingFork.t.sol -type f -name "*.sol" -exec sh -c 'awk "{gsub(/pragma solidity >=0\\.8\\.10;/, \"pragma solidity >=0.8.13;\"); print}" "$1" > "$1.tmp" && mv "$1.tmp" "$1"' -- {} \;

# We run the coverage command with the --ir-minimum flag which compiles the contracts using the stack mover optimizer step. The stack optimizer step resolves the stack too deep error.
forge coverage --report summary --report lcov --ir-minimum

# Lastly, we have to change the pragma back to the original versions
find lib/aave-v3-core/contracts -type f -name "*.sol" -exec sh -c 'awk "{gsub(/pragma solidity 0\\.8\\.13;/, \"pragma solidity 0.8.10;\"); print}" "$1" > "$1.tmp" && mv "$1.tmp" "$1"' -- {} \;
find src/ATokenFlexVoting.sol -type f -name "*.sol" -exec sh -c 'awk "{gsub(/pragma solidity 0\\.8\\.13;/, \"pragma solidity 0.8.10;\"); print}" "$1" > "$1.tmp" && mv "$1.tmp" "$1"' -- {} \;
find test/ATokenFlexVotingFork.t.sol -type f -name "*.sol" -exec sh -c 'awk "{gsub(/pragma solidity >=0\\.8\\.13;/, \"pragma solidity >=0.8.10;\"); print}" "$1" > "$1.tmp" && mv "$1.tmp" "$1"' -- {} \;

