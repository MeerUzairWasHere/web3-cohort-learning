import { QueryClient, QueryClientProvider } from "@tanstack/react-query";
import { WagmiProvider } from "wagmi";
import { config } from "./config";
import { WalletOptions } from "./WalletOptions";
import { Account } from "./Account";
import { SendTransaction } from "./SendTransaction";
import "./App.css";

const queryClient = new QueryClient();

function App() {
  return (
    <WagmiProvider config={config}>
      <QueryClientProvider client={queryClient}>
        <div className="container">
          <h1>🚀 Web3 Wallet Demo</h1>
          <WalletOptions />
          <Account />
          <SendTransaction />
        </div>
      </QueryClientProvider>
    </WagmiProvider>
  );
}

export default App;
