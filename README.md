# MODULE 1

1. Foundry - So basicaly foundry is solidity testing framework(develop,test and deploy smart contracts)
   like in react we use .jsx(javascript+html) for large projects,in web3 we use foundry .sol(for large projects).

Creation - forge init projectName(like in react we use command - vite craete@latest projectName)

Folder Info - src/- write the code for contracts(in .sol),
script/ - write code to deploy the contract(s.sol).
test/ - write the code to test the contract(t.sol).
foundry.toml - same as package.json
lib/ - dependecies like npm package.

2. Commands->
   forge inti - to create project
   forge build - to compile the project,creates /out folder(artifacts like API,bytecode),/cache folder.
   forge test - to test the contract runs every test file.

---

# MODULE 2

1. Anvil - Helps to test contract without ETH.Runs local blockchain on your computer.
   helps in deployment.
   deployment command - forge script script/contractName --rpc-url http://(get from anvil) --private-key
   %(from anvil) --broadcast .
   --rpc-url - tells blockchain which blockchain to connect.
   --broadcast - without this when you deploy contract it's like dry run.

2. Cast - First we deploy the contract using anvil and then we contract address to read and write the contract.
   Also works without deploiyng contract.

3. Chisel REPL - Chisel REPL in Foundry works like Solidity Foundry tools, allowing interactive testing of hardware modules by providing inputs and observing outputs without writing full testbenches.
   Solidity Foundry → test contracts
   Chisel Foundry REPL → test circuits

---

# MODULE 3

1. Testing -> first import dependencies and contract files from src folder,
   setup functions(In Foundry, setUp() runs automatically before each test), and then test functions
   to run test folder files - forge test(run all test files in test folder)
   all test functions must be public or external only.
   to test specific file - forge test --match path
   verbosity - to get more detail of test file how it runse where it fails or pass(max 5 v)

assertEq - is a Foundry assertion(value 1,value 2) checks if value 1 == value 2 if not equals tehn function fails.

2. vm.expectRevert - If next function NOT fails, I will say you are wrong.(for require)

vm.expectRevert(...) - “Hey Foundry, the next function call must FAIL.” (function parameter- bytes("Insuffecient amount"))
bytes("Insuffecient amount") - “And when it fails, it must say: ‘Insuffecient amount’”
next function call - digibank.deposit{value: 0}(0); the contracts checks Is amount > 0 ?(require) - ans:NO
And it stops (this is called revert)
Foundry now checks 👀

Foundry asks:
Did it FAIL? Yes
Did it say "Insuffecient amount"? - Yes
Result- TEST PASSES

3. Test Coverage - How much of your code did your tests actually touch?
   Your contract has 10 lines of code

Tests use 7 lines
Tests do NOT use 3 lines
Coverage = 7 / 10
command to show coverage - forge coverage

4. Cache folder - The failed test functions get stored it cache folder by default and if you want to test only test functions - forge test --rerun (this command runs only test functions which are failed)
   -> to test specific function - forge test --match-test "functionName"

# Module 4

1. Table Testing

Table testing is used when you already know the test cases you want to check. You define a table (called a fixture) that contains multiple sets of input data, and Forge automatically runs the same test function once for each row of that table. This avoids writing many similar test functions and makes tests cleaner and easier to maintain. It is best for testing known scenarios, business logic, and specific conditions.

2. Fuzz Testing

Fuzz testing is a type of property-based testing where you test a general rule instead of specific examples. Forge automatically generates many random input values and runs the same test multiple times to try to break the rule. Any test function that has parameters becomes a fuzz test. It is mainly used to discover edge cases and unexpected bugs that you might not think of manually.

3. vm.assume

vm.assume is used in fuzz tests to restrict which random inputs are allowed. If an input does not satisfy the condition in vm.assume, Forge simply ignores it and tries a new value instead of failing the test. This is useful when some inputs are invalid, meaningless, or would break the test setup rather than the contract logic.

4. Fuzz Fixtures

Fuzz fixtures allow you to force the fuzzer to test specific important values in addition to random ones. They are defined as arrays or functions named with fixture + parameterName. This is helpful when random fuzzing might miss critical values or when certain inputs must be related to each other to reproduce a bug.

5. Invariant Testing

Invariant testing checks rules that must always remain true no matter what sequence of function calls happens. Forge randomly calls contract functions and after each call verifies that the invariant still holds. Unlike fuzz testing, which focuses on inputs and outputs of one function, invariant testing focuses on the overall system state. It is especially useful for testing protocol-level safety and correctness in complex contracts like DeFi systems.

# Module 6

In Ethereum smart contracts, some logic depends on time, such as auctions or vesting schedules. To test these, we use Foundry cheatcodes:

vm.warp – Simulates time travel by moving the blockchain timestamp forward or backward. This allows testing time-based functions without waiting in real life.

vm.expectEmit – Ensures a specific event is emitted during a transaction.

Event logs – Record important actions like bids or auction endings; they are visible off-chain and used to track contract activity.

Time-based logic – Contracts can enforce rules based on block.timestamp, such as only allowing bids before an auction ends or releasing funds after a certain time.

Together, these concepts let developers test time-sensitive contracts efficiently, verify events are emitted correctly, and ensure all logic depending on time works as expected.

# Module 7

In this module we learn what exactly is OpenZeppelin and why we use it.
It is an open source website where ready-made codes,pre built functions,contracts avilable that developer or tester
can reuse instead of writing whole thing from scratch.
It is used by uniswap,Ethereum Foundation etc
it provides ERC20(fungible or interchanagble) which has many pre built functions like totalSupply(),balanaceof(),transfer(),approve(),allowance() etc and pre builts events.
ERC20 includes approval,miniting and burning mechanism.
Then we learned about ERC721(non-fungible NFTs) and then ERC1155(Multi-Token).
OpenZepplin also includes Access control,security modules.

Remapping.txt - file used to import lib in foundry.
