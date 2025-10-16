# Liquidity Mirage Trap



A custom Drosera trap that detects pools showing fake liquidity ; liquidity that appears briefly and vanishes across blocks.


---

## :package: Prerequisites

1. Install sudo and other pre-requisites :
```bash
apt update && apt install -y sudo && sudo apt-get update && sudo apt-get upgrade -y && sudo apt install curl ufw iptables build-essential git wget lz4 jq make gcc nano automake autoconf tmux htop nvme-cli libgbm1 pkg-config libssl-dev libleveldb-dev tar clang bsdmainutils ncdu unzip libleveldb-dev -y
```
3. Install environment requirements:
Drosera Cli
```bash
curl -L https://app.drosera.io/install | bash
source /root/.bashrc
droseraup
```
Foundry cli
```bash
curl -L https://foundry.paradigm.xyz | bash
source /root/.bashrc
foundryup
```
Bun
```bash
curl -fsSL https://bun.sh/install | bash
source /root/.bashrc
```
   

## :gear: Setup

Clone this repository

```bash
git clone https://github.com/jaywealth10/Liquidity-mirage-trap-.git


cd Liquidity-mirage-trap-.git
```
Compile contract

```bash
forge build
```
Whitelist wallet address
```bash
nano drosera.toml
# Put your EVM public address funded with hoodi ETH in whitelist
e.g ["0xedj..."]  
```
Deploy the trap
```bash
DROSERA_PRIVATE_KEY=xxx drosera apply
```
 Replace xxx with your EVM wallet privatekey (Ensure it's funded with Hoodi ETH, you can claim  from hoodifaucet.io)


# Concept

•Detects sudden liquidity surges in pools

•Tracks whether the liquidity holds across multiple blocks

•Flags pools that remove liquidity too fast — a liquidity mirage

•Useful for bots and researchers avoiding fake liquidity manipulation

# Notes

This project runs on the Hoodi Testnet via Drosera traps.
It’s experimental and built for learning & on-chain analysis purposes only.
