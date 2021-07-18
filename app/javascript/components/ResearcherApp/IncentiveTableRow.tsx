import * as React from "react";

interface Props {
  data: Incentive;
}
export const IncentiveTableRow: React.FC<Props> = ({ data }) => {
  return (
    <tr className={data.redeemed ? "bg-green-200" : "bg-blue-200"}>
      <td className="border-collapse border text-center">{data.code}</td>
      <td className="border-collapse border text-center">
        {data.redeemed ? "Yes" : "No"}
      </td>
    </tr>
  );
};
