// define the interface
#[starknet::interface]
trait IExplore<TContractState> {
    fn explore(self: @TContractState, adventurer_id: u32);
}

// dojo decorator
#[dojo::contract]
mod explore {
    use starknet::{ContractAddress, get_caller_address};
    use super::IExplore;

    use loot_survivor_v2::models::adventurer::{Adventurer, ItemPrimitive, Stats, AdventurerOwner};

    // impl: implement functions specified in trait
    #[external(v0)]
    impl ExploreImpl of IExplore<ContractState> {
        // ContractState is defined by system decorator expansion
        fn explore(self: @ContractState, adventurer_id: u32) {
            // Access the world dispatcher for reading.
            let world = self.world_dispatcher.read();

            // Get the caller address.
            let caller = get_caller_address();

            // TODO: Assert that the caller is the owner of the adventurer

            let mut adventurer = get!(world, (adventurer_id), Adventurer);

            adventurer.xp += 1;

            set!(world, (adventurer));
        }
    }
}
