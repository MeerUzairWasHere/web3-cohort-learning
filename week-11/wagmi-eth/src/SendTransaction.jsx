import { useSendTransaction } from "wagmi";
import { parseEther } from "viem";
import { useRef } from "react";

export function SendTransaction() {
  const toRef = useRef(null);
  const valueRef = useRef(null);
  const { data: hash, sendTransaction } = useSendTransaction();

  const sendTx = () => {
    const to = toRef.current?.value;
    const value = valueRef.current?.value;
    if (!to || !value) return alert("Please fill all fields");

    sendTransaction({ to, value: parseEther(value) });
  };

  return (
    <div className="section card">
      <h2>Send Transaction</h2>
      <input
        ref={toRef}
        placeholder="Recipient Address (0x...)"
        className="input"
        required
      />
      <input
        ref={valueRef}
        placeholder="Amount (ETH)"
        className="input"
        required
      />
      <button onClick={sendTx} className="btn">
        Send
      </button>
      {hash && <p className="success">Transaction Hash: {hash}</p>}
    </div>
  );
}
