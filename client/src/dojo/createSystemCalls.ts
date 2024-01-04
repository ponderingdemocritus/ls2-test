import { SetupNetworkResult } from "./setupNetwork";
import { Account } from "starknet";
import { Entity, getComponentValue } from "@dojoengine/recs";
import { uuid } from "@latticexyz/utils";
import { ClientComponents } from "./createClientComponents";
import { Direction, updatePositionWithDirection } from "../utils";
import {
  getEntityIdFromKeys,
  getEvents,
  setComponentsFromEvents,
} from "@dojoengine/utils";

export type SystemCalls = ReturnType<typeof createSystemCalls>;

export function createSystemCalls(
  { execute, contractComponents }: SetupNetworkResult,
  { Position, Moves }: ClientComponents
) {
  const spawn = async (signer: Account) => {
    try {
      await execute(signer, "spawn", "spawn", []);
    } catch (e) {
      console.log(e);
    }
  };

  const explore = async (signer: Account, adventurer_id: number) => {
    try {
      await execute(signer, "explore", "explore", [adventurer_id]);
    } catch (e) {
      console.log(e);
    }
  };

  return {
    spawn,
    explore,
  };
}
