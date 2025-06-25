const { PublicKey } = require('@solana/web3.js');
const { ASSOCIATED_TOKEN_PROGRAM_ID, TOKEN_PROGRAM_ID } = require('@solana/spl-token');

// Replace these with your actual values
const userAddress = new PublicKey(
  "HpuFytfNEkqzvnMDAZ13Eb3Cqay6wjZphSGpvZHNKmrF"
);
const tokenMintAddress = new PublicKey(
  "Ed9YpfwwvwBr1zumps6thzF4Amnqvvm9kC1a1CYVwp5A"
);
const PDA = PublicKey.createProgramAddressSync(
  [userAddress.toBuffer(), TOKEN_PROGRAM_ID.toBuffer(), tokenMintAddress.toBuffer(), Buffer.from([253])],
  ASSOCIATED_TOKEN_PROGRAM_ID,
);
 
console.log(`PDA: ${PDA}`);