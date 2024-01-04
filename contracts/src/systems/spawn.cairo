// define the interface
#[starknet::interface]
trait ISpawn<TContractState> {
    fn spawn(self: @TContractState);
}

// dojo decorator
#[dojo::contract]
mod spawn {
    use starknet::{ContractAddress, get_caller_address};
    use super::ISpawn;

    use loot_survivor_v2::models::adventurer::{Adventurer, ItemPrimitive, Stats, AdventurerOwner};

    // impl: implement functions specified in trait
    #[external(v0)]
    impl SpawnImpl of ISpawn<ContractState> {
        // ContractState is defined by system decorator expansion
        fn spawn(self: @ContractState) {
            // Access the world dispatcher for reading.
            let world = self.world_dispatcher.read();

            // Get the caller address.
            let caller = get_caller_address();

            let stats = Stats {
                strength: 1,
                dexterity: 1,
                vitality: 1,
                intelligence: 1,
                wisdom: 1,
                charisma: 1,
                luck: 1
            };

            let item = ItemPrimitive { id: 1, xp: 1, metadata: 1 };

            let adventurer = Adventurer {
                adventurer_id: 1,
                last_action_block: 1, // 9 bits
                health: 1, // 9 bits
                xp: 1, // 13 bits
                stats: stats, // 24 bits
                gold: 1, // 9 bits
                weapon: item, // 21 bits
                chest: item, //item21 bits
                head: item, // 21 bits
                waist: item, // 21 bits
                foot: item, // 21 bits
                hand: item, // 21 bits
                neck: item, // 21 bits
                ring: item, // 21 bits
                beast_health: 1, // 9 bits
                stat_points_available: 1, // 3 bits
                actions_per_block: 1,
                mutated: false,
            };

            let owner = AdventurerOwner { adventurer_id: 1, owner: caller };

            set!(world, (adventurer, owner));
        }
    }
}
