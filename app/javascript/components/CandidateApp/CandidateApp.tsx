import * as React from "react";
import { Redeem } from "./Redeem";

export const CandidateApp: React.FC = () => {
  return (
    <div className="px-12 py-6">
      <h1 className="text-2xl font-bold mb-6">Redeem incentive</h1>
      <Redeem />
    </div>
  );
};
