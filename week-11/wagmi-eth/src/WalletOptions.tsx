import React from "react";
import { useConnect } from "wagmi";

export function WalletOptions() {
  const { connectors, connect } = useConnect();

  return (
    <div className="section">
      <h2>Connect Wallet</h2>
      <div className="button-group">
        {connectors.map((connector) => (
          <button
            key={connector.uid}
            onClick={() => connect({ connector })}
            className="btn"
          >
            {connector.name}
          </button>
        ))}
      </div>
    </div>
  );
}
