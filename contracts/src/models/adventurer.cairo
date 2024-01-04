use starknet::ContractAddress;

const GAME_CONFIG_GAME: felt252 = 'game_config_game';

#[derive(Copy, Drop, Serde, Introspect)]
struct Stats { // 24 storage bits
    strength: u8, // 4 bits
    dexterity: u8, // 4 bits
    vitality: u8, // 4 bits
    intelligence: u8, // 4 bits
    wisdom: u8, // 4 bits
    charisma: u8, // 4 bits
    luck: u8
}

#[derive(Copy, Drop, Serde, Introspect)]
struct ItemPrimitive { // 21 storage bits
    id: u8, // 7 bits
    xp: u16, // 9 bits
    metadata: u8, // 5 bits
}

#[derive(Model, Copy, Drop, Serde)]
struct Adventurer {
    #[key]
    adventurer_id: u32,
    last_action_block: u16, // 9 bits
    health: u16, // 9 bits
    xp: u16, // 13 bits
    stats: Stats, // 24 bits
    gold: u16, // 9 bits
    weapon: ItemPrimitive, // 21 bits
    chest: ItemPrimitive, // 21 bits
    head: ItemPrimitive, // 21 bits
    waist: ItemPrimitive, // 21 bits
    foot: ItemPrimitive, // 21 bits
    hand: ItemPrimitive, // 21 bits
    neck: ItemPrimitive, // 21 bits
    ring: ItemPrimitive, // 21 bits
    beast_health: u16, // 9 bits
    stat_points_available: u8, // 3 bits
    actions_per_block: u8, // 4 bits
    mutated: bool, // not packed
}

#[derive(Model, Drop, Copy)]
struct AdventurerOwner {
    #[key]
    adventurer_id: u32,
    owner: ContractAddress,
}

