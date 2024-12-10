# Carnivores Flake

Run all the old Carnivores games using Nix flakes.

The flake will handle the download, extraction and wine setup for you.

## How to play

Each game can be launched by running this flake:

```sh
nix run github:lonyelon/carnivores-flake#<game>
```

For example, to play Carnivores 2 you must run:
```sh
nix run github:lonyelon/carnivores-flake#carn2
```

The full list of games provided is attached below:

<table>
  <tr>
    <th>Name in flake</th>
    <th>Game</th>
    <th>Modifications</th>
  </tr>
  <tr>
    <th><code>carn1</code></th>
    <th>Carnivores (1998)</th>
    <th></th>
  </tr>
  <tr>
    <th><code>carn2</code></th>
    <th>Carnivores 2 (1999)</th>
    <th>
      Carnivores 2 with (almost) infinite money (read next section for the explanation).
    </th>
  </tr>
  <tr>
    <th><code>carn2Dense</code></th>
    <th>Carnivores 2 (1999)</th>
    <th>
      Same as <code>carn2</code> plus increased monsters' spawn rate,
      sensitivity and aggresivity beyond normal limits.</th>
  </tr>
  <tr>
    <th><code>iceAge</code></th>
    <th>Carnivores Ice Age (2001)</th>
    <th>Same as <code>carn2</code>.</th>
  </tr>
  <tr>
    <th><code>iceAgeDense</code></th>
    <th>Carnivores Ice Age (2001)</th>
    <th>Same as <code>carn2Dense</code>.</th>
  </tr>
  <tr>
    <th><code>iceAgeSergioCustom</code></th>
    <th>Carnivores Ice Age (2001)</th>
    <th>
      Same as <code>iceAgeDense</code> with a more dangerous Smilodon (Omega Smilodon),
      a rifle with almost infinite ammo (Omega Rifle)
      and all small enemies instantly dieing.</th>
  </tr>
</table>

## Note on Nix

Since this games store their savefiles along with their binaries, progression is impossible on Nix.
Savefiles cannot be created nor deleted, money cannot be earned, settings cannot be changed and trophies are not saved.

To make the games playable, I have added a default savefile with all the money you will ever need, alongside sane settings.
This solves *most* problems, except the trophy room issue, which I do not expect to fix.

## Legal disclaimer

I am not the rights holder to the Carnivores franchise, but:
1. This games are abandonware from decades ago.
2. I am not hosting the files containing the game.

I love this games so I want to make them accessible to more people.

If you are the rights holder for the franchise and want this flake taken down, please contact me and I will remove it from GitHub.
