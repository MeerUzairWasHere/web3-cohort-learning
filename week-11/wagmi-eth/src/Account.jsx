import { useAccount, useBalance, useDisconnect } from "wagmi";

export function Account() {
  const { address } = useAccount();
  const { disconnect } = useDisconnect();
  const { data: balance } = useBalance({ address });

  if (!address) return null;

  return (
    <div className="section card">
      <h2>Account Info</h2>
      <p>
        <strong>Address:</strong> <span className="mono">{address}</span>
      </p>
      <p>
        <strong>Balance:</strong> {balance?.formatted} {balance?.symbol}
      </p>
      <button onClick={disconnect} className="btn red">
        Disconnect
      </button>
    </div>
  );
}
