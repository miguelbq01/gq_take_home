import * as React from "react";
import { useState } from "react";
import { createIncentive } from "@api/endpoints";
import { IncentiveTable } from "./IncentiveTable";

interface Props {
  data: Incentive[];
}
export const IncentiveForm: React.FC<Props> = ({ data }) => {
  const [saving, setSaving] = useState(false);
  const [message, setMessage] = useState("");
  const [inputValue, setInputValue] = useState("");
  const [tableData, setTableData] = useState<Incentive[]>(data);

  async function handleClickSave() {
    if (inputValue) {
      setSaving(true);
      const incentive = await createIncentive({ code: inputValue });
      if (incentive) {
        setTableData(incentive);
        setInputValue("");
        setMessage("Successfully created!");
      } else {
        setMessage("Code already on the list, please enter another code");
      }
      setSaving(false);
    } else {
      setMessage("Enter a code before!");
    }
    setTimeout(() => setMessage(""), 2000);
  }

  function createRandomCode() {
    const code = Math.ceil(Math.random() * 999999)
      .toString()
      .padStart(6, "0");
    setInputValue(code);
  }

  return (
    <div>
      <div className="flex space-x-2 pb-4">
        <input
          disabled={saving}
          className="text-xl border"
          type="text"
          name="incentive_code"
          value={inputValue}
          onChange={e => setInputValue(e.currentTarget.value)}
        />
        <button
          className="hover:bg-gray-100 bg-gray-200 rounded-md px-4 py-2"
          onClick={createRandomCode}
        >
          Random Code
        </button>
        <button
          disabled={saving}
          className="hover:bg-gray-100 bg-gray-200 rounded-md px-4 py-2"
          onClick={handleClickSave}
        >
          Save
        </button>
      </div>
      <IncentiveTable data={tableData} />
      {message && <div className="text-gray-600 italic">{message}</div>}
    </div>
  );
};
