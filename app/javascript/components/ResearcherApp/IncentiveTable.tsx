import * as React from "react";
import { useState } from "react";
import { updateIncentive, getIncentives } from "@api/endpoints";
import { IncentiveTableRow } from "./IncentiveTableRow";

interface Props {
  data: Incentive[];
}
export const IncentiveTable: React.FC<Props> = ({ data }) => {
  return (
    <div className="flex">
      <div className="flex-1 pb-4">
        <table className="table-fixed border-collapse border" id="code_table">
          <thead>
            <tr>
              <th className="w-1/4 border-collapse border bg-blue-300">Code</th>
              <th className="w-1/4 border-collapse border bg-blue-300">
                Redeemed
              </th>
            </tr>
          </thead>
          <tbody>
            {data.map((object, i) => (
              <IncentiveTableRow data={object} key={i} />
            ))}
          </tbody>
        </table>
      </div>
      {/* {message && <div className="text-gray-600 italic">{message}</div>} */}
    </div>
  );
};
