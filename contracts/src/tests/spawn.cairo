#[cfg(test)]
mod tests {
    use starknet::{ContractAddress, contract_address_const, get_caller_address};

    use starknet::testing::{set_block_timestamp};

    // import world dispatcher
    use dojo::world::{IWorldDispatcher, IWorldDispatcherTrait};

    // import test utils
    use dojo::test_utils::{spawn_test_world, deploy_contract};

    use loot_survivor_v2::{
        systems::{
            spawn::{ISpawnDispatcher, ISpawnDispatcherTrait, spawn},
            explore::{IExploreDispatcher, IExploreDispatcherTrait, explore}
        },
        models::{adventurer::{Adventurer, adventurer}}
    };

    struct Systems {
        spawn_system: ISpawnDispatcher,
        explore_system: IExploreDispatcher
    }

    fn setup_world() -> (IWorldDispatcher, Systems) {
        let mut models = array![adventurer::TEST_CLASS_HASH];

        let world = spawn_test_world(models);

        let contract_address = world
            .deploy_contract('salt', spawn::TEST_CLASS_HASH.try_into().unwrap());
        let spawn_system = ISpawnDispatcher { contract_address };

        let contract_address = world
            .deploy_contract('salt', explore::TEST_CLASS_HASH.try_into().unwrap());
        let explore_system = IExploreDispatcher { contract_address };

        (world, Systems { spawn_system, explore_system })
    }

    const ADVENTURER_ID: u32 = 1;

    #[test]
    fn spawn_test() -> (IWorldDispatcher, Systems) {
        let (mut world, mut systems) = setup_world();

        systems.spawn_system.spawn();

        systems.explore_system.explore(ADVENTURER_ID);

        (world, systems)
    }
}
