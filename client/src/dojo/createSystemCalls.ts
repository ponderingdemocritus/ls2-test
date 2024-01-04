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
    const entityId = getEntityIdFromKeys([BigInt(signer.address)]) as Entity;

    const positionId = uuid();
    Position.addOverride(positionId, {
      entity: entityId,
      value: { player: BigInt(entityId), vec: { x: 10, y: 10 } },
    });

    const movesId = uuid();
    Moves.addOverride(movesId, {
      entity: entityId,
      value: {
        player: BigInt(entityId),
        remaining: 100,
        last_direction: 0,
      },
    });

    try {
      const { transaction_hash } = await execute(
        signer,
        "actions",
        "spawn",
        []
      );

      setComponentsFromEvents(
        contractComponents,
        getEvents(
          await signer.waitForTransaction(transaction_hash, {
            retryInterval: 100,
          })
        )
      );
    } catch (e) {
      console.log(e);
    }
  };

  return {
    spawn,
  };
}
