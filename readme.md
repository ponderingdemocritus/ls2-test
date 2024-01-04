## Test

### Contracts

1. Install dojoup

`curl -L https://install.dojoengine.org | bash`

```
cd contracts
```

Terminal 1:
`katana --disable-fee`

Terminal 2:
`sozo build && sozo migrate`

`torii --world 0xd8cbf7200bdc54416770a5e67f00cce550d48fd3d0721ca7c9332cca385aa0`

### Client

You will need to have complete the dojoup parts so the manifest is created.

1. install bun

```
bun install

bun run dev
```
