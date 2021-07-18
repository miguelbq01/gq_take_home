import * as React from "react";
import { useState } from "react";
import { getIncentiveCode } from "@api/endpoints";

export const Redeem: React.FC = () => {
  const [redeemed, setRedeemed] = useState(false);
  const [noCodeAvailable, setNoCodeAvailable] = useState(false);
  const [selected, setSelected] = useState("");

  async function handleClickRedeem() {
    setRedeemed(false);
    setNoCodeAvailable(false);
    const incentive = await getIncentiveCode();
    if (incentive) {
      setRedeemed(true);
      setSelected(incentive.code);
    } else {
      setNoCodeAvailable(true);
    }
  }

  return (
    <div>
      <div className="pb-4">
        <button
          className="hover:bg-gray-100 bg-gray-200 rounded-md px-4 py-2"
          onClick={handleClickRedeem}
        >
          Redeem
        </button>
      </div>

      {redeemed && (
        <div className="py-4 text-green-600 italic">
          Your code is: {selected}. Thanks for participating in our research!
        </div>
      )}
      {noCodeAvailable && (
        <div className="py-4 text-red-600 italic">
          There are no more codes available!
        </div>
      )}
    </div>
  );
};
