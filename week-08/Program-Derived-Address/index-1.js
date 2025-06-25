const { PublicKey } = require("@solana/web3.js");
const {
  ASSOCIATED_TOKEN_PROGRAM_ID,
  TOKEN_PROGRAM_ID,
} = require("@solana/spl-token");

// Replace these with your actual values
const userAddress = new PublicKey(
  "HpuFytfNEkqzvnMDAZ13Eb3Cqay6wjZphSGpvZHNKmrF"
);
const tokenMintAddress = new PublicKey(
  "Ed9YpfwwvwBr1zumps6thzF4Amnqvvm9kC1a1CYVwp5A"
);

// Derive the associated token address
const getAssociatedTokenAddress = (mintAddress, ownerAddress) => {
  return PublicKey.findProgramAddressSync(
    [
      ownerAddress.toBuffer(),
      TOKEN_PROGRAM_ID.toBuffer(),
      mintAddress.toBuffer(),
    ],
    ASSOCIATED_TOKEN_PROGRAM_ID
  );
};

const [associatedTokenAddress, bump] = getAssociatedTokenAddress(
  tokenMintAddress,
  userAddress
);
console.log(
  `Associated Token Address: ${associatedTokenAddress.toBase58()}, bump: ${bump}`
);
