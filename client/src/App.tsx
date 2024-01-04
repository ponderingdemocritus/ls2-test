import { useComponentValue } from "@dojoengine/react";
import { Entity } from "@dojoengine/recs";
import { useEffect, useState } from "react";
import "./App.css";
import { useDojo } from "./DojoContext";
import { Direction } from "./utils";
import { getEntityIdFromKeys } from "@dojoengine/utils";

function App() {
  const {
    setup: {
      systemCalls: { spawn, explore },
      components: { Adventurer, AdventurerOwner },
    },
    account: { account },
  } = useDojo();

  // entity id we are syncing
  const entityId = getEntityIdFromKeys([BigInt(1)]) as Entity;

  const adventurer = useComponentValue(Adventurer, entityId);

  console.log(adventurer);

  return (
    <>
      <div className="h-screen w-screen bg-black text-terminal-green">
        <button
          className="p-3 border-terminal-green border"
          onClick={() => spawn(account)}
        >
          spawn
        </button>

        <button
          className="p-3 border-terminal-green border"
          onClick={() => explore(account, 1)}
        >
          explore
        </button>

        <pre>{JSON.stringify(adventurer, null, 2)}</pre>
      </div>
    </>
  );
}

export default App;
