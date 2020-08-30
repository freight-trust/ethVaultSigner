#Calculates an Ethereum specific signature using sign(keccak256("\x19Ethereum Signed Message:\n" + len(message) + 
#message)))."
#
#Adds a prefix to the message that makes the calculated signature recognisable as an Ethereum specific signature. This 
#prevents misuse where a malicious DApp signs arbitrary data (for example a transaction) and uses the signature to 
#impersonate the victim.

#Parameters
#DATA : 20-byte account address

#DATA : data string to sign

curl -X POST --data '{"jsonrpc":"2.0","method":"eth_sign","params":["0x78e6e236592597c09d5c137c2af40aecd42d12a2", "0x2eadbe1f"], "id":1}' http://127.0.0.1:8545
